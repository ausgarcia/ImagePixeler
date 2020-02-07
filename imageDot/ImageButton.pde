class ImageButton{
  //variables
  private PImage image;
  private float x;
  private float y;
  private float maxX;
  private float maxY;
  private float w;
  private float h;
  
  //Constructor
  ImageButton(PImage _image, float _x, float _y, float _maxX, float _maxY, Boolean landscape){
    image = _image;
    x = _x;
    y = _y;
    maxX = _maxX;
    maxY = _maxY;
  }
  
  //Methods
  void display(){
    if(landscape){
      w = maxX;
      h = (maxX*image.height)/image.width;
    }else{
      w = (maxY*image.width)/image.height;
      h = maxY;
    }
    
    
    imageMode(CENTER);
    image(image, x, y, w, h);
  }
  
  void mousePressed(){
    Boolean mouseOver = pointRect(mouseX, mouseY, x,y,w,h);
    if(mouseOver){
      setImage(image);
      changeScene("image");
    }
  }
  
  
}

boolean pointRect(float px, float py, float rx, float ry, float rw, float rh) {

  // is the point inside the rectangle's bounds?
  if (px >= rx - rw/2 &&        // right of the left edge AND
      px <= rx + rw/2 &&   // left of the right edge AND
      py >= ry - rh/2 &&        // below the top AND
      py <= ry + rh/2) {   // above the bottom
        return true;
  }
  return false;
}
