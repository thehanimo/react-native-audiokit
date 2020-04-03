# react-native-audiokit

## ⚠️ iOS ONLY

This package simply wraps up the AudioKit iOS package. Made this as I couldn't find any proper react-native audio trimming or processing module. Right now, this package only supports trimming. However with AudioKit, the possibilities are endless. [Take a look here!](http://audiokit.io/)

## Getting started

`$ npm install @thehanimo/react-native-audiokit --save`
or
`$ yarn add @thehanimo/react-native-audiokit`

### Mostly automatic installation

`$ react-native link @thehanimo/react-native-audiokit`

## Usage

```javascript
import RNAudioKit from "@thehanimo/react-native-audiokit";

let newFileName = await RNAudioKit.trimAudio("filename.mp3", 0, 10); // 0 - start sec, 10 - end sec.
// NOTE: filename.mp3 must be located in the documents folder. Not temp.
// newFileName will give you only the name. Append it to the documents directory path.
```
