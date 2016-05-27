PImage mImage;
ArrayList <PVector> mPoints;
PGraphics mGraphic;

void setup() {
  size(1000, 500);
  mImage = loadImage("usmx_xs.png");
  mPoints = new ArrayList<PVector>();
  mGraphic = createGraphics(width, int(float(mImage.height)/mImage.width*width));

  // get points from image
  int step = 4;
  for (int x=0; x<mImage.width; x+=step) {
    float maxY = -1;
    for (int y=0; y<mImage.height; y++) {
      if (red(mImage.get(x, y)) < 200) {
        maxY = y;
      }
    }
    if (maxY > 0) {
      float maxDim = max(mImage.width, mImage.height);
      mPoints.add(new PVector(float(x)/maxDim, maxY/maxDim));
    }
  }

  // draw
  mGraphic.beginDraw();
  mGraphic.background(0);
  mGraphic.stroke(200, 0, 0);
  mGraphic.strokeWeight(2);
  float maxDim = max(mGraphic.width, mGraphic.height);
  for (int i=1; i<mPoints.size(); i++) {
    mGraphic.line(mPoints.get(i-1).x*maxDim, mPoints.get(i-1).y*maxDim, 
      mPoints.get(i).x*maxDim, mPoints.get(i).y*maxDim);
  }
  mGraphic.endDraw();

  // print points
  println("int NUM_POINTS = "+mPoints.size()+";");
  print("float mPoints[][2] = { ");
  for (int i=0; i<mPoints.size()-1; i++) {
    println("{"+mPoints.get(i).x+", "+mPoints.get(i).y+"},");
  }
  println("{"+mPoints.get(mPoints.size()-1).x+", "+mPoints.get(mPoints.size()-1).y+"} };");
}

void draw() {
  background(0);
  image(mGraphic, 0, 0);
}