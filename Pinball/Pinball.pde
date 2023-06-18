import controlP5.*;


ArrayList<Ball> balls;
ArrayList<Block> blocks;
ArrayList<Cylinder> cylinders;
ArrayList<Flipper> flippers;
float gravity=0.1;
float coeffRest=0.8;
float coeffRestCylinder=1.15;
float ballRadio = 10;
float friction = 0.1;
float ballMass = 1;

float prevFrameTime;

float angularVelocity = 1.0;



SimCamera camera;

PFont font;

ControlP5 cp5;
float userPoints=0;
Textlabel scoreLabel;
Button resetButton;

Block rotatingBlock1;
Block rotatingBlock2;


void setup() {
  size(1000, 900, P3D);

  camera = new SimCamera();

  balls = new ArrayList();
  blocks = new ArrayList();
  cylinders = new ArrayList();
  flippers = new ArrayList();
  initPlatform();

  cp5 = new ControlP5(this);
  PFont sliderCaptionFont = createFont("Roboto-Regular.ttf", 16);


  scoreLabel = new Textlabel(cp5, 
    "Another textlabel, not created through ControlP5 needs to be rendered separately by calling Textlabel.draw(PApplet).", 
    0, 4, 
    600, 200);

  resetButton = new Button(cp5, "resetEvent");
  resetButton.setWidth(200);
  resetButton.setHeight(19);
  resetButton.setPosition(width-200-4, 4);
  resetButton.setCaptionLabel("Reset");

  cp5.addSlider("ballRadio")
    .setPosition(4, 40)
    .setSize(200, 20)
    .setRange(2, 10)
    .setCaptionLabel("Ball Radius")
    .getCaptionLabel().setFont(sliderCaptionFont);

  cp5.addSlider("gravity")
    .setPosition(4, 70)
    .setSize(200, 20)
    .setRange(0, 0.5)
    .getCaptionLabel().setFont(sliderCaptionFont);
    
   cp5.addSlider("friction")
    .setPosition(4, 130)
    .setSize(200, 20)
    .setRange(0.1, 1)
    .setCaptionLabel("Friction")
    .addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent e) {
            Slider slider = (Slider) e.getController();
            friction = slider.getValue();
            for (Ball b : balls) {
                b.friction = friction;
            }
        }
    })
    .getCaptionLabel().setFont(sliderCaptionFont);


  cp5.addSlider("coeffRest")
    .setPosition(4, 100)
    .setSize(200, 20)
    .setRange(0.5, 1.5)
    .setCaptionLabel("Coefficient of Restitution")

    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent e) {
      Slider slider = (Slider) e.getController();

      coeffRest = slider.getValue();
      for (Block b : blocks) {
        b.cor=coeffRest;
      }
    }
  }

  )
  .getCaptionLabel().setFont(sliderCaptionFont);
  
  cp5.addSlider("angularVelocity")
  .setPosition(4, 160)
  .setSize(200, 20)
  .setRange(0, 10)
  .setCaptionLabel("Angular Velocity")
  .getCaptionLabel().setFont(sliderCaptionFont);

  

  // load local font
  font = createFont("Roboto-Regular.ttf", 16);
  
  
}

void resetEvent() {
  userPoints=0;
  balls = new ArrayList();
}


void keyPressed() {
  if (key == 'c') {
    camera = new SimCamera();
    camera.setPositionAndLookat(new PVector(500, 450, 780), new PVector(500, 450, 779));
  }

  if (key == ' ') {
    Ball b = new Ball(PLATFORM_WIDTH/2, PLATFORM_HEIGHT/2);
    b.vel.y = random(-28, -20);
    b.vel.x = random(-1, 1);
    balls.add(b);
  }

  for (Flipper flipper : flippers) {
    if (flipper.key.equals(key+"")) {
      flipper.setActive(true);
      break;
    }
  }
}

void keyReleased() {
  for (Flipper flipper : flippers) {
    if (flipper.key.equals(key+"")) {
      flipper.setActive(false);
      break;
    }
  }
}

void draw() {
  
  background(0);
  translate(width / 2, height / 2-100);
  rotateX(radians(35));
  drawPlatform();
  float elapsedTime = (millis() - prevFrameTime) / 1000.0;
  prevFrameTime = millis();

  rotatingBlock1.rot += angularVelocity;
  rotatingBlock2.rot += angularVelocity;
  rotatingBlock1.rot++;
  rotatingBlock2.rot++;

  for (Flipper flipper : flippers) {
    flipper.update();
  }

  stroke(255);
  fill(255);
  for (int i=balls.size()-1; i>=0; i--) {
    Ball ball = balls.get(i);
    ball.update(elapsedTime);
    if (ball.pos.y>PLATFORM_HEIGHT) {
      balls.remove(ball);
    }
  }

  stroke(255);
  fill(#0b1721);
  for (Block block : blocks) {
    block.update();
  }
  for (Cylinder cylinder : cylinders) {
    cylinder.update();
  }

  camera.update();
  scoreLabel.setText("Score: "+ nf((int) userPoints, 6));
  scoreLabel.setFont(font);
  scoreLabel.draw(this);
}
