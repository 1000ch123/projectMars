//processing_max connecting_func
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myLocation;
final int sendAddress = 12000;
final int recieveAddress = 12001;

void setupOsc(){
	oscP5 = new OscP5(this, recieveAddress);
	myLocation = new NetAddress("127.0.0.1",sendAddress);
}

void sendData(int x){
	OscMessage mes = new OscMessage("/ts");
	mes.add(x);
	oscP5.send(mes,myLocation);
}

void sendData(float x){
	OscMessage mes = new OscMessage("/test");
	mes.add(x);
	oscP5.send(mes,myLocation);
}

/*
float oscEvent(OscMessage theOscMessage){
	float value = 0;
	if( (theOscMessage.typetag()length > 0 )&& (theOscMessage.typetag().startwith("f"))){
		OscArgument arg = theOscMessage.get(0);
		value = arg.floatvalue();
	}
	return value;
}
*/
