# 再帰的な雪の結晶生成プログラム

このプログラムは Processing を使用して、再帰アルゴリズムにより美しい雪の結晶パターンを生成します。実際の雪の結晶に見られる六角形の対称性と複雑な枝分かれ構造を再現しています。

## 概要

このプログラムの主な機能

- 六角形の対称性を持つ雪の結晶の描画
- 再帰アルゴリズムを使用した自然な枝分かれパターンの生成
- インタラクティブな操作による様々なパラメータの調整
- 降雪アニメーションモード

## 使い方

### 必要条件
- [Processing](https://processing.org/download/) がインストールされていること

### 実行方法
1. Processing を起動
2. プログラムコードを新規スケッチにコピー＆ペースト
3. 実行ボタン（▶）をクリック

### 操作方法

キーボードショートカット：
- **D キー**: 再帰の深さを変更
- **S キー**: 雪の結晶のサイズを変更
- **R キー**: 自動回転のオン/オフを切り替え
- **F キー**: 雪降りモードに切り替え

マウス操作：
- **ドラッグ**: 雪の結晶を手動で回転

## プログラムの構造

### 主要な関数

- `setup()`: プログラムの初期設定
- `draw()`: 毎フレーム実行される描画処理
- `drawSnowflakeArm()`: 雪の結晶の腕を再帰的に描画
- `drawBranch()`: 指定した角度に枝を描画
- `drawSnowfall()`: 雪降りアニメーションの描画
- `keyPressed()`: キーボード入力の処理
- `mouseDragged()`: マウスドラッグ操作の処理

### クラス
- `Snowflake`: 個々の雪の結晶を管理するクラス（雪降りアニメーション用）

## 技術的な解説

### 再帰アルゴリズム

このプログラムの中核は再帰アルゴリズムである。`drawSnowflakeArm()` 関数が自分自身を呼び出すことで、自己相似的な雪の結晶の構造を生成する。

```processing
void drawSnowflakeArm(float x, float y, float size, int depth) {
  // 再帰の停止条件
  if (depth <= 0) return;
  
  // メインの枝を描画
  float endX = x + size;
  line(x, y, endX, y);
  
  // さらに枝分かれを描画...
  
  // 再帰呼び出し
  drawBranch(branch1X, y, branchSize, 60, depth - 1);
  // ...他の枝も同様に...
}
```

### 六角形の対称性

雪の結晶の六角形の対称性は、中心から60度ずつ回転させた6つの腕を描画することで実現している。

```processing
// 雪の結晶の6つの腕を描画
for (int i = 0; i < 6; i++) {
  pushMatrix();
  rotate(radians(i * 60));
  drawSnowflakeArm(0, 0, baseSize, maxDepth);
  popMatrix();
}
```

### 色の設定

HSB色空間を使用して、淡い青色の雪の結晶を描画している。再帰の深さに応じて色を微妙に変化させることで、視覚的な奥行きを表現している。

```processing
colorMode(HSB, 360, 100, 100, 100);
// ...
stroke(210 - depth * 5, 40 + depth * 10, 100, 90 - depth * 5);
```

## カスタマイズ

このプログラムは様々な方法でカスタマイズできる

1. グローバル変数を変更して基本的なパラメータを調整
   ```processing
   int maxDepth = 4;       // 再帰の最大深さ
   float baseSize = 200;   // 基本サイズ
   float rotationSpeed = 0.2; // 回転速度
   ```

2. `drawSnowflakeArm()` 関数内の枝分かれのパターンや角度を変更して、異なる形状の雪の結晶を生成

3. 色の設定を変更して、異なる色調の雪の結晶を作成

## 構想段階で実装に至らなかったアイデア

- 複数のパターンを切り替えられるようにする
- マウスクリック位置に雪の結晶を生成する機能の追加
- 雪の結晶の成長過程をアニメーション化
- 雪の結晶のパラメータをランダム生成するボタンの追加

