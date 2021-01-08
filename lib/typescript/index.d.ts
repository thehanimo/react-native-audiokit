declare type RNAudioKitType = {
    getDuration(file: string): Promise<string>;
    trim(file: string, start: number, end: number): Promise<string>;
};
declare const _default: RNAudioKitType;
export default _default;
