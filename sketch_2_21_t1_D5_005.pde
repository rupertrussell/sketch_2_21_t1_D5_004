// 2 21 t1 D5_004
// by Rupert Russell
// start 22 June 2019
// working towards draing the following shape
// https://en.wikipedia.org/wiki/2_21_polytope#/media/File:Up_2_21_t1_D5.svg
// https://en.wikipedia.org/wiki/2_21_polytope
// Thanks to: https://stackoverflow.com/questions/33819998/algorithm-to-find-all-line-segment-intersections-given-n-lines

float ix; // intersection point
float iy; // intersection point

float[] outerX = new float[9];
float[] outerY = new float[9];

float[] r1X = new float[9];
float[] r1Y = new float[9];


float[] secondInnerX = new float[26];
float[] secondInnerY = new float[26];

float[] thirdInnerX = new float[13];
float[] thirdInnerY = new float[13];


int count = 0;

float scale = .6;
float es = 20 * scale; // small ellipse size


float outerRadius = 400 * scale;
float innerRadius = 107 * scale;  
float secondInnerRadius = 208 * scale;  
float thirdInnerRadius = 293 * scale; 

float radius1;

void setup() {
  background(255); 
  size(520, 520);
  smooth(8);
  noLoop();
  strokeWeight(3 * scale);
}



void draw() {

  // outer circle
  translate(width/2, height/2); 
 //  rotate(degrees(45/4));
  double step = 2 * PI/8; 
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x =  outerRadius * cos(theta);
    float y =  outerRadius * sin(theta); 
    fill(255, 0, 0);
    outerX[count] = x;
    outerY[count] = y;
    count = count + 1;
  }

  // join all outer points to every other outer point
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      line(outerX[i], outerY[i], outerX[j], outerY[j]);
    }
  }

  // draw ellipses on each outer point
  fill(255, 0, 0);
  for (int count = 0; count < 8; count = count + 1) {
    ellipse(outerX[count], outerY[count], es, es);
  }

  // calculate 
  intersect(outerX[0], outerY[0], outerX[3], outerY[3], outerX[7], outerY[7], outerX[1], outerY[1]);
  radius1 = dist(ix, iy, 0, 0);
  noFill();
  ellipse(0, 0, radius1*2, radius1*2);

  count=0;
  step = 2 * PI/8; 
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x =  radius1 * cos(theta);
    float y =  radius1 * sin(theta); 
    fill(255, 0, 0);
    r1X[count] = x;
    r1Y[count] = y;
    count = count + 1;
  }


  // draw ellipses on each inner r1 points
  fill(255, 0, 0);
  for (int count = 0; count < 8; count = count + 1) {
    ellipse(r1X[count], r1Y[count], es, es);
  }

  fill(255, 255, 0);
  ellipse(0, 0, es, es);

  save("003.png");
  // exit();
}
// based on code from  https://stackoverflow.com/questions/33819998/algorithm-to-find-all-line-segment-intersections-given-n-lines
// calculate the intersection point or 2 intersecting segments
// does not error check for any non intersecting segments
void intersect(float p1x, float p1y, float p2x, float p2y, float p3x, float p3y, float p4x, float p4y) {

  float max1; //x-coordinate with greater value in segment 1
  float min1; //x-coordinate with lesse value in segment 1
  float max2; //x-coordinate with greater value in segment 2
  float min2; //x-coordinate with lesser value in segment 2
  float A1;
  float B1;
  float C1;
  float A2;
  float B2;
  float C2;
  float denom;

  A1 = p2y - p1y;
  B1 = p1x - p2x;
  C1 = A1 * p1x + B1 * p1y;
  A2 = p4y - p3y;
  B2 = p3x - p4x;
  C2 = A2 * p3x + B2 * p3y;
  denom = A1 * B2 - A2 * B1;

  ix = (C1 * B2 - C2 * B1) / denom;
  iy = (A1 * C2 - A2 * C1) / denom;

  stroke(255, 0, 0);
  strokeWeight(4);
  line(p1x, p1y, p2x, p2y);
  line(p3x, p3y, p4x, p4y);
  strokeWeight(2);
  stroke(0);

  println(ix + "," + iy);
}
