# react-native-audiokit

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![star this repo](https://img.shields.io/github/stars/thehanimo/react-native-audiokit?style=flat-square)](https://github.com/thehanimo/react-native-audiokit)
[![NPM Version](https://img.shields.io/npm/v/@thehanimo/react-native-audiokit.svg?style=flat-square)](https://www.npmjs.com/package/@thehanimo/react-native-audiokit)
[![iOS Only](https://img.shields.io/badge/‎iOS%20Only--green?logo=apple&style=social)](https://www.npmjs.com/package/@thehanimo/react-native-audiokit)

This package simply wraps up the [**AudioKit**](https://github.com/AudioKit/AudioKit) iOS package. Made this as we couldn't find any proper react-native audio trimming or processing module. Right now, this package only supports trimming audio files. However with AudioKit, the possibilities are endless. [Take a look here!](http://audiokit.io/)

In case you need a new feature added to this project, raise an issue or reach out to us at [thehanimo@gmail.com](mailto:thehanimo@gmail.com)

<p align="center">
   <a href="https://nodestory.com" target="_blank">
      <img src="https://i.imgur.com/M1iuH1t.gif" title="Nodestory's trimming functionality"/>
   </a>
   <h6 align="center"><a href="https://nodestory.com" target="_blank">Nodestory</a> uses this module!</h6>
</p>

## Platforms Supported

- [x] iOS
- [ ] Android

## Installation (React Native >= 0.60.0)

1. Install the package
   `yarn add @thehanimo/react-native-audiokit`
   or
   `npm install @thehanimo/react-native-audiokit`

2. Install pods

```
cd ios
pod install
cd ..
```

## Installation (React Native <= 0.59.0)

1. Install the package
   `yarn add @thehanimo/react-native-audiokit@1`
   or
   `npm install @thehanimo/react-native-audiokit@1`

2. Link the package
   `react-native link @thehanimo/react-native-audiokit`

## Usage

```javascript
import RNAudioKit from "@thehanimo/react-native-audiokit";

let newFileName = await RNAudioKit.trimAudio("filename.mp3", 0, 10); // 0 - start sec, 10 - end sec.
// NOTE: filename.mp3 must be located in the documents folder. Not temp.
// newFileName will give you only the name. Append it to the documents directory path.
```

## License

MIT