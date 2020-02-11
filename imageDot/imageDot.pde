PImage img;
int iw;
int ih;
int divMax;
color[][] imageGrid;
int[][] splitVal;
boolean setup = true;
int[] prevPos = new int[2];
String currentScene;
public PImage selectedImage = null;
Boolean drawn;
Boolean landscape;
ImageButton[] buttonList;
//import Surface;

void setup(){
  //size(1000,800);
  fullScreen();
  background(0);
  textAlign(CENTER);
  textSize(80);
  fill(255);
  text("Loading...", width/2, height/2); 
  drawn = false;
  currentScene = "menu";
  if(width>height){ //landscape image
    landscape = true;
  }else{ // square or portrait image
    landscape = false;
  }
}

void draw(){
  if(currentScene == "menu" && !drawn){
    drawn = true;
    String[] lines = loadStrings("images.txt");
    buttonList = new ImageButton[lines.length];
    background(0);
    
    for(int i = 0; i < 4; i++){
      PImage image = loadImage(lines[i]);
      //PImage image = loadImage("tree.jpg");
      ImageButton button;
      if(landscape){
        button = new ImageButton(image, (float)width/lines.length*i + (width/lines.length)/2, (float)height/2, (float)width/lines.length, (float)height, landscape);
      }else{
        button = new ImageButton(image, (float)width/2, (float)height/lines.length*i + (height/lines.length)/2, (float)width, (float)height/lines.length, landscape);
      }
      
      buttonList[i] = button;
      button.display();
    }
    setup = true;
  }
  else if(currentScene == "image"){
    
    if(setup){
      setupImage();
    }
    int xLeft = width/2-iw/2;
    int xRight = width/2+iw/2;
    int yTop = height/2-ih/2;
    int yBottom = height/2+ih/2;
    
    //check if inside picture bounds
    if((mouseX != prevPos[0] && mouseY != prevPos[1]) && mouseX > xLeft && mouseX < xRight && mouseY > yTop && mouseY < yBottom){
      int divNum = splitVal[mouseX-xLeft][mouseY-yTop];
      //println(divNum);
      if(divNum!=0 && divNum < divMax && (int)iw/divNum != 0 && (int)ih/divNum != 0){//check if 0<divNum<divMax and any /0 errors
        //println(divNum);
        float divWidth = iw/divNum;
        float divHeight = ih/divNum;
        float xdiv = (int)((mouseX-xLeft)/divWidth);
        float ydiv = (int)((mouseY-yTop)/divHeight);
        rectMode(CORNER);
        //println("mouseX: "+(mouseX-xLeft)+" divWidth:"+divWidth + "xdiv: "+xdiv+" ydiv:"+ydiv);
        //if(xdiv == 0 && ydiv == 0){//if touching top left quadrant//get rid of this
        
        //top left quadrant
        int r=0;
        int g=0;
        int b=0;
        int counter=0;
          //use this one //println("divNum:"+ divNum + "  iw:" + iw + "  ih:" + ih + "  xdiv*divWidth:" + (xdiv*divWidth) + "  (xdiv+1)*divWidth-divWidth/2:" + ((xdiv+1)*divWidth-divWidth/2));
        for(int x = (int)(xdiv*divWidth); x < (xdiv)*divWidth+divWidth/2; x++){
          for(int y = (int)(ydiv*divHeight); y < (ydiv+1)*divHeight-divHeight/2;y++){
            //println("X: " + x + " Y: " + y + " IGX: " + imageGrid.length + " IGY: " + imageGrid[x].length + " xdiv: " + xdiv + " divWidth: " + divWidth + " max:" + (xdiv+1)*divWidth);
            //println("X: " + x + " Y: " + y + " IGX: " + imageGrid.length + " xdiv: " + xdiv + " divWidth: " + divWidth + " max:" + (xdiv)*divWidth+divWidth/2);
            r+=red(imageGrid[x][y]);          //this went out of bounds portrait right side && landscape bottom && landscape right
            g+=green(imageGrid[x][y]);
            b+=blue(imageGrid[x][y]);
            counter++;
          }
        }
        r/=counter;
        g/=counter;
        b/=counter;
        fill(r,g,b);//for in range get average color
        rect(xLeft+xdiv*divWidth, yTop+ydiv*divHeight, divWidth/2, divHeight/2);//draw top left quadrant
        
        //bottom left quadrant
        r=0;
        g=0;
        b=0;
        counter=0;
        for(int x = (int)(xdiv*divWidth); x < (xdiv+1)*divWidth-divWidth/2; x++){
          for(int y = (int)((ydiv+1)*divHeight-divHeight/2); y < (ydiv+1)*divHeight;y++){
            r+=red(imageGrid[x][y]);          //this went out of bounds portrait bottom, landscape bottom
            g+=green(imageGrid[x][y]);
            b+=blue(imageGrid[x][y]);
            counter++;
          }
        }
        r/=counter;
        g/=counter;
        b/=counter;
        fill(r,g,b);
        rect(xLeft+xdiv*divWidth, yTop+(ydiv+1)*divHeight-divHeight/2, divWidth/2, divHeight/2);//draw bottom left quadrant
        
        //top right quadrant
        r=0;
        g=0;
        b=0;
        counter=0;
        for(int x = (int)((xdiv)*divWidth+divWidth/2); x < (xdiv+1)*divWidth; x++){      //x gets too big
          for(int y = (int)(ydiv*divHeight); y < (ydiv+1)*divHeight;y++){
            //println("X: " + x + " Y: " + y + " IGX: " + imageGrid.length + " IGY: " + imageGrid[x].length + " xdiv: " + xdiv + " divWidth: " + divWidth + " max:" + (xdiv+1)*divWidth);
            r+=red(imageGrid[x][y]);            //this went out of bound portrait right
            g+=green(imageGrid[x][y]);
            b+=blue(imageGrid[x][y]);
            counter++;
          }
        }
        r/=counter;
        g/=counter;
        b/=counter;
        fill(r,g,b);
        rect(xLeft+(xdiv+1)*divWidth-divWidth/2, yTop+ydiv*divHeight, divWidth/2, divHeight/2);//draw top right quadrant
        
        //bottom right quadrant
        r=0;
        g=0;
        b=0;
        counter=0;
        for(int x = (int)((xdiv+1)*divWidth-divWidth/2); x < (xdiv+1)*divWidth; x++){
          for(int y = (int)((ydiv+1)*divHeight-divHeight/2); y < (ydiv+1)*divHeight;y++){
            r+=red(imageGrid[x][y]);
            g+=green(imageGrid[x][y]);
            b+=blue(imageGrid[x][y]);
            counter++;
          }
        }
        r/=counter;
        g/=counter;
        b/=counter;
        fill(r,g,b);
        rect(xLeft+(xdiv+1)*divWidth-divWidth/2, yTop+(ydiv+1)*divHeight-divHeight/2, divWidth/2, divHeight/2);//draw bottom right quadrant
        
        //}
        
        //make sure we dont divide too far. if 256 pixels, then dont div past 256
        //println("divNum:"+ divNum + "  iw;" + iw + "  ih:" + ih);
        if(divNum < iw && divNum < ih){//THIS MUST BE OFF SOMEWHERE BECAUSE ALREADY PLACED BOXES GET RECOVERED UP
          //if(xdiv%2 == 0 && ydiv%2 == 0){//top left of quadrant
          //println((xLeft+divWidth*xdiv) + " < " + (xRight-(iw-divWidth*(xdiv+1))));
          //println((divWidth*xdiv) + " < " + (divWidth*xdiv + divWidth));
          for(int x = (int)(divWidth*xdiv); x < (divWidth*xdiv + divWidth); x++){
            //println("ydiv: "+ydiv+"  "+(divHeight*ydiv) + " < " + (divHeight*ydiv + divHeight));
            for(int y = (int)(divHeight*ydiv); y < (divHeight*ydiv + divHeight); y++){
              splitVal[x][y]*=2;
              //println("x: "+x + "  y:"+y);
            }
          }
        }
        prevPos[0]=mouseX;
        prevPos[1]=mouseY;
      }
    }
  }
}

void setupImage(){
  
  imageMode(CENTER);
  rectMode(CENTER);
  img = selectedImage;//loadImage("tree.jpg");//overhang, waterfall, me, tree
  if(img.width>img.height){ //landscape image
    iw = width;
    ih = (width*img.height)/img.width;
    divMax = ih/2;
  }else{ // square or portrait image
    iw = (height*img.width)/img.height;
    ih = height;
    divMax = iw/2;
  }
  image(img, width/2, height/2, iw, ih);
  
  imageGrid = new color[iw][ih];
  splitVal = new int[iw][ih];
  prevPos[0]=0;
  prevPos[1]=0;
  //JUST MOVED EVERYTHING ABOVE THIS
  
  int r=0;
  int g=0;
  int b=0;
  int counter=0;
  //println((width/2-iw/2) +" minus "+ (width/2+iw/2));
  //println(iw);
  //println((height/2-ih/2) +" minus "+ (height/2+ih/2));
  //println(ih);
  for(int x = width/2-iw/2; x < width/2+iw/2; x++){
    for(int y = height/2-ih/2; y < height/2+ih/2; y++){
      imageGrid[x-(width/2-iw/2)][y-(height/2-ih/2)] = get(x,y);
      splitVal[x-(width/2-iw/2)][y-(height/2-ih/2)] = 1;
      r+=red(get(x,y));
      g+=green(get(x,y));
      b+=blue(get(x,y));
      counter++;
    }
  }
  r/=counter;
  g/=counter;
  b/=counter;
  setup = false;
  color c = color(r,g,b);
  //color c = get(mouseX, mouseY);
  fill(c);
  noStroke();
  background(0);
  rect(width/2, height/2, iw, ih);
  //println(iw);
  //println(ih);
}

public void setImage(PImage img){
  selectedImage = img;
}

public void changeScene(String name){
  currentScene = name;
}

void mousePressed(){
  for(int i = 0; i < buttonList.length; i++){
    buttonList[i].mousePressed();
  }
}

void keyReleased(){
  if (key == BACKSPACE && currentScene == "image"){
    drawn = false;
    changeScene("menu");
    setImage(null);
    setup = false;
    background(0);
    textAlign(CENTER);
    textSize(80);
    fill(255);
    text("Loading...", width/2, height/2); 
  }
}

public void onBackPressed(){
  if (currentScene == "image"){
    drawn = false;
    changeScene("menu");
    setImage(null);
    setup = false;
    background(0);
    textAlign(CENTER);
    textSize(80);
    fill(255);
    text("Loading...", width/2, height/2); 
  }
}

//Image Button Class, once I'm sure it works I can move it back to the other file
