//変数宣言
int x = 10;//開始時のｘ座標
int y = 400;//開始時のｙ座標
int dx = 3;//移動量ｘ
int dy = 6;//移動量ｙ
int hx, hy;//ブロックの縦横の数
int count = 0;//消したブロックの数
int endf = 0;//プレゼンテーションのためのショートカット用変数
int [][] hantei = new int [24][9];//ブロックの当たり判定の２次元配列

void setup() {
  size(1201, 900);
  frameRate(120);
  blocknarabe();//ブロックを並べる
  for (int i = 0; i <= 23; i = i + 1) {
    for (int j = 1; j <= 7; j = j + 1) {
      hantei[i][j] = 1;//ブロックの当たり判定配列に１を入れる
    }
  }
}

void draw() {
  background(250);
  bardraw();//バー
  balldraw();//ボール
  blocknarabe();//ブロックを並べる
  sargasso_zone();//軌道変更領域の描画
  blockbreak(x, y);//ブロックを消す
  if (count >= 168) {//ブロック全てを消したら
    enddraw();//終わる
  }
  if (endf == 1) {//ショートカットが使われたら
    enddraw();//終わる
  }
}

void bardraw() {//バーを描く
  noStroke();
  fill(0, 126, 0);
  rect(mouseX, mouseY, 100, 10);//マウスカーソルを中心として描かれる
  rect(mouseX, mouseY, -100, 10);//さらに、マウスYの動きにも対応
}

void balldraw() {//ボールを描く

  x = x + dx;
  y = y + dy;

  if ( x >= width) {//壁に当たった時
    dx = -3;
  } else if (x < 0) {
    dx = 3;
  }

  if ( y < 0) {//天井に当たった時
    dy = 6;
  } else if ( y > height) {//落ちた時
    x = 10;
    y = 400;
    dx = 3;
    dy = 6;
  }
  if (barhit(x, y)) {//バーに当たった時
    dy = -6;
  }
  if (sargasso(x, y)) {//軌道変更領域に入った時
    dx = int(random(-10, 10));//ｘの移動量ランダム変化
    dy = int(random(-10, 10));//ｙの移動量ランダム変化
  }

  fill(255, 0, 0);
  ellipse(x, y, 10, 10);//円
}

void blocknarabe() {//ブロックを並べる関数
  for (int i = 0; i <= 23; i = i + 1) {
    for (int j = 1; j <= 7; j = j + 1) {
      if (hantei[i][j] > 0) {
        blockdraw(i * 50, j * 50, 50, 50, j);//下のブロック描写関数へ受け渡し
      }
    }
  }
}

void blockbreak(int hitx, int hity) {//ブロックを消す関数
  if (blockhit(hitx, hity)) {
    if (hantei[hx][hy] == 0) {//判定配列の値が０なら消す
      blockdraw(hx * 50, hy * 50, 50, 50, 49);//下のブロック描写関数へ受け渡し
    }
  }
}

void blockdraw(int x, int y, int wx, int hy, int j) {//ブロックを描く
  if (j == 0) {//jの数値によって色を変えることで虹色出している
    strokeWeight(0);
    stroke(255);
    fill(200, 200, 200, 126);
    rect(x, y, wx, hy);
  } else if (j == 1) {//以下省略
    strokeWeight(0);
    stroke(255);
    fill(255, 0, 0, 126);
    rect(x, y, wx, hy);
  } else if (j == 2) {
    strokeWeight(0);
    stroke(255);
    fill(255, 128, 0, 126);
    rect(x, y, wx, hy);
  } else if (j == 3) {
    strokeWeight(0);
    stroke(255);
    fill(255, 255, 0, 126);
    rect(x, y, wx, hy);
  } else if (j == 4) {
    strokeWeight(0);
    stroke(255);
    fill(0, 153, 0, 126);
    rect(x, y, wx, hy);
  } else if (j == 5) {
    strokeWeight(0);
    stroke(255);
    fill(0, 0, 255, 126);
    rect(x, y, wx, hy);
  } else if (j == 6) {
    strokeWeight(0);
    stroke(255);
    fill(0, 0, 204, 126);
    rect(x, y, wx, hy);
  } else if (j == 7) {
    strokeWeight(0);
    stroke(255);
    fill(102, 0, 204, 126);
    rect(x, y, wx, hy);
  } else if (j == 49) {//ブロックを見えなくする　
    noStroke();
    fill(250, 250, 250, 0);
    rect(x, y, wx, hy);
  } else {//手違いで増えた場合の対策
    strokeWeight(0);
    stroke(255);
    fill(0, 0, 0, 126);
    rect(x, y, wx, hy);
  }
}

boolean barhit(int hitx, int hity) {//バーに当たったことを確認して返す
  if (( hity >= mouseY)&&(hity <= mouseY + 10)) {//ボールのｙ座標判定
    if (hitx >= mouseX - 100) {//ボールのｘ座標判定
      if (hitx <= mouseX + 100) {//ボールのｘ座標判定
        return true;//全て満たせばtrue
      } else {
        return false;//一つでも欠ければfalse
      }
    } else {
      return false;
    }
  } else {
    return false;
  }
}

boolean blockhit(int hitx, int hity) {//ブロックに当たったことを確認して返す
  if ((hity / 50 >= 1) && (hity / 50 <= 8)) {//ボールのｙ座標確認
    hy = hity / 50;//整数値
    switch(hitx / 50) {//ボールのｘ座標確認
    case 0://hitx / 50 が0のとき
      hx = 0;//hxに0を入れて
      break;//ループを抜ける　以下略
    case 1:
      hx = 1;
      break;
    case 2:
      hx = 2;
      break;
    case 3:
      hx = 3;
      break;
    case 4:
      hx = 4;
      break;
    case 5:
      hx = 5;
      break;
    case 6:
      hx = 6;
      break;
    case 7:
      hx = 7;
      break;
    case 8:
      hx = 8;
      break;
    case 9:
      hx = 9;
      break;
    case 10:
      hx = 10;
      break;
    case 11:
      hx = 11;
      break;
    case 12:
      hx = 12;
      break;
    case 13:
      hx = 13;
      break;
    case 14:
      hx = 14;
      break;
    case 15:
      hx = 15;
      break;
    case 16:
      hx = 16;
      break;
    case 17:
      hx = 17;
      break;
    case 18:
      hx = 18;
      break;
    case 19:
      hx = 19;
      break;
    case 20:
      hx = 20;
      break;
    case 21:
      hx = 21;
      break;
    case 22:
      hx = 22;
      break;
    case 23:
      hx = 23;
      break;
    default://上記以外
      break;//なにもしないでループを抜ける
    }
  }
  if (hantei[hx][hy] > 0) {//判定用配列の中身を確認
    count = count + 1;//当たったブロックのカウント
    hantei[hx][hy] = hantei[hx][hy] - 1;//配列の中身から１引く
    if (hantei[hx][hy] == 0) {
      blockbreak(hx, hy);//配列の中身が０になったらブロック消去関数を呼び出す
    }
    return true;
  } else if (hantei[hx][hy] == 0) {//配列の中身が０だったらブロック消去関数を呼び出す
    return false;
  } else {
    return false;
  }
}

//以上が（一部拡張が含まれるが）基本部分
//以下、拡張部分

//軌道変更
//なぜかサルガッソー海から名前を取った
void sargasso_zone() {//軌道変更領域描画関数
  fill(255, 255, 255, 0);
  strokeWeight(5);
  stroke(107, 142, 35);
  line(300, 500, width - 300, 500);//線
}

boolean sargasso(int hitx, int hity) {//軌道変更領域に入ったか確認
  if ((hitx > 300)&&(hitx < width - 300)) {//ボールの座標判定
    if ((hity <= 505)&&(hity >= 495)) {//ボールの座標判定
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

void enddraw() {//終了画面描画
  fill(255);
  noStroke();
  rect(0, 0, width, height);//全て白の矩形で隠す
  frameRate(2);
  fill(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)));
  //ゆっくりランダムで文字の色が変わる
  textSize(100);
  text("Congratulations!", 220, 350);//おめでたい
  fill(0);
  textSize(50);
  text("Enter → exit", 450, 500);//エンターを押すと閉じると知らせる
}

void keyPressed() {//エンターを押して終わらせる関数
  if (key == ENTER) {
    exit();//ウィンドウを閉じる
  } else {//何かのキーが押されると
    endf = 1;//終了画面描画関数が実行される
  }
}