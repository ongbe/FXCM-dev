//+------------------------------------------------------------------+
//|                                               volatility T20.mq4 |
//|                      Copyright © 2011, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2011, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window
#property indicator_buffers 8
#property indicator_color1 White
#property indicator_color2 Maroon
#property indicator_color3 Orange
#property indicator_color4 Gold
#property indicator_color5 LightSeaGreen
#property indicator_color6 DarkGreen
#property indicator_color7 Chartreuse
#property indicator_color8 Lime


//---- indicator parameters
extern int    BandsPeriod=100;
extern int    BandsShift=0;
extern double BandsDeviations=2.0;


//---- buffers
double MovingBuffer[];
double UpperR1Buffer[];
double UpperR2Buffer[];
double UpperR3Buffer[];
double UpperR4Buffer[];
double LowerS1Buffer[];
double LowerS2Buffer[];
double LowerS3Buffer[];
double LowerS4Buffer[];

//---- buffers
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
//---- indicators
   SetIndexStyle(0,DRAW_LINE, STYLE_DOT,2);
   SetIndexBuffer(0,MovingBuffer);
   SetIndexStyle(1,DRAW_LINE, STYLE_DASH);
   SetIndexBuffer(1,LowerS1Buffer);
   SetIndexStyle(2,DRAW_LINE, STYLE_DOT);
   SetIndexBuffer(2,LowerS2Buffer);
   SetIndexStyle(3,DRAW_LINE, STYLE_DASHDOT);
   SetIndexBuffer(3,LowerS3Buffer);
   SetIndexStyle(4,DRAW_LINE, STYLE_DASHDOTDOT);
   SetIndexBuffer(4,LowerS4Buffer);
   
   
      
//----
   SetIndexDrawBegin(0,BandsPeriod);
   SetIndexDrawBegin(1,BandsPeriod);
   SetIndexDrawBegin(2,BandsPeriod);
   SetIndexDrawBegin(3,BandsPeriod);
   SetIndexDrawBegin(4,BandsPeriod);
   SetIndexDrawBegin(5,BandsPeriod);
   SetIndexDrawBegin(6,BandsPeriod);
   SetIndexDrawBegin(7,BandsPeriod);
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int    i,k,counted_bars=IndicatorCounted();
   double deviation;
   double sum,oldval,newres;
//----
   if(Bars<=BandsPeriod) return(0);
//---- initial zero
   if(counted_bars<1)
      for(i=1;i<=BandsPeriod;i++)
        {
         //MovingBuffer[Bars-i]=EMPTY_VALUE;
         UpperR1Buffer[Bars-i]=EMPTY_VALUE;
         LowerS1Buffer[Bars-i]=EMPTY_VALUE;
        }
//----
   int limit=Bars-counted_bars;
   if(counted_bars>0) limit++;
   for(i=0; i<limit; i++)
      MovingBuffer[i]=iMA(NULL,0,BandsPeriod,BandsShift,MODE_SMA,PRICE_CLOSE,i);
//----
   i=Bars-BandsPeriod+1;
   if(counted_bars>BandsPeriod-1) i=Bars-counted_bars-1;
   while(i>=0)
     {
      sum=0.0;
      k=i+BandsPeriod-1;
      oldval=MovingBuffer[i];
      while(k>=i)
        {
         newres=Close[k]-oldval;
         sum+=newres*newres;
         k--;
        }
      //deviation=BandsDeviations*MathSqrt(sum/BandsPeriod);
      
      UpperR1Buffer[i]=oldval+BandsDeviations*MathSqrt(sum/BandsPeriod);
      UpperR2Buffer[i]=oldval+(BandsDeviations-0.5)*MathSqrt(sum/BandsPeriod);
      UpperR3Buffer[i]=oldval+(BandsDeviations-1)*MathSqrt(sum/BandsPeriod);
      UpperR4Buffer[i]=oldval+(BandsDeviations-1.5)*MathSqrt(sum/BandsPeriod);
           
      
      LowerS4Buffer[i]=oldval-BandsDeviations*MathSqrt(sum/BandsPeriod);
      LowerS3Buffer[i]=oldval-(BandsDeviations-0.5)*MathSqrt(sum/BandsPeriod);
      LowerS2Buffer[i]=oldval-(BandsDeviations-1)*MathSqrt(sum/BandsPeriod);
      LowerS1Buffer[i]=oldval-(BandsDeviations-1.5)*MathSqrt(sum/BandsPeriod);
      
      i--;
     }   
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+