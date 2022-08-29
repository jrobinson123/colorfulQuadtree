# colorfulQuadtree

![](quadtree.gif)


I was interested in creating a beautiful, colorful quad tree, where the quad tree would be subdivided into four sections which would either remain full or subdivide into four additional quad trees. 

The basis for this animation is the QuadTree data structure I designed. Each QuadTree has a size, array of coordinates called cords, array of colors, and array of children QuadTree[s] called children. Each array is of size 4, corresponding to one of four subsections. Each QuadTree also has a value called depth to limit recursion. 

Each element in cords is desgined to be the start point of one of four subdividing sections. 
```processing
  QuadTree(int startX, int startY, int size, int depth) {
     
      cords = new PVector[4];
      cords[0] = new PVector(startX, startY);
      cords[1] = new PVector(startX + size/2, startY);
      cords[2] = new PVector(startX, startY + size/2);
      cords[3] = new PVector(startX + size/2, startY + size/2);
```
Colors are assigned at random and correspond to each subdivided section. 

```processing
Color = new color[4];
for (int j = 0; j < 4; j++) {
  Color[j] = color(random(255), random(255), random(255));
}
```

Pointers are allocated to the children QuadTrees[s], by default setting their values to null. A randomly generated value then determines whether or not each child QuadTree is initialized. The smaller depth is, the more likely it is that children are initialized. Each child QuadTree has half the size as the parent and is assigned to exist in one of the four subsections. Children are only allowed to be created to a certain depth. 
```processing
children = new QuadTree[4];
      if (depth < 6) {
        for (int i = 0; i < 4; i++) {
           if (Math.random() > 0.1 * depth + 0.1) {
               children[i] = new QuadTree(int(cords[i].x), int(cords[i].y), size/2, depth + 1);
           }
        }
      }
```
After the QuadTree (and its children QuadTree[s]) is initialized, we can now show it! 

Showing a QuadTree is as simple checking each element in children, if it's null, then just display a square at the corresponding coordinate with the corresponding color, else recurisvely show the child QuadTree. 
```processing
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
```
In the main part of the program, I set the size of the main QuadTree (called quad) to 512 (I choose a power of 2 to limit issues with fractional pixel values) and re-initialize the quad every frame in order to give the program a dynamic animation. I set the frame rate to 5 but the program can easily support much higher frame rates. 

```processing
QuadTree quad;
void setup(){
  frameRate(5);
  size(512, 512);
}

void draw(){
  quad = new QuadTree(0, 0, 512, 0);
  quad.show();
  
}

