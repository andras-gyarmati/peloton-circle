ArrayList<PVector> ps, circle;
boolean save;
float circleRadius, spread, offset;
int maxCount, circleResoluton;

void setup() {
  fullScreen();
  stroke(0, 0, 0, 55);
  strokeWeight(0.5);
  frameRate(30);

  circleRadius = 150;
  offset = 30;
  spread = 0.6;
  maxCount = 2300;
  circleResoluton = 72;

  ps = new ArrayList<PVector>();
  circle = new ArrayList<PVector>();
  init();
}

void draw() {
  disp();
  calcNew();
  deleteIfTooMany();
}

void deleteIfTooMany() {
  if (ps.size() > maxCount) {
    ps.remove(0);
  }
}

void disp() {
  background(251);
  translate(width / 2, height / 2);
  if (ps.size() >= 2) {
    for (int i = 0; i < ps.size() - 1; i++) {
      pline(ps.get(i), ps.get(i + 1));
    }
  }
}

void init() {
  PVector base = new PVector(-circleRadius, 0);
  for (int i = 0; i < circleResoluton; i++) {
    if (random(1) > 0.2) {
      circle.add(base.copy().rotate(TWO_PI / circleResoluton * i));
    }
  }
  ps.add(base);
}

void calcNew() {
  int r = floor(random(circle.size()));
  PVector random = circle.get(r).copy();
  PVector last = ps.get(ps.size() - 1).copy();
  PVector newPoint = random.sub(last.sub(random).mult(spread));
  ps.add(newPoint);
  if (random(1) < 0.2) {
    ps.add(newPoint.copy().add(random(offset)-offset/2, random(offset)-offset/2));
  }
}

void pline(PVector p1, PVector p2) {
  line(p1.x, p1.y, p2.x, p2.y);
}
