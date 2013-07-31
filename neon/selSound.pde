//select Sound;
selSound SS;

void setupSelSound(float x, float y){
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
			_baseFreq /= 2.0;
		}
		if(this.downLine()){
			_baseFreq *= 2.0;
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
