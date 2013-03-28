//+------------------------------------------------------------------+
//|                                          FiboTrading20_alert.mq4 |
//|                      Copyright © 2011, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2011, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Yellow
#property indicator_color2 Crimson


double CrossUp1[];
double CrossDown1[];

double ExtHAOpenNow[4000];
double ExtHAOpenAfter[4000];
double ExtHAOpenPrevious[4000];
double ExtHALowPrevious[4000];
double ExtHAHighPrevious[4000];


double ExtHACloseNow[4000];
double ExtHACloseAfter[4000];
double ExtHAClosePrevious[4000];

int    MAPeriod=100;
int    MAType=0;
int    MAMode=0;

double fibo1 = 5.5;
double fibo2 = 9;
double fibo3 = 14.5;
double fibo4 = 23.6;
double fibo5 = 38.2;
double fibo6 = 50;
double fibo7 = 61.8;

//---- buffers
double LineBuffer[4000];
double Fib1[4000];
double Fib2[4000];
double Fib3[4000];
double Fib4[4000];
double Fib5Now[4000];
double Fib5After[4000];
double Fib5Prev[4000];
double Fib6[4000];
double Fib7Now[4000];
double Fib7After[4000];
double Fib7Prev[4000];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   SetIndexStyle(0, DRAW_ARROW);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, CrossUp1);
   SetIndexStyle(1, DRAW_ARROW);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, CrossDown1);
   
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
   int limit, i, counter;
   double Range, AvgRange, MA, MANow,MAAfter,MAPrev;
  
   int counted_bars=IndicatorCounted();
   //---- check for possible errors
   if(counted_bars<0) return(-1);
   //---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;

   limit=Bars-counted_bars;
   
   for(i=0; i<=limit; i++)
     {
     counter=i;
         Range=0;
         AvgRange=0;
         CrossUp1[i]=EMPTY_VALUE;
         CrossDown1[i]=EMPTY_VALUE;
         
         
         for (counter=i ;counter<=i+9;counter++)
         {
            AvgRange=AvgRange+MathAbs(High[counter]-Low[counter]);
         }
         Range=AvgRange/10;
         
         
         MANow = iMA(NULL,0,MAPeriod,0,MAMode,PRICE_CLOSE,i);
         MAAfter = iMA(NULL,0,MAPeriod,0,MAMode,PRICE_CLOSE,i);
         MAPrev = iMA(NULL,0,MAPeriod,0,MAMode,PRICE_CLOSE,i);
         
         Fib1[i] = MA + fibo1*Point;
         Fib2[i] = MA + fibo2*Point;
         Fib3[i] = MA + fibo3*Point;
         Fib4[i] = MA + fibo4*Point;
         Fib5Now[i] = MANow + fibo5*Point;         
         Fib5After[i] = MAAfter + fibo5*Point;         
         Fib5Prev[i] = MAPrev + fibo5*Point;  
         Fib6[i] = MA + fibo6*Point;
         Fib7Now[i] = MANow + fibo7*Point;         
         Fib7After[i] = MAAfter + fibo7*Point;         
         Fib7Prev[i] = MAPrev + fibo7*Point;         
      
      
         ExtHAOpenNow[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 2,i);
         ExtHAOpenAfter[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 2,i-1);
         ExtHAOpenPrevious[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 2,i+1);
         
         ExtHALowPrevious[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 0,i+1);
         ExtHAHighPrevious[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 1,i+1);
         
         ExtHACloseNow[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 3,i);
         ExtHACloseAfter[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 3,i-1);
         ExtHAClosePrevious[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 3,i+1);
         
         //Print(" MA ", MA, "Fib1 ", Fib1[i], "Fib7 ", Fib7[i] , " Point ", Point, " fibo1 ", fibo1);
         
         // Fib5
         if (  (ExtHAClosePrevious[i] < Fib5Prev[i] )
            && ExtHACloseNow[i] > Fib5Now[i] 
            && ExtHACloseAfter[i] > Fib5After[i]      
            )
         {
            CrossUp1[i] =  Fib5Now[i] - Range*0.5;
            //Print("ExtHAClosePrevious[i] ", ExtHAClosePrevious[i], "Fib7 ", Fib7Prev[i] );
            
         }else if 
            ( ( ExtHAClosePrevious[i] > Fib5Prev[i] )
            && ExtHACloseNow[i]< Fib5Now[i] 
            && ExtHACloseAfter[i] <= Fib5After[i]          
            )
         {
            CrossDown1[i] = Fib5Now[i] + Range*0.5;          
         }    

/*
         // Fib7
         if (  (ExtHAClosePrevious[i] < Fib7Prev[i] )
            && ExtHACloseNow[i] > Fib7Now[i] 
            && ExtHACloseAfter[i] > Fib7After[i]      
            )
         {
            CrossUp1[i] =  Fib7Now[i] - Range*0.5;
            //Print("ExtHAClosePrevious[i] ", ExtHAClosePrevious[i], "Fib7 ", Fib7Prev[i] );
            
         }else if 
            ( ( ExtHAClosePrevious[i] > Fib7Prev[i] )
            && ExtHACloseNow[i]< Fib7Now[i] 
            && ExtHACloseAfter[i] <= Fib7After[i]          
            )
         {
            CrossDown1[i] = Fib7Now[i] + Range*0.5;          
         }           */
         
         
                  
      }
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+