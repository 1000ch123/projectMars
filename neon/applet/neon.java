import processing.core.*; 
import processing.xml.*; 

import oscP5.*; 
import netP5.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class neon extends PApplet {

//2012/05/13
//\ufffdE\ufffdE\ufffdE\ufffdl\ufffdE\ufffdI\ufffdE\ufffd\ufffdE\ufffd\ufffdE\ufffd\ufffdE\ufffd\\ufffdE\ufffd\ufffdE\ufffd
//\ufffdE\ufffdE\ufffdE\ufffdl\ufffdE\ufffdI\ufffdE\ufffd\ufffdE\ufffd\ufffdE\ufffd\ufffdE\ufffd\ufffdE\ufffdp\ufffdE\ufffd`
//\ufffdE\ufffdE\ufffdE\ufffdN\ufffdE\ufffd\ufffdE\ufffd\ufffdE\ufffdb\ufffdE\ufffdN\ufffdE\ufffd\u0292u\ufffdE\ufffd\\ufffdE\ufffd\ufffdE\ufffd
//\ufffdE\ufffdE\ufffdE\ufffdC\ufffdE\ufffd\ufffdE\ufffd\ufffdE\ufffd{\ufffdE\ufffd\ufffdE\ufffd\ufffdE\ufffd\ufffdE\ufffd\ufffdE\ufffd[\ufffdE\ufffdg\ufffdE\ufffd\u0210\ufffd\u0143t\ufffdE\ufffdF\ufffdE\ufffd[\ufffdE\ufffdh\ufffdE\ufffdA\ufffdE\ufffdE\ufffdE\ufffdg
//\ufffdE\ufffdE\ufffdE\ufffdz\ufffdE\ufffd\ufffdE\ufffd


//global valiable
float w;
involuteLine[] list;
int tmp_l;
int cnt;
final int NEW_OBJ_THRES = 8;
final int OBJ_NUM = 50;
final int WIDTH = 640;
final int HEIGHT = 640;
final int NEON_LEVEL = 60;
final int FADE_LEVEL = 30;
final int RND_LINE_WID = 15;
 
public void setup(){
	size(WIDTH,HEIGHT);
	//size(screen.width, screen.height);
	smooth();
	frameRate(30);
	background(0);
	noStroke();
	noCursor();
	rectMode(CENTER);
	list = new involuteLine[OBJ_NUM];
	for(int i=0;i<list.length;i++){
		list[i] = new involuteLine();
	}
	tmp_l = 0;
	cnt = 0;
	setupSelSound(width/2, height/2);
	setupOsc();
}

public void draw(){
	fill(255);
	fade();
	SS.calcInfo(mouseX,mouseY);
	SS.showData();
	SS.sendFreq();
	for(int i = 0;i<list.length;i++){
		list[i].update();
	}
	int c = randomColor();
	drawNeonNpolygon(10,mouseX,mouseY,5,10,c);
}

public void mousePressed(){
	list[tmp_l] = new involuteLine(mouseX,mouseY);
	tmp_l = (tmp_l + 1) % list.length;
	drawRandomLine(mouseX,mouseY);
}

public void mouseDragged(){
	drawRandomLine(mouseX,mouseY);
	cnt++;
	if(cnt > NEW_OBJ_THRES){
		list[tmp_l] = new involuteLine(mouseX,mouseY);
		tmp_l = (tmp_l + 1) % list.length;
		cnt = 0;
	}
}

public void mouseReleased(){
	cnt = 0;
}
//\ufffdE\ufffd\u0209\ufffd\ufffdE\ufffdE\ufffdE\ufffd`\ufffdE\ufffd\ufffdE\ufffdp\ufffdE\ufffd\u0590\ufffd

public void fade(){
	fill(0,0,0,FADE_LEVEL);
	rect(width/2,height/2,width,height);
}

public void drawRandomLine(int x, int y){
	float theta;
	int c;
	theta = 2 * PI * random(1);
	pushMatrix();
	translate(mouseX,mouseY);
		rotate(theta);
		//c = color(random(100,255),random(100,255),random(100,255));
		c = randomColor(150,255);
		drawNeonCircle(0,0,random(50,200),10,c);
		drawNeonLine1(RND_LINE_WID,width*3,c);
		rotate(random(0,HALF_PI));
		drawNeonLine1(RND_LINE_WID,width*3,c);
	popMatrix();
}

public void drawNeonLine1(float wid, float len,int c){
	rectMode(CENTER);
	fill(255,255,255);
	rect(0,0,wid/2,len);
	fill(c,NEON_LEVEL);
	rect(0,0,wid,len);
}

public int randomColor(){
	int c;
	c = color(random(255),random(255),random(255));
	return c;
}
public int randomColor(int x,int y){
	int c;
	c = color(random(x,y),random(x,y),random(x,y));
	return c;
}

public void drawNeonLine(float x1,float y1,float x2,float y2,float wid,int c){
	rectMode(CORNER);
	float l = sqrt(sq(x2-x1) + sq(y2-y1));
	float theta = atan2((y2-y1),(x2-x1));
	pushMatrix();
		translate(x1,y1);
		rotate(theta);
		fill(255);
		rect(0,-wid/4,l,wid/2);
		fill(c,NEON_LEVEL);
		rect(0,-wid/2,l,wid);
	popMatrix();
	rectMode(CENTER);
}

public void drawNeonNpolygon(int N,float x0, float y0, float r,float wid,int c){
	pushMatrix();
		float _x,_y,_xp,_yp;
		translate(x0,y0);
		_xp = r; _yp = 0;
		for(int i =0;i<N+1;i++){
			_x = r*cos(i * TWO_PI/(float)N);
			_y = r*sin(i * TWO_PI/(float)N);
			drawNeonLine(_xp,_yp,_x,_y,wid,c);
			_xp = _x;
			_yp = _y;
		}
	popMatrix();
}

public void drawNeonTriangle(float x, float y, float r, float wid, int c){
	drawNeonNpolygon(3,x,y,r,wid,c);
}
public void drawNeonSquare(float x, float y, float r, float wid, int c){
	drawNeonNpolygon(4,x,y,r,wid,c);
}
public void drawNeonCircle(float x, float y, float r, float wid, int c){
	drawNeonNpolygon(100,x,y,r,wid,c);
}
final float R_UP = 5.0f;
final float THETA_UP = 0.1f;

final float OBJ_R_UP = 5;
final float OBJ_THETA_UP = 0.3f;
final float OBJ_FADE_LEVEL = 95.0f;

class involuteLine{
	//root info
	float _x,_x0;
	float _y,_y0;
	float _r;
	float _theta;
	//obj_info
	float _obj_r;
	int _c;
	float _obj_theta;
	int _obj_poly;

	involuteLine(int x, int y, float r, int c){
		_x0 = x;
		_y0 = y;
		_r = 1;
		_theta = 0;
		_obj_r = r;
		_c  = c;
		_obj_poly = floor(random(3,10));
		_obj_theta = 0;
	}
	
	involuteLine(int x, int y){
		_x0 = x;
		_y0 = y;
		_r = 20;
		_theta = random(TWO_PI);
		_obj_r = random(1,10);
		_c = color(random(100,255),random(100,255),random(100,255));	
		_obj_poly = floor(random(3,11));
		_obj_theta = 0;
	}
	
	involuteLine(){
		_x0 = 0;
		_y0 = 0;
		_r = 0;
		_theta = 0;
		_obj_r = 0;
		_c  = color(0,0,0,0);
		_obj_poly = 0;
		_obj_theta = 0;
	}
	
	public void update(){
		this.updatePos();
		this.updateObj();
		this.updatePoint();
	}
	
	private void updateObj(){
		_obj_r += OBJ_R_UP;
		_obj_theta += OBJ_THETA_UP;
		//_c = color(_c,OBJ_FADE_LEVEL);
	}
	
	private void updatePos(){
		_x = _r * (cos(_theta) + _theta * sin(_theta));
		_y = _r * (sin(_theta) - _theta * cos(_theta));
		_theta += THETA_UP;
		_r += R_UP;
	}
	
	private void drawObj(){
		pushMatrix();
			translate(_x,_y);
			rotate(_obj_theta);
			drawNeonNpolygon(_obj_poly,0,0,_obj_r,10,_c);
		popMatrix();
	}
	
	private void drawNObj(int N){
		for(int i=0;i<N;i++){
			pushMatrix();
				float theta = i*TWO_PI/(float)N;
				rotate(theta);
				this.drawObj();
			popMatrix();
		}
	}

	private void updatePoint(){
		pushMatrix();
			translate(_x0,_y0);
			this.drawNObj(_obj_poly);
		popMatrix();
	}
}
//processing_max connecting_func



OscP5 oscP5;
NetAddress myLocation;
final int sendAddress = 12000;
final int recieveAddress = 12001;

public void setupOsc(){
	oscP5 = new OscP5(this, recieveAddress);
	myLocation = new NetAddress("127.0.0.1",sendAddress);
}

public void sendData(int x){
	OscMessage mes = new OscMessage("/ts");
	mes.add(x);
	oscP5.send(mes,myLocation);
}

public void sendData(float x){
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
//select Sound;
selSound SS;

public void setupSelSound(float x, float y){
	SS = new selSound(x,y);
	SS.showData();
}

class selSound{
	float _x,_y;
	float _xp,_yp;
	float _x0,_y0;
	float _r;
	float _theta;
	float _baseFreq;
	float _freq;
	
	selSound(float x, float y){
		_x = 0;
		_y = 0;
		_xp = 0;
		_yp = 0;
		_x0 = x;
		_y0 = y;
		_r = 0;
		_theta = 0;
		_baseFreq = 440;
		_freq = _baseFreq;
	}
	
	public void showData(){
		print("x: " + _x);
		print(" x0: " + _x0);
		print(" y: " + _y);
		print(" y0: " + _y0);
		print(" r: " + _r);
		print(" theta: " + _theta);
		print(" bfreq: " + _baseFreq);
		print(" freq: " + _freq);
		print("\n");
	}
	
	public void calcInfo(float tmpx, float tmpy){
		this.updatePos(tmpx,tmpy);
		this.calcRadius();
		this.calcTheta();
		this.baseCheck();
		this.calcFreq();
	}

	public void updatePos(float tmp_x, float tmp_y){
		_xp = _x; _yp = _y;
		_x = tmp_x; _y = tmp_y;
	}
		
	private void calcRadius(){
		_r = sqrt(sq(_x0-_x) + sq(_y0 - _y)); 
	}
	
	private void calcTheta(){
		_theta = atan2(-(_y-_y0), _x-_x0);
	}
	
	private void calcFreq(){
		//f =f0 * (2 ^ (rad/pi))
		_freq = _baseFreq * pow(2,_theta/PI);
	}
	
	private void baseCheck(){
		if(this.upLine()){
			_baseFreq /= 2.0f;
		}
		if(this.downLine()){
			_baseFreq *= 2.0f;
		}
	}
	
	private boolean upLine(){
		if(_xp < _x0 && _x < _x0){
			if(_yp > _y0 && _y < _y0){
				return true;
			}
		}
		return false;
	}
	
	private boolean downLine(){
		if(_xp < _x0 && _x < _x0){
			if(_yp < _y0 && _y > _y0){
				return true;
			}
		}
		return false;
	}
	
	public void sendFreq(){
		sendData(this._freq);
	}
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "neon" });
  }
}
