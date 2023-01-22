static final int NUM_DOTS = 500;
static final int STEP = 2;
static final int REPEATAFTER = 2000000;

int t = STEP;
float x_a = random(25, 50);
float x_c = random(25, 50);
float y_a = random(25, 50); 
float y_c = random(25, 50);
float[][] old = new float[NUM_DOTS][2];
int curr = 0;

long kgV(int m, int n){
  if(m == 0 | n == 0)
  {
    return 0;
  } else
  {
    if(m > n)
    {
      int tmp = n;
      n = m;
      m = tmp;
    }
    long mCounter = m;
    while(mCounter <= (long)m * (long)n){
      if(mCounter % n == 0){
        return mCounter;
      }
      mCounter += m;
    }
    return -1;
  }
}

void rerand()
{
  for(int i = 0; i < NUM_DOTS; i++)
  {
    old[i][0] = x(t);
    old[i][1] = y(t);
  }
  int res = 1;
  while(res < REPEATAFTER)
  {
    x_a = random(25,50);
    x_c = random(25,50);
    y_a = random(25,50);
    y_c = random(25,50); 
    int tmp1 = (int)(x_a * 100000);
    int tmp2 = (int)(x_c * 100000);
    int tmp3 = (int)(y_a * 100000);
    int tmp4 = (int)(y_c * 100000);
    int tmp5 = (int)(kgV(tmp1, tmp2) / 10000000000L);
    int tmp6 = (int)(kgV(tmp3, tmp4) / 10000000000L);
    res = (int)kgV(tmp5, tmp6);
  }
}

void setup()
{
  frameRate(30);
  fullScreen();
  orientation(PORTRAIT);
  rerand();
}

void draw(){
   background(20);
   strokeWeight(4);
   translate(width / 2, height / 2);
   scale(1.7);
   old[curr][0] = x(t);
   old[curr][1] = y(t);
   curr++;
   if(curr >= NUM_DOTS)
   {
     curr = 0;
   }
   int tmpcur = NUM_DOTS;
   for(int i = curr; i < NUM_DOTS - 1; i++)
   {
     stroke(map(tmpcur, 0.0, NUM_DOTS, 255.0, 20.0));
     line(old[i][0], old[i][1], old[i + 1][0], old[i + 1][1]);
     tmpcur--;
   }
   if(curr != 0)
   {
     stroke(map(tmpcur, 0.0, NUM_DOTS, 255.0, 20.0));
     line(old[0][0], old[0][1], old[NUM_DOTS - 1][0], old[NUM_DOTS - 1][1]);
     tmpcur--;
   }
   for(int i = 0; i < curr - 1; i++)
   {
     stroke(map(tmpcur, 0.0, NUM_DOTS, 255.0, 20.0));
     line(old[i][0], old[i][1], old[i + 1][0], old[i + 1][1]);
     tmpcur--;
   }
   t += STEP;
   if((t / STEP) % REPEATAFTER == 0)
   {
    t = STEP;
    rerand();
   }
}

float x(float ts)
{
   return (sin(ts / x_a) + sin(ts / x_c)) * 100;
}

float y(float ts)
{
   return (cos(ts / y_a) + cos(ts / y_c)) * 100; 
}
