class Ball {

  PVector pos;
  PVector prevPos;
  PVector vel;
  PVector acc;
  
  float friction;

  SimSphere sphere;

  Ball(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    sphere = new SimSphere(ballRadio);
    friction = 0.1;

  }

  void update(float elapsedTime) {
    acc.y += gravity;
    vel.add(acc);
    prevPos = pos.copy();
    pos.add(vel);
    
    vel.x *= pow(1 - friction, elapsedTime);
    vel.y *= pow(1 - friction, elapsedTime);

    collisionBalls();
    
    vel.mult(0.992f);
    acc.mult(0); 

    collisionBlocks();
    collisionCylinders();

    sphere.setCentre(pos);
    sphere.translate.z = 30;
    sphere.setRadius(ballRadio);
    sphere.drawMe();
  }

  void collisionBalls() {
    pos = new PVector(pos.x, pos.y);

    for (Ball ball : balls) {
      if (ball!=this && ball.sphere.collidesWith(sphere)) {
        // Get distances between the balls components
        PVector distanceVect = PVector.sub(ball.pos, pos);

        // Calculate magnitude of the vector separating the balls
        float distanceVectMag = distanceVect.mag();

        // Minimum distance before they are touching
        float minDistance = ballRadio * 2;
        if (distanceVectMag < minDistance) {
          float distanceCorrection = (minDistance-distanceVectMag)/2.0;
          PVector d = distanceVect.copy();
          PVector correctionVector = d.normalize().mult(distanceCorrection);
          ball.pos.add(correctionVector);
          ball.pos.sub(correctionVector);

          // get angle of distanceVect
          float theta  = distanceVect.heading();
          // precalculate trig values
          float sine = sin(theta);
          float cosine = cos(theta);

          /* bTemp will hold rotated ball positions. You 
           just need to worry about bTemp[1] position*/
          PVector[] bTemp = {
            new PVector(), new PVector()
          };

          /* this ball's position is relative to the other
           so you can use the vector between them (bVect) as the 
           reference point in the rotation expressions.
           bTemp[0].position.x and bTemp[0].position.y will initialize
           automatically to 0.0, which is what you want
           since b[1] will rotate around b[0] */
          bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
          bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

          // rotate Temporary velocities
          PVector[] vTemp = {
            new PVector(), new PVector()
          };

          vTemp[0].x  = cosine * vel.x + sine * vel.y;
          vTemp[0].y  = cosine * vel.y - sine * vel.x;
          vTemp[1].x  = cosine * ball.vel.x + sine * ball.vel.y;
          vTemp[1].y  = cosine * ball.vel.y - sine * ball.vel.x;

          /* Now that velocities are rotated, you can use 1D
           conservation of momentum equations to calculate 
           the final velocity along the x-axis. */
          PVector[] vFinal = {  
            new PVector(), new PVector()
          };

          // final rotated velocity for b[0]
          vFinal[0].x = (2  * vTemp[1].x) / 2;
          vFinal[0].y = vTemp[0].y;

          // final rotated velocity for b[0]
          vFinal[1].x = (2 * vTemp[0].x) / 2;
          vFinal[1].y = vTemp[1].y;

          // hack to avoid clumping
          bTemp[0].x += vFinal[0].x;
          bTemp[1].x += vFinal[1].x;

          /* Rotate ball positions and velocities back
           Reverse signs in trig expressions to rotate 
           in the opposite direction */
          // rotate balls
          PVector[] bFinal = { 
            new PVector(), new PVector()
          };

          bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
          bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
          bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
          bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

          // update balls to screen position
          ball.pos.x = pos.x + bFinal[1].x;
          ball.pos.y = pos.y + bFinal[1].y;

          pos.add(bFinal[0]);

          // update velocities
          vel.x = cosine * vFinal[0].x - sine * vFinal[0].y;
          vel.y = cosine * vFinal[0].y + sine * vFinal[0].x;
          ball.vel.x = cosine * vFinal[1].x - sine * vFinal[1].y;
          ball.vel.y = cosine * vFinal[1].y + sine * vFinal[1].x;
        }
      }
    }
  }

  void collisionBlocks() {
    for (Block block : blocks) {
      PVector relPos = PVector.sub(pos, block.pos);
      relPos.rotate(-radians(block.rot));
      relPos.add(block.pos);

      if (circleRect(relPos.x, relPos.y, ballRadio, block.getLeft(), block.getTop(), block.wdt*2, block.hgt*2)) {
        block.collision(this);
        break;
      }
    }
  }

  void collisionCylinders() {
    for (Cylinder cylinder : cylinders) {
      if (circleCircle(pos.x, pos.y, ballRadio, cylinder.pos.x, cylinder.pos.y, cylinder.rot)) {
        cylinder.collision(this);
        userPoints+=cylinder.points;
      }
    }
  }
}
