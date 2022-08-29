# colorfulQuadtree

![](quadtree.gif)


I was interested in creating a beautiful quadtree, where each cell would either remain full or subdivide into four additional quadtrees. 

The basis for this animation is the QuadTree data structure I designed. Each QuadTree a size, array of cooridnates called cords, array of colors, and array of children quadtrees called children. Each Array is of size 4. A value called depth also exists to limit recursion. 

Each cord is desgined to be the start point of one of four subdividing sections. 
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

Pointers are allocated to the children quadtrees, setting them to null. A random value then determines whether or not the children are initialized. The smaller depth is, the more likely it is that children are initialized. Each child quadtree has half the size as the parent and is assigned to exist in one of the four subsections. Children are only allowed to be created to a certain depth. 
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
This creates the QuadTree (and its children QuadTree[s]) Showing each quadtree is as simple as going through the array of children, if it's null, then just display a square at the corresponding coordinate and color, else show the child QuadTree. 
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
In the main part of the program, I set the size to 512 (I choose a power of 2 to limit issues with fractional pixel values)  and re-initialize the main QuadTree every frame in order to give the program a dynamic animation. I set the frameRate to 5 but the program can easily support much higher frame rates. 

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

