SimBox base;
float PLATFORM_WIDTH=width;
float PLATFORM_HEIGHT=height;

float BORDER_WEIGHT=40;

void initPlatform() {

  PLATFORM_WIDTH=600;
  PLATFORM_HEIGHT=900;
  BORDER_WEIGHT=100;

  base = new SimBox(new PVector(-PLATFORM_WIDTH/2, -PLATFORM_HEIGHT/2, -10), new PVector(PLATFORM_WIDTH/2, PLATFORM_HEIGHT/2, 20));

  // Borders
  blocks.add(
    new Block(PLATFORM_WIDTH/2+BORDER_WEIGHT/2, 0, PLATFORM_HEIGHT+BORDER_WEIGHT*2, BORDER_WEIGHT, 90)
    );
  blocks.add(
    new Block(-PLATFORM_WIDTH/2-BORDER_WEIGHT/2, 0, PLATFORM_HEIGHT+BORDER_WEIGHT*2, BORDER_WEIGHT, 90)
    );
  blocks.add(
    new Block(0, -PLATFORM_HEIGHT/2-BORDER_WEIGHT/2, PLATFORM_WIDTH+BORDER_WEIGHT*2, BORDER_WEIGHT)
    );
  blocks.add(
    new Block(
    -PLATFORM_WIDTH/2+BORDER_WEIGHT-80/2,
    PLATFORM_HEIGHT/2+BORDER_WEIGHT/2,
    PLATFORM_WIDTH/2+BORDER_WEIGHT-80,
    BORDER_WEIGHT
    )
    );
  blocks.add(
    new Block(
    PLATFORM_WIDTH/2-BORDER_WEIGHT+80/2,
    PLATFORM_HEIGHT/2+BORDER_WEIGHT/2,
    PLATFORM_WIDTH/2+BORDER_WEIGHT-80,
    BORDER_WEIGHT
    )
    );

  // Output border
  blocks.add(
    new Block(
    PLATFORM_WIDTH/2-BORDER_WEIGHT/4-ballRadio,
    150-50,
    600+50*2,
    BORDER_WEIGHT/4,
    90
    )
    );

  // Top Right Curve
  blocks.add(
    new Block(
    310,
    -370,
    100,
    BORDER_WEIGHT/2,
    -110
    )
    );
  blocks.add(
    new Block(
    260,
    -440,
    100,
    BORDER_WEIGHT/2,
    -140
    )
    );
  blocks.add(
    new Block(
    200,
    -470,
    100,
    BORDER_WEIGHT/2,
    -165
    )
    );

  // Top Left Curve
  blocks.add(
    new Block(
    -310,
    -370,
    100,
    BORDER_WEIGHT/2,
    110
    )
    );
  blocks.add(
    new Block(
    -260,
    -440,
    100,
    BORDER_WEIGHT/2,
    140
    )
    );
  blocks.add(
    new Block(
    -200,
    -470,
    100,
    BORDER_WEIGHT/2,
    165
    )
    );

  // midle rotating bars
  blocks.add(
    new Block(
    0,
    -300,
    170,
    BORDER_WEIGHT/4,
    90
    )
    );
  rotatingBlock1 = blocks.get(blocks.size()-1);
  blocks.add(
    new Block(
    0,
    -300,
    BORDER_WEIGHT/4,
    170,
    90
    )
    );
  rotatingBlock2 = blocks.get(blocks.size()-1);

  // Middle Circles
  stroke(255);
  fill(#496A3C);
  cylinders.add(
    new Cylinder(
    0,
    -90,
    60,
    10
    )
    );
  cylinders.add(
    new Cylinder(
    230,
    -20,
    40,
    20
    )
    );
  cylinders.add(
    new Cylinder(
    -280,
    -20,
    40,
    20
    )
    );

  cylinders.add(
    new Cylinder(
    -200,
    220,
    30,
    20
    )
    );
  cylinders.add(
    new Cylinder(
    200,
    220,
    30,
    20
    )
    );

  // 3 Middle circles
  cylinders.add(
    new Cylinder(
    0,
    100,
    20,
    40
    )
    );
  cylinders.add(
    new Cylinder(
    100,
    100,
    20,
    40
    )
    );
  cylinders.add(
    new Cylinder(
    -100,
    100,
    20,
    40
    )
    );

  // Diagonal middle bars
  blocks.add(
    new Block(
    -150,
    300,
    180,
    BORDER_WEIGHT/4,
    45
    )
    );
  blocks.add(
    new Block(
    150,
    300,
    180,
    BORDER_WEIGHT/4,
    -45
    )
    );
  blocks.add(
    new Block(
    -210,
    380,
    300,
    BORDER_WEIGHT/4,
    45
    )
    );
  blocks.add(
    new Block(
    190,
    400,
    200,
    BORDER_WEIGHT/4,
    -45
    )
    );

  // Flippers
  flippers.add(
    new Flipper(
    "e",
    60,
    350,
    110,
    BORDER_WEIGHT/4,
    80/2,
    0,
    false
    )
    );

  flippers.add(
    new Flipper(
    "q",
    -60,
    350,
    110,
    BORDER_WEIGHT/4,
    -80/2,
    0,
    true
    )
    );
}

void drawPlatform() {
  stroke(255);
  fill(#0b1721);
  base.drawMe();
}
