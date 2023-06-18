// https://vormplus.be/full-articles/drawing-a-cylinder-with-processing
PShape createCylinder(int sides, float radius, float height) {
  PShape cylinder = createShape(GROUP);

  float angle = 360 / sides;
  float halfHeight = height / 2;

  // draw bottom of the tube
  PShape bottom = createShape();
  bottom.beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * radius;
    float y = sin( radians( i * angle ) ) * radius;
    bottom.vertex( x, y, -halfHeight);
  }
  bottom.endShape(CLOSE);
  cylinder.addChild(bottom);

  // draw top of the tube
  PShape top = createShape();
  top.beginShape();
  for (int i = 0; i <= sides; i++) {
    float x = cos( radians( i * angle ) ) * radius;
    float y = sin( radians( i * angle ) ) * radius;
    top.vertex( x, y, halfHeight, 0, 0);
  }
  top.endShape(CLOSE);
  cylinder.addChild(top);

  // draw sides
  PShape middle = createShape();
  middle.beginShape(QUADS);
  middle.noStroke();
  for (int i = 0; i <= sides; i++) {
    float x = cos(radians(i * angle)) * radius;
    float y = sin(radians(i * angle)) * radius;
    middle.vertex(x, y, -halfHeight, (float)i/sides*2, 1);
    middle.vertex(x, y, halfHeight, (float)i/sides*2, 0);
    float xn = cos(radians((i+1) * angle)) * radius;
    float yn = sin(radians((i+1) * angle)) * radius;
    middle.vertex(xn, yn, halfHeight, (float)(i+1)/sides*2, 0);
    middle.vertex(xn, yn, -halfHeight, (float)(i+1)/sides*2, 1);
  }
  middle.endShape(CLOSE);
  cylinder.addChild(middle);

  return cylinder;
}
