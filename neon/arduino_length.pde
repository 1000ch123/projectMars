/*
2012/05/14
SHARP‘ª‹—ƒZƒ“ƒT GP2Y0A21YK0F
„§ƒŒƒ“ƒW[10cm - 80cm]
*/

import processing.funnel.*;

Arduino arduino;

final float THRESHOLD = 0.08;
Pin sensorPinL;
Pin sensorPinR;

void setupArduino(){
	arduino = new Arduino(this, Arduino.FIRMATA);
	sensorPinL = arduino.analogPin(0);
	sensorPinR = arduino.analogPin(1);
}

float getLengthR(){
	float value = sensorPinR.value;
	int l = 0;
	if(value > THRESHOLD){
		l = round(24.0/(5*value-0.1));
	}
	return l;
}

float getLengthL(){
	float value = sensorPinL.value;
	int l =0;
	if(value > THRESHOLD){
		l = round(24.0/(5*value-0.1));
	}
	return l;
}

void showLength(){
	println("R: " + getLengthR() + " L: " + getLengthL());
}
