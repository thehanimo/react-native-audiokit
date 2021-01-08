import { NativeModules } from 'react-native';

type RNAudioKitType = {
  getDuration(file: string): Promise<string>;
  trim(file: string, start: number, end: number): Promise<string>;
};

const { RNAudioKit } = NativeModules;

export default RNAudioKit as RNAudioKitType;
