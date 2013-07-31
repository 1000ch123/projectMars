//2012/05/13
//�E�E�E�l�E�I�E��E��E��E�\�E��E�
//�E�E�E�l�E�I�E��E��E��E��E�p�E�`
//�E�E�E�N�E��E��E�b�E�N�E�ʒu�E�\�E��E�
//�E�E�E�C�E��E��E�{�E��E��E��E��E�[�E�g�E�Ȑ�Ńt�E�F�E�[�E�h�E�A�E�E�E�g
//�E�E�E�z�E��E�


//global valiable
float w;
//involuteLine[] list;
int tmp_l;
int cnt;
//final int NEW_OBJ_THRES = 10;
//final int OBJ_NUM = 30;
final int WIDTH = 1000;
final int HEIGHT = 288;
final int NEON_LEVEL = 60;
final int FADE_LEVEL = 30;
final int RND_LINE_WID = 10;
 
void setup(){
	size(WIDTH,HEIGHT);
	//size(screen.width, screen.height);
	smooth();
	frameRate(30);
	background(0);
	noStroke();
	noCursor();
	rectMode(CENTER);
	/*
	list = new involuteLine[OBJ_NUM];
	for(int i=0;i<list.length;i++){
		list[i] = new involuteLine();
	}
	*/
	tmp_l = 0;
	cnt = 0;
	setupObjects();
	setupSelSound(width/2, height/2);
	setupOsc();
	//setupArduino();
}

void draw(){
	fill(255);
	fade();
	SS.calcInfo(mouseX,mouseY);
	SS.showData();
	/*
	for(int i = 0;i<list.length;i++){
		list[i].update();
	}
	*/
	updateObjects();
	color c = randomColor();
	drawNeonNpolygon(10,mouseX,mouseY,5,10,c);
	//showLength();
}


void mousePressed(){
	/*
	list[tmp_l] = new involuteLine(mouseX,mouseY);
	tmp_l = (tmp_l + 1) % list.length;
	drawRandomLine(mouseX,mouseY);
	SS.sendFreq();
	*/
	drawNeons(mouseX,mouseY);
}

void mouseDragged(){
	drawRandomLine(mouseX,mouseY);
	cnt++;
	if(cnt > NEW_OBJ_THRES){
		drawNeons(mouseX,mouseY);
		cnt = 0;
	}
}

void mouseReleased(){
	cnt = 0;
}
//�E�ȉ��E�E�E�`�E��E�p�E�֐�

void fade(){
	fill(0,0,0,FADE_LEVEL);
	rect(width/2,height/2,width,height);
}

