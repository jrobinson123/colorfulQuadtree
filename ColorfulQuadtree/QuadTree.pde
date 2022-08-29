

class QuadTree{
  PVector[] cords;
  QuadTree[] children;
  color[] Color;
  int size;
  
  QuadTree(int startX, int startY, int size, int depth) {
     
      cords = new PVector[4];
      cords[0] = new PVector(startX, startY);
      cords[1] = new PVector(startX + size/2, startY);
      cords[2] = new PVector(startX, startY + size/2);
      cords[3] = new PVector(startX + size/2, startY + size/2);
      
      this.size = size;
      
      Color = new color[4];
      for (int j = 0; j < 4; j++) {
        Color[j] = color(random(255), random(255), random(255));
      }
      
      children = new QuadTree[4];
      if (depth < 6) {
        for (int i = 0; i < 4; i++) {
           if (Math.random() > 0.1 * depth + 0.1) {
               children[i] = new QuadTree(int(cords[i].x), int(cords[i].y), size/2, depth + 1);
           }
        }
      }
  }
  void show(){
    for (int i = 0; i < children.length; i++) {
      if (children[i] == null) {
          noStroke();
          fill(Color[i]);
          rect(cords[i].x, cords[i].y, size/2, size/2);
      } else {
        children[i].show();
      }
    }
  }
}
