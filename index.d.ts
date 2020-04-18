declare module "@thehanimo/react-native-audiokit" {
  function trimAudio(
    fileName: string,
    startTime: number,
    endTime: number
  ): Promise<string>;
}
