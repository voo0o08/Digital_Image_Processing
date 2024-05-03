# Digital_Image_Processing
![image](https://github.com/voo0o08/Digital_Image_Processing/assets/155411941/f88e3911-0a7a-4d03-b341-2f13dc023ab9)

## 영상 데이터 처리 수업 내용 
- image resizing
- image equalization
- image filtering
- image phase / spectrum
- image filtering in frequency domain
- image color space

## 프로젝트 : 이미지 super resolution

<img width="491" alt="image" src="https://github.com/voo0o08/Digital_Image_Processing/assets/155411941/fe04f182-1c4a-4788-962a-f42f0fb98683">

위 표는 공간영역에서 내장함수와 이론에 기반하여 구현한 함수로 이미지를 확대한 결과를 나타낸다.
- NN은 구현이 간단하고 처리 속도가 빠르지만 scale factor를 2로 해도 영상의 block 현상이 나타났고, 자연히 factor값이 커질수록 block이 심해졌다.
- Bilinear는 4개의 픽셀을 참조하여 nn보다 깨긋하고, block 현상이 두드러지지않는 결과를 얻을 수 있었다.
- Bicubic은 내장함수보다 고화질의 출력을 얻을 수 있었지만, 연산 시간이 다른 구현함수에 비해 오래 걸렸다. 

화질 Bicubic > Bilinear > NN

연산시간 Bicubic > Bilinear > NN
