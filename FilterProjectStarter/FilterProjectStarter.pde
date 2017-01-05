/*******************************************
 *                                         * 
 * Image Filter Project starter code       *
 *                                         *
 * UTeach CSP                              *
 * Bradley Beth                            *
 * rev. 20160927                           * 
 *                                         *
 * Search this source code for the phrase  *
 * "complete this section" to locate the   *
 * targeted sections of code you must      *
 * complete.                               *
 *                                         *
 *******************************************/

boolean PicLoaded = false;
boolean Grayscale = false;
boolean martianEffect = false;
boolean emphasize = false;
boolean movePixels = false;
int picWidth = 0;
int picHeight = 0;
PImage img;

/***********************************/

void setup() 
{
  size(800, 480);
  background(185);
  textAlign(LEFT);
  textSize(16); 
}

void draw()
{

  background(185);
  noStroke();
  int picStart = 0;
  int picEnd = 0;
  
  /* draw buttons */

  stroke(0);
  fill(0);
  textSize(16);
  text("File Operations",665,30);
  line(650,0,650,480);
  noStroke();
  
  fill(255);
  rect(660, 50, 130, 40, 10);
  fill(55);
  text("Load Picture", 675, 75);

  fill(255);
  rect(660, 100, 130, 40, 10);
  fill(55);
  text("Save Picture", 675, 125);

  stroke(0);
  line(650,150,800,150);
  noStroke();

  stroke(0);
  fill(0);
  textSize(16);
  text("Filter Effects",675,180);
  line(650,0,650,480);
  noStroke();

  if (Grayscale)
    fill(#FFFF7D);    //Effect on means a yellow lighted button
  else
    fill(255);
  rect(660, 200, 130, 40, 10);
  fill(55);
  text("Grayscale", 680, 225);
  
  if (martianEffect)
    fill(#FFFF7D);    //Effect on means a yellow lighted button
  else
    fill(255);
  rect(660, 250, 130, 40, 10);
  fill(55);
  text("Martian Effect", 680, 275);

  if (emphasize)
    fill (#FFFF7D);     //Effect on means a yellow lighted button 
  else
    fill(255); 
  rect(660, 300, 130, 40, 10);
  fill(55);
  text("Emphasize Effect", 680, 325);

  if (movePixels)
    fill (#FFFF7D);    //Effect on means a yellow lighted button
  else
    fill(255);   
  rect(660, 350, 130, 40, 10);
  fill(55);
  text("Move Pixels", 680, 375);

  noStroke();
  textSize(16);

  //The following loads and displays an image file.
  //The image is resized to best fit in a 640x480 frame.
  if (PicLoaded)
  {     
    picWidth = img.width;
    picHeight = img.height;
    
    if (picWidth > 640)
    {
      picHeight = (int)(picHeight*(640.0/picWidth));
      picWidth = 640;
    }
    if (picHeight > 480)
    {
      picWidth = (int)(picWidth*(480.0/picHeight));
      picHeight = 480;
    }
    image(img, 0, 0, picWidth, picHeight);
    
    picStart = 0;
    picEnd = picStart+width*picHeight;

    loadPixels();
    
    /***** Effects Code *****/

    /* This sample grayscale code may serve as an example */
    if (Grayscale)
    {
      int i = picStart;
      while (i < picEnd) 
      {
        color c = pixels[i];
        float gray = (red(c)+green(c)+blue(c))/3.0;  //average the RGB colors
        pixels[i] = color(gray, gray, gray);
        i = i + 1;
        if (i % width >= picWidth)        // This will ignore anything on the line that 
          i = i + width - picWidth;       // after the image (such as buttons)
      }   
    }

    if (martianEffect) {
      int i = picStart;
      while (i < picEnd) {
        color c = pixels[i];
        pixels[i] = color(red(c) * 3, green(c - 10), blue(c - 10) / 3);// Martian Effect
        i = i + 1;
        if (i % width >= picWidth) {       // This will ignore anything on the line that
          i = i + width - picWidth;        // after the image (such as buttons)
        }
      }
    }

    if (emphasize)
    {
      int i = picStart;
      while (i < picEnd) 
      {
        color c = pixels[i];
        if (red(c) > (green(c) + blue(c))/2) {
          pixels[i] = color(red(c), 0, 0);
        }
        if (green(c) > (red(c) + blue(c))/2) {
          pixels[i] = color(0, green(c), 0);
        }
        if (blue(c) > (green(c) + red(c))/2) {
          pixels[i] = color(0, 0, blue(c));
        }
        i = i + 1;
        if (i % width >= picWidth)        // This will ignore anything on the line that 
          i = i + width - picWidth;       // after the image (such as buttons)
      }
    }
    
    if (movePixels) {
      int i = picStart;
      while (i < picEnd) {
        color c = pixels[i + int(random(100))];
        pixels[i] = color(red(c), green(c), blue(c));
        i = i + 1;
        if (i % width >= picWidth) {       // This will ignore anything on the line that
          i = i + width - picWidth;        // after the image (such as buttons)
        }
      }
    }
    
    updatePixels(); 
    redraw();
  }
  
  fill(255);
  noStroke();
}

void mouseClicked() {
  
  redraw();
}

void mousePressed()
{
  //The following define the clickable bounding boxes for any buttons used.
  //Note that these boundaries should match those drawn in the draw() function.
  
  if (mouseX>660 && mouseX<790 && mouseY>50 && mouseY<90)
  {
    selectInput("Select a file to process:", "infileSelected");
  }
  
  if (mouseX>660 && mouseX<790 && mouseY>100 && mouseY<140)
  {
    selectOutput("Select a file to write to:", "outfileSelected");
  }
  
  if (mouseX>660 && mouseX<790 && mouseY>200 && mouseY<240 && PicLoaded)
  {
    Grayscale = !Grayscale;
  }   
  
  if (mouseX>660 && mouseX<790 && mouseY>250 && mouseY<290 && PicLoaded)
  {
    martianEffect = !martianEffect;
  } 

  if (mouseX>660 && mouseX<790 && mouseY>300 && mouseY<340 && PicLoaded)
  {
    emphasize = !emphasize;
  }  

  if (mouseX>660 && mouseX<790 && mouseY>350 && mouseY<390 && PicLoaded)
  {
    movePixels = !movePixels;
  } 

  redraw();
}

void infileSelected(File selection) 
{
  if (selection == null) 
  {
    println("IMAGE NOT LOADED: Window was closed or the user hit cancel.");
  } 
  else 
  {
    println("IMAGE LOADED: User selected " + selection.getAbsolutePath());
    img = loadImage(selection.getAbsolutePath());
    PicLoaded = true;
    Grayscale = false;
    martianEffect = false;
    emphasize = false;
    movePixels = false;
    redraw();
  }
}

void outfileSelected(File selection) 
{
  if (selection == null) 
  {
    println("IMAGE NOT SAVED: Window was closed or the user hit cancel.");
  } 
  else 
  {
    println("IMAGE SAVED: User selected " + selection.getAbsolutePath() + ".png");
    noLoop();
    updatePixels();
    redraw();
    save(selection.getAbsolutePath()+".png");
    redraw();
    loop();
  }
}
