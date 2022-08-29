


QuadTree quad;
void setup(){
  frameRate(5);
  size(512, 512);
}

void draw(){
  quad = new QuadTree(0, 0, 512, 0);
  quad.show();
  
}
