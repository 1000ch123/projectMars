final float R_UP = 5.0;
final float THETA_UP = 0.1;

final float OBJ_R_UP = 5;
final float OBJ_THETA_UP = 0.3;
final float OBJ_FADE_LEVEL = 95.0;

class involuteLine{
	//root info
	float _x,_x0;
	float _y,_y0;
	float _r;
	float _theta;
	//obj_info
	float _obj_r;
	color _c;
	float _obj_theta;
	int _obj_poly;

	involuteLine(int x, int y, float r, color c){
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
