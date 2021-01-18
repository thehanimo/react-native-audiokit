import * as React from 'react';
import {TouchableOpacity} from 'react-native';

import {StyleSheet, View, Text, Alert} from 'react-native';
import RNAudioKit from '@thehanimo/react-native-audiokit';
import DocumentPicker from 'react-native-document-picker';
import Share from 'react-native-share';
import MultiSlider from '@ptomasroos/react-native-multi-slider';
import {ActivityIndicator} from 'react-native';
const RNFS = require('react-native-fs');

export default function App() {
  const [file, setFile] = React.useState();
  const [key, setKey] = React.useState();
  const [duration, setDuration] = React.useState();
  const [trimStart, setTrimStart] = React.useState(0);
  const [trimEnd, setTrimEnd] = React.useState();
  const [isProcessing, setIsProcessing] = React.useState(false);

  const pickFile = async () => {
    try {
      const res = await DocumentPicker.pick({
        type: [DocumentPicker.types.audio],
      });
      setFile(res);
      processFile(res);
    } catch (err) {
      if (DocumentPicker.isCancel(err)) {
        // User cancelled the picker, exit any dialogs or menus and move on
      } else {
        throw err;
      }
    }
  };

  const processFile = (res) => {
    const uid = (+new Date() + Math.random() * 100).toString(32) + res.name;
    setKey(uid);
    RNFS.moveFile(res.uri, RNFS.DocumentDirectoryPath + '/' + uid)
      .then(() => {
        RNAudioKit.getDuration(uid).then(setDuration);
      })
      .catch(Alert.alert);
  };

  const trimFile = () => {
    return new Promise((res, rej) => {
      RNAudioKit.trim(key, trimStart, trimEnd || duration)
        .then((out) => {
          res(out);
        })
        .catch(rej);
    });
  };

  const exportFile = () => {
    setIsProcessing(true);
    trimFile()
      .then((trimmedFile) => {
        Share.open({
          url: RNFS.DocumentDirectoryPath + '/' + trimmedFile,
        })
          .then(() => {})
          .catch(() => {})
          .finally(() => setIsProcessing(false));
      })
      .catch(() => {});
  };

  return (
    <View style={styles.container}>
      <TouchableOpacity
        style={{...styles.button, backgroundColor: '#d0e8f2'}}
        onPress={pickFile}>
        <Text numberOfLines={1}>
          {file ? 'File: ' + file.name : 'Pick a file'}
        </Text>
      </TouchableOpacity>
      {duration && (
        <>
          <MultiSlider
            values={[0, 100]}
            sliderLength={200}
            max={100}
            onValuesChange={(arr) => {
              setTrimStart((arr[0] * duration) / 100);
              setTrimEnd((arr[1] * duration) / 100);
            }}
          />
          <View style={styles.trimLabel}>
            <Text>{Math.round(trimStart)}</Text>
            <Text>{Math.round(trimEnd || duration)}</Text>
          </View>
        </>
      )}
      <TouchableOpacity
        style={{...styles.button, backgroundColor: '#456268'}}
        onPress={exportFile}
        disabled={!file}>
        <Text style={{color: '#eee'}}>
          {isProcessing ? <ActivityIndicator /> : 'Trim & Share file'}
        </Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#fcf8ec',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
  button: {
    width: 200,
    height: 60,
    borderRadius: 60,
    marginVertical: 20,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 16,
  },
  trimLabel: {
    width: 200,
    height: 60,
    borderRadius: 60,
    alignItems: 'center',
    justifyContent: 'space-between',
    flexDirection: 'row',
    padding: 0,
    marginTop: 0,
    marginBottom: 20,
  },
});
