class Block {

  float wdt, hgt;
  SimBox box;
  PVector pos;
  float rot;
  float cor=coeffRest;

  Block(float x, float y, float w, float h) {
    rot = 0;
    this.wdt=w/2f;
    this.hgt=h/2f;
    pos = new PVector(x, y);
    box = new SimBox(new PVector(-this.wdt, -this.hgt, -30), new PVector(this.wdt, this.hgt, 0));
    box.translate = pos;
  }

  Block(float x, float y, float w, float h, float r) {
    rot = r;
    this.wdt=w/2f;
    this.hgt=h/2f;
    pos = new PVector(x, y);
    box = new SimBox(new PVector(-this.wdt, -this.hgt, -30), new PVector(this.wdt, this.hgt, 0));
    box.translate = pos;
  }

  void update() {
    push();
    box.translate = vec(0, 0, 0);
    translate(pos.x, pos.y, BORDER_WEIGHT/2);
    rotateZ(radians(rot));
    box.drawMe();

    ////***
    //pushStyle();
    //push();
    //translate(0, 0, 0);
    //stroke(255, 0, 0);
    //strokeWeight(1);
    //line(-wdt, 0, wdt, 0);
    //pop();
    //popStyle();
    ////***

    pop();
    box.translate = pos;
  }

  void collision(Ball b) {
    PVector relPos = PVector.sub(b.pos, pos);
    relPos.rotate(-radians(rot));
    relPos.add(pos);

    PVector relVel = b.vel.copy();
    relVel.rotate(-radians(rot));

    if (getLeft()<=relPos.x && relPos.x<=getRight() && getBottom()>=relPos.y && relPos.y>=getTop()) {
      relPos = PVector.sub(b.prevPos, pos);
      relPos.rotate(-radians(rot));
      relPos.add(pos);

      // Top
      if (pos.y>relPos.y) {
        relPos.y = getTop() - ballRadio;
        relVel.y *= -cor;
      }

      // Bottom
      else {
        relPos.y = getBottom() + ballRadio;
        relVel.y *= -cor;
      }
    } else {
      // Top
      if (inTopArea(relPos)) {
        relPos.y = getTop() - ballRadio;
        relVel.y *= -cor;
      }

      // Bottom
      else if (inBottomArea(relPos)) {
        relPos.y = getBottom() + ballRadio;
        relVel.y *= -cor;
      }

      // Left
      else if (inLeftArea(relPos)) {
        relPos.x = getLeft() - ballRadio;
        relVel.x *= -cor;
      }

      // Right
      else if (inRightArea(relPos)) {
        relPos.x = getRight() + ballRadio;
        relVel.x *= -cor;
      }

      // Top Left
      else {
        relPos = PVector.sub(b.pos, pos);
        relPos.rotate(-radians(rot));
        relPos.add(pos);

        PVector dir=null;
        PVector c=null;

        if (inTopLeftArea(relPos)) {
          dir = PVector.sub(relPos, vec(getLeft(), getTop(), 0));
          c = vec(getLeft(), getTop(), 0);
        } else if (inTopRightArea(relPos)) {
          dir = PVector.sub(relPos, vec(getRight(), getTop(), 0));
          c = vec(getRight(), getTop(), 0);
        } else if (inBottomLeftArea(relPos)) {
          dir = PVector.sub(relPos, vec(getLeft(), getBottom(), 0));
          c = vec(getLeft(), getBottom(), 0);
        } else if (inBottomRightArea(relPos)) {
          dir = PVector.sub(relPos, vec(getRight(), getBottom(), 0));
          c = vec(getRight(), getBottom(), 0);
        } else {
          return;
        }

        dir.normalize();
        dir.mult(ballRadio);
        c.add(dir);
        relPos = c.copy();

        dir.normalize();
        dir.mult(0.1);
        relVel.add(dir);
      }
    }

    PVector pivPos = PVector.sub(relPos, pos);
    pivPos.rotate(radians(rot));
    pivPos.add(pos);
    b.pos = pivPos;

    relVel.rotate(radians(rot));
    b.vel = relVel;
  }

  float getLeft() {
    return pos.x-wdt;
  }
  float getRight() {
    return  pos.x+wdt;
  }
  float getTop() {
    return pos.y-hgt;
  }
  float getBottom() {
    return pos.y+hgt;
  }

  // TopLeftArea
  boolean inTopLeftArea(PVector bpos) {
    return bpos.y<=getTop() && bpos.x<=getLeft();
  }

  // TopRightArea
  boolean inTopRightArea(PVector bpos) {
    return bpos.y<=getTop() && bpos.x>=getRight();
  }

  // BottomLeftArea
  boolean inBottomLeftArea(PVector bpos) {
    return bpos.y>=getBottom() && bpos.x<=getLeft();
  }

  // BottomRightArea
  boolean inBottomRightArea(PVector bpos) {
    return bpos.y>=getBottom() && bpos.x>=getRight();
  }

  // LeftArea
  boolean inLeftArea(PVector bpos) {
    return bpos.x<=getLeft() && bpos.y>=getTop() && bpos.y<=getBottom();
  }

  // RightArea
  boolean inRightArea(PVector bpos) {
    return bpos.x>=getRight() && bpos.y>=getTop() && bpos.y<=getBottom();
  }

  // TopArea
  boolean inTopArea(PVector bpos) {
    return bpos.y<=getTop() && bpos.x>=getLeft() && bpos.x<=getRight();
  }

  // BottomArea
  boolean inBottomArea(PVector bpos) {
    return bpos.y>=getBottom() && bpos.x>=getLeft() && bpos.x<=getRight();
  }
}
