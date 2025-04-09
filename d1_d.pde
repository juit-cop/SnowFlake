int maxDepth = 4;       
float baseSize = 200;  
float rotationSpeed = 0.2; 
float angle = 0;       
boolean autoRotate = true; // 自動回転
boolean snowfall = false; // 雪の降るアニメーション
ArrayList<Snowflake> snowflakes = new ArrayList<Snowflake>(); // 降る雪のリスト

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100, 100);
  strokeWeight(2);
  frameRate(30);
  
  for (int i = 0; i < 50; i++) {
    snowflakes.add(new Snowflake());
  }
}

void draw() {
  background(210, 70, 15);
  
  if (snowfall) {
    drawSnowfall();
  } else {
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(angle));
    stroke(210, 40, 100, 90);
    
    for (int i = 0; i < 6; i++) {
      pushMatrix();
      rotate(radians(i * 60));
      drawSnowflakeArm(0, 0, baseSize, maxDepth);
      popMatrix();
    }
    
    popMatrix();
    
    if (autoRotate) {
      angle += rotationSpeed;
    }
  }
  
  displayInfo();
}

// 雪の結晶の腕を再帰的に描画
void drawSnowflakeArm(float x, float y, float size, int depth) {
  if (depth <= 0) return;
  
  float endX = x + size;
  line(x, y, endX, y);
  
  float branchSize = size * 0.4;
  
  stroke(210 - depth * 5, 40 + depth * 10, 100, 90 - depth * 5);
  
  if (depth == maxDepth) {
    // 補助の枝追加
    for (int i = 1; i <= 3; i++) {
      float branchX = x + size * (i / 4.0);
      drawBranch(branchX, y, size * 0.15, 60, depth - 1);
      drawBranch(branchX, y, size * 0.15, -60, depth - 1);
    }
  }
  
  if (depth > 1) {
    float branch1X = x + size * 0.33;
    float branch2X = x + size * 0.66;
    drawBranch(branch1X, y, branchSize, 60, depth - 1);
    drawBranch(branch1X, y, branchSize, -60, depth - 1);
    drawBranch(branch2X, y, branchSize, 60, depth - 1);
    drawBranch(branch2X, y, branchSize, -60, depth - 1);
    drawBranch(endX, y, branchSize, 60, depth - 1);
    drawBranch(endX, y, branchSize, -60, depth - 1);
    drawBranch(endX, y, branchSize, 120, depth - 1);
    drawBranch(endX, y, branchSize, -120, depth - 1);
  }
}

// 指定した角度に枝を描画
void drawBranch(float x, float y, float size, float angle, int depth) {
  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  drawSnowflakeArm(0, 0, size, depth);
  popMatrix();
}

// 雪を降らせるアニメーション
void drawSnowfall() {
  for (int i = snowflakes.size() - 1; i >= 0; i--) {
    Snowflake s = snowflakes.get(i);
    s.update();
    s.display();
    
    // 画面外に出たら再配置
    if (s.y > height + s.size) {
      snowflakes.remove(i);
      snowflakes.add(new Snowflake());
    }
  }
}

// 情報を表示するメソッド
void displayInfo() {
  fill(255);
  textAlign(LEFT, TOP);
  textSize(14);
  text("Dキー: 再帰の深さ変更 (現在: " + maxDepth + ")", 10, 10);
  text("Sキー: サイズ変更 (現在: " + int(baseSize) + ")", 10, 30);
  text("Rキー: 回転切り替え (現在: " + (autoRotate ? "ON" : "OFF") + ")", 10, 50);
  text("Fキー: 雪降りモード切り替え (現在: " + (snowfall ? "ON" : "OFF") + ")", 10, 70);
}

// キー入力の処理
void keyPressed() {
  if (key == 'd' || key == 'D') {
    maxDepth = (maxDepth % 5) + 1;
  } else if (key == 's' || key == 'S') {
    baseSize = (baseSize >= 300) ? 100 : baseSize + 50;
  } else if (key == 'r' || key == 'R') {
    autoRotate = !autoRotate;
  } else if (key == 'f' || key == 'F') {
    snowfall = !snowfall;
  }
}

void mouseDragged() {
  if (!snowfall) {
    float deltaX = mouseX - pmouseX;
    angle += deltaX * 0.5;
    autoRotate = false;
  }
}

// 雪の結晶クラス（降雪アニメーション用）
class Snowflake {
  float x, y;
  float size;
  float speed;
  float rotAngle;
  float rotSpeed;
  int flakeDepth;
  
  Snowflake() {
    x = random(width);
    y = random(-100, -10);
    size = random(10, 40);
    speed = map(size, 10, 40, 2, 1); 
    rotAngle = random(360);
    rotSpeed = random(-1, 1);
    flakeDepth = int(random(1, 4));
  }
  
  void update() {
    y += speed;
    x += sin(frameCount * 0.01 + y * 0.1) * 0.5; 
    rotAngle += rotSpeed;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    scale(size / 200.0); 
    rotate(radians(rotAngle));
    
    stroke(210, 30, 100, 80);
    strokeWeight(1);
    
  
    for (int i = 0; i < 6; i++) {
      pushMatrix();
      rotate(radians(i * 60));
      drawSnowflakeArm(0, 0, 30, flakeDepth);
      popMatrix();
    }
    
    popMatrix();
  }
}
