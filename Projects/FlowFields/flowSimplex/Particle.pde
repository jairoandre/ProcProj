public class Particle {
  private static final int HMIN = 160;
  private static final int HMAX = 255;
  float hInc = .3;
  PVector pos;
  PVector vel;
  PVector acc;
  PVector prevPos;
  float h;
  boolean increasing;

  color col;

  public Particle() {
    pos = new PVector(random(width), random(height));
    //vel = PVector.random2D().setMag(random(0, maxSpeed / 5));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    prevPos = pos.copy();
    h = HMIN;
    increasing = true;

    float colNum = map(pos.y, 0, height, 180, 220);
    col = color(colNum, 100, 100);
  }

  void update() {
    prevPos = pos.copy();
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
  }

  void follow(PVector[] flowField) {
    int x = (int) (pos.x / scl);
    int y = (int) (pos.y / scl);
    int index = (x + (y * cols));
    PVector force = flowField[index];
    applyForce(force);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void display() {
    //stroke(255);
    if(mode == PAR){
      stroke(255, 100, 100);
    }
    else{
      stroke(getColor(colIndex));
    }  
    //stroke(col);
    /*if(increasing){
     h += hInc;
     }
     else{
     h -= hInc;
     }
     
     if(h > HMAX){
     h = HMAX;
     increasing = false;
     }
     else if (h < HMIN){
     h = HMIN;
     increasing = true;
     }*/
    //System.out.println(h);
    //strokeWeight(2);
    if(mode == REG){
      //point(pos.x, pos.y);
      line(pos.x, pos.y, prevPos.x, prevPos.y);
    }
    else if (mode == PAR) {
      line(pos.x, pos.y, prevPos.x, prevPos.y);
    }
  }

  void edges() {
    if (pos.x > width) pos.x = 0;
    if (pos.x < 0) pos.x = width;
    if (pos.y > height) pos.y = 0;
    if (pos.y < 0) pos.y = height;
  }

  int getColor(float v) {

    v = abs(v);

    v = v%(colors.size());

    int c1 = colors.get(int(v%colors.size()));

    int c2 = colors.get(int((v+1)%colors.size()));

    return lerpColor(c1, c2, v%1);
  }
}
