//neon_loadshow
//final int NEW_OBJ_THRES = ;
involuteLine[] list;
final int NEW_OBJ_THRES = 10;
final int OBJ_NUM = 30;

void setupObjects(){
	list = new involuteLine[OBJ_NUM];
	for(int i=0;i<list.length;i++){
		list[i] = new involuteLine();
	}
}

void updateObjects(){
	for(int i = 0;i<list.length;i++){
		list[i].update();
	}
}

void drawNeons(float x, float y){
	list[tmp_l] = new involuteLine(x,y);
	tmp_l = (tmp_l + 1) % list.length;
	drawRandomLine(x,y);
	SS.sendFreq();
}



/*
NeonsLine NL;
void setupNeonLines(){
	NL = new NeonsLine();
}


class NeonsLine(){
	int _cnt;
	int _tmp;
	int _time;
	involuteLine[] _list:
	float _x;
	float _y;	
	float _dx;
	float _dy;
	NeonsLine(){
		_x=0;_y=0;_dx=0;_dy=0;
		_cnt=0;_tmp=0;_time=1;
		_list = new involuteLine[OBJ_NUM];
		for(int i=0;i<_list.length;i++){
			_list[i] = involuteLine();
		}
	}
	
	NeonsLine(float xs,float ys, float xg, float yg, int time){
		_cnt = 0;
		_tmp = 0;
		_time = time;
		_x = xs;
		_y = ys;
		_dx = (xg-xs)/(float)time;
		_dy = (yg-ys)/(float)time;
		_list = new involuteLine[OBJ_NUM];
		for(int i=0;i<_list.length;i++){
			_list[i] = involuteLine();
		}
	}
	
	public void update(){
		this.updatePos();
		this.updateOjects();
	}
	
	private void updatePos(){
		_x += _dx;
		_y += _dy;
	}
	
	private void updateObjects(){
		if(_cnt % NEW_OBJ_THRES == 0){
			_list[_tmp] = new involuteLine(_x, _y);
			_tmp++;
		}
		for(int i=0;i < _list.length;i++){
			_list[i].update();
		}
		_cnt++;
	}
}
*/