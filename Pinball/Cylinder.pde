class Cylinder {

  float rot;
  PVector pos;
  PShape shape;
  float points;

  Cylinder(float x, float y, float r, float points) {
    pos = new PVector(x, y);
    this.rot=r;
    shape = createCylinder(20, r, 70);
    this.points=points;
  }

  void update() {
    stroke(255);
    fill(255, 0, 0);
    push();
    translate(pos.x, pos.y);
    shape(shape);
    pop();
  }

  void collision(Ball b) {
    PVector relPos = PVector.sub(b.pos, pos);
    relPos.normalize();
    relPos.mult(rot+ballRadio);
    
    PVector relVel = b.vel.copy();

    float angle = PVector.angleBetween(relPos, new PVector(0, -1));
    relPos.add(pos);

    if (b.pos.x>=pos.x) {
      relVel.rotate(-angle);
      relVel.y*=-coeffRestCylinder;
      relVel.rotate(angle);
    } else {
      relVel.rotate(angle);
      relVel.y*=-coeffRestCylinder;
      relVel.rotate(-angle);
    }

    b.pos = relPos;
    b.vel = relVel;
  }
}
