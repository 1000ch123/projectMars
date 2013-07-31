void drawRandomLine(float x, float y){
	float theta;
	color c;
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

void drawNeonLine1(float wid, float len,color c){
	rectMode(CENTER);
	fill(255,255,255);
	rect(0,0,wid/2,len);
	fill(c,NEON_LEVEL);
	rect(0,0,wid,len);
}

color randomColor(){
	color c;
	c = color(random(255),random(255),random(255));
	return c;
}
color randomColor(int x,int y){
	color c;
	c = color(random(x,y),random(x,y),random(x,y));
	return c;
}

void drawNeonLine(float x1,float y1,float x2,float y2,float wid,color c){
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

void drawNeonNpolygon(int N,float x0, float y0, float r,float wid,color c){
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

void drawNeonTriangle(float x, float y, float r, float wid, color c){
	drawNeonNpolygon(3,x,y,r,wid,c);
}
void drawNeonSquare(float x, float y, float r, float wid, color c){
	drawNeonNpolygon(4,x,y,r,wid,c);
}
void drawNeonCircle(float x, float y, float r, float wid, color c){
	drawNeonNpolygon(100,x,y,r,wid,c);
}
