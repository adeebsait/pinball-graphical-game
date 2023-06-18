class Flipper {

  String key;
  PVector pos;
  PVector pivot;
  Block block;
  float rot=0;

  boolean active=false;
  boolean inverse=false;

  Flipper(String id, float x, float y, float w, float h, float px, float py, boolean inverse) {
    this.key=id;
    pos = new PVector(x, y);
    block = new Block(x, y, w, h);
    pivot = new PVector(x+px, y+py);
    blocks.add(block);
    this.inverse=inverse;
  }

  void setActive(boolean active) {
    this.active = active;
  }

  void update() {
    if (active) {
      if (!inverse) {
        rot = min(60, rot+8);
      } else {
        rot = max(-60, rot-8);
      }
    } else {
      if (!inverse) {
        rot = max(-45, rot-10);
      } else {
        rot = min(45, rot+10);
      }
    }

    PVector pivPos = PVector.sub(pos, pivot);
    pivPos.rotate(radians(rot));
    float angle = PVector.angleBetween(pivPos, new PVector(-1, 0));

    if (pivPos.y>0) {
      angle*=-1;
    }
    pivPos.add(pivot);

    float cor=1;
    if (!inverse) {
      cor = map(rot, -45, 60, 1, 1.5);
    } else {
      cor = map(rot, 45, -60, 1, 1.5);
    }

    block.cor = cor;
    block.pos = pivPos;
    block.rot = degrees(angle);
  }
}
