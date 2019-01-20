ArrayList<PVector> ps, circle, current, jiggled;
boolean save;
float circleRadius, spread, speed;

void setup() {
  size(600, 600);
  ps = new ArrayList<PVector>();
  circle = new ArrayList<PVector>();
  current = new ArrayList<PVector>();
  jiggled = new ArrayList<PVector>();
  stroke(0, 0, 0, 25);
  circleRadius = 100;
  spread = 0.5;
  speed = 0.2;
  save = false;
  init();
  jiggle();
  //frameRate(10);
}

void draw() {
  disp();
  if (save) {
    saveFrame("gif/peloton-######.png");
  }
}

void jiggle() {
  jiggled = new ArrayList<PVector>();
  int offset = 30;
  for (int i = 0; i < ps.size(); i++) {
    jiggled.add(ps.get(i).copy().add(random(offset)-offset/2, random(offset)-offset/2));
  }
}

void disp() {
  background(251);
  translate(width / 2, height / 2);
  if (frameCount % 120 == 0) {
    jiggle();
  }
  if (ps.size() >= 2) {
    PVector c, j;
    for (int i = 0; i < current.size() - 1; i++) {
      c = current.get(i);
      j = jiggled.get(i);
      lerp(c.x, j.x, speed);
      lerp(c.y, j.y, speed);
      pline(current.get(i), current.get(i + 1));
    }
  }
  //calcNew();
}

void init() {
  PVector base = new PVector(-circleRadius, 0);
  for (int i = 0; i < 36; i++) {
    if (random(1) > 0.3) {
      circle.add(base.copy().rotate(TWO_PI / 36 * i));
    }
  }
  ps.add(base);
  for (int i = 0; i < 800; i++) {
    calcNew();
  }
}

void calcNew() {
  int offset = 40;
  int r = floor(random(circle.size()));
  PVector random = circle.get(r).copy();
  PVector last = ps.get(ps.size() - 1).copy();
  PVector newPoint = random.sub(last.sub(random).mult(spread));
  ps.add(newPoint);
  current.add(newPoint.copy());
  if (random(1) < 0.2) {
    ps.add(newPoint.copy().add(random(offset)-offset/2, random(offset)-offset/2));
    current.add(newPoint.copy().add(random(offset)-offset/2, random(offset)-offset/2));
  }
}

void pline(PVector p1, PVector p2) {
  line(p1.x, p1.y, p2.x, p2.y);
}

void mousePressed() {
  save = !save;
}
