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
      mPoints.add(new PVector(float(x)/mImage.width, maxY/mImage.height));
    }
  }

  // draw
  mGraphic.beginDraw();
  mGraphic.background(0);
  mGraphic.stroke(200, 0, 0);
  mGraphic.fill(200, 0, 0);
  mGraphic.strokeWeight(2);
  for (int i=1; i<mPoints.size(); i++) {
    mGraphic.ellipse(mPoints.get(i-1).x*mGraphic.width, mPoints.get(i-1).y*mGraphic.height, 10, 10);
    mGraphic.line(mPoints.get(i-1).x*mGraphic.width, mPoints.get(i-1).y*mGraphic.height,
      mPoints.get(i).x*mGraphic.width, mPoints.get(i).y*mGraphic.height);
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