//+------------------------------------------------------------------+
//|                                 ReversalPrice_CrossIndicator.mq4 |
//|                      Copyright © 2011, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2011, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Yellow
#property indicator_color2 Crimson
#property indicator_color3 Coral
#property indicator_color4 DarkViolet

#property indicator_width3 3
#property indicator_width4 3


//---- buffers
double ExtMapBuffer1Now[4000];
double ExtMapBuffer6Now[4000];
double ExtMapBuffer1After[4000];
double ExtMapBuffer6After[4000];
double ExtMapBuffer1Previous[4000];
double ExtMapBuffer6Previous[4000];


double ExtHAOpenNow[4000];
double ExtHAOpenAfter[4000];
double ExtHAOpenPrevious[4000];
double ExtHALowPrevious[4000];
double ExtHAHighPrevious[4000];

double ExtRealPriceUp[4000];
double ExtRealPriceDown[4000];

double ExtHACloseNow[4000];
double ExtHACloseAfter[4000];
double ExtHAClosePrevious[4000];

double CrossUp1[];
double CrossDown1[];
double CrossUp2[];
double CrossDown2[];

double WelchBBWidth_Green[400];
double WelchBBWidth_Yellow[400];
double WelchBBWidth_Red[400];



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
   SetIndexStyle(2, DRAW_ARROW);
   SetIndexArrow(2, 241);
   SetIndexBuffer(2, CrossUp2);
   SetIndexStyle(3, DRAW_ARROW);
   SetIndexArrow(3, 242);
   SetIndexBuffer(3, CrossDown2);   
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
  
int areWeRanging(int period=0) 
{
 double WelchBBWidth_Green = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 0, period);
 double WelchBBWidth_Yellow = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 1, period);

 if ( WelchBBWidth_Green > 0 ) 
 {
   return (1);
 } 
 else if ( WelchBBWidth_Yellow > 0) 
 {
   return (-1);
 }

 return (0);
}  

/*
int period=0; // how far back do you want to look? 0 == current bar. 1 == previous bar, etc.
              // At any given time, only one of these 3 will have a value greater than 0. That value is 300.

double WelchBBWidth_Green = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 0, period);
double WelchBBWidth_Yellow = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 1, period);
double WelchBBWidth_Red = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 2, period);

// This will give you the actual width in PIPs of the Bollinger Bands
double WelchBBWidth = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 3, period);

// These will give you the actual Bollinger Band Line values.
// These are the values that would be plotted on the MAIN chart, so it's based on price on the chart.
double WelchBBWidth_MiddleLine = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 4, period);
double WelchBBWidth_UpperLine = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 5, period);
double WelchBBWidth_LoweLine = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 6, period); 
*/

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int limit, i, counter;
   double Range, AvgRange;
  
   int counted_bars=IndicatorCounted();
   //---- check for possible errors
   if(counted_bars<0) return(-1);
   //---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;

   limit=Bars-counted_bars;
   
   for(i=1; i<=600; i++)
     {
     
         CrossUp1[i] =EMPTY_VALUE;
         CrossDown1[i] =EMPTY_VALUE;
         CrossUp2[i] =EMPTY_VALUE;
         CrossDown2[i] =EMPTY_VALUE;
         ExtRealPriceUp[i]=EMPTY_VALUE;
         ExtRealPriceDown[i]=EMPTY_VALUE;
         WelchBBWidth_Green[i] =EMPTY_VALUE;
         WelchBBWidth_Yellow[i] = EMPTY_VALUE;
         WelchBBWidth_Red[i] = EMPTY_VALUE;
     
         counter=i;
         Range=0;
         AvgRange=0;
         
         for (counter=i ;counter<=i+9;counter++)
         {
            AvgRange=AvgRange+MathAbs(High[counter]-Low[counter]);
         }
         Range=AvgRange/10;
      
         ExtMapBuffer1Now[i]=iMA(NULL,0,30,0,MODE_EMA,PRICE_CLOSE,i);
         ExtMapBuffer6Now[i]=iMA(NULL,0,60,0,MODE_EMA,PRICE_CLOSE,i);
         ExtMapBuffer1After[i]=iMA(NULL,0,30,0,MODE_EMA,PRICE_CLOSE,i-1);
         ExtMapBuffer6After[i]=iMA(NULL,0,60,0,MODE_EMA,PRICE_CLOSE,i-1); 
         ExtMapBuffer1Previous[i]=iMA(NULL,0,30,0,MODE_EMA,PRICE_CLOSE,i+1);
         ExtMapBuffer6Previous[i]=iMA(NULL,0,60,0,MODE_EMA,PRICE_CLOSE,i+1);  
         
         ExtRealPriceUp[i]=iCustom(Symbol(),NULL, "Slope Direction Line",250,2,3, 0,i+1);
         ExtRealPriceDown[i]=iCustom(Symbol(),NULL, "Slope Direction Line",250,2,3, 0,i+1);
         
         WelchBBWidth_Green[i] = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 0, i+1);
         WelchBBWidth_Yellow[i] = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 1, i+1);
         WelchBBWidth_Red[i] = iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 2, i+1);       
         
         //Print(i, " " , ExtMapBuffer1[i], " " , iMA(NULL,0,30,0,MODE_EMA,PRICE_CLOSE,i));
         /*
         if ((ExtMapBuffer1Now[i] > ExtMapBuffer6Now[i])
             && (ExtMapBuffer1Previous[i] < ExtMapBuffer6Previous[i]) 
             && (ExtMapBuffer1After[i] > ExtMapBuffer6After[i]))             
         {
           CrossUp[i] =  Low[i] - Range*0.8; 
         }else if ((ExtMapBuffer1Now[i] < ExtMapBuffer6Now[i])
             && (ExtMapBuffer1Previous[i] > ExtMapBuffer6Previous[i]) 
             && (ExtMapBuffer1After[i] < ExtMapBuffer6After[i]))
         {
            CrossDown[i] = High[i] + Range*0.2;
         }
         */
         
         ExtHAOpenNow[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 2,i);
         ExtHAOpenAfter[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 2,i-1);
         ExtHAOpenPrevious[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 2,i+1);
         ExtHALowPrevious[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 0,i+1);
         ExtHAHighPrevious[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 1,i+1);
         
         
         ExtHACloseNow[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 3,i);
         ExtHACloseAfter[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 3,i-1);
         ExtHAClosePrevious[i] =iCustom(Symbol(),NULL, "Heiken Ashi", 3,i+1);
         
         
         // MA 30
         if (  ( ExtHAClosePrevious[i] < ExtMapBuffer1Previous[i] || ExtHALowPrevious[i] < ExtMapBuffer1Previous[i] ) 
            && ExtHACloseNow[i] > ExtMapBuffer1Now[i] 
            && ExtHACloseAfter[i] > ExtMapBuffer1After[i]
            && ExtMapBuffer1After[i] > ExtMapBuffer6After[i] // MA 30 
            && ExtHAOpenNow[i] < ExtHACloseNow[i]   
            //&& ExtHACloseNow[i] >  ExtRealPriceUp[i]       
           // && (WelchBBWidth_Yellow[i] != EMPTY_VALUE || WelchBBWidth_Red[i] != EMPTY_VALUE)
            )
         {
            CrossUp1[i] =  ExtHAOpenNow[i] - Range*0.5;
            //Print("ExtMapBuffer1After[i] ", ExtMapBuffer1After[i]); 
         }else if 
            ( (ExtHAClosePrevious[i] > ExtMapBuffer1Previous[i]  || ExtHAHighPrevious[i] > ExtMapBuffer1Previous[i] ) 
            && ExtHACloseNow[i]< ExtMapBuffer1Now[i] 
            && ExtHACloseAfter[i] < ExtMapBuffer1After[i]
            && ExtMapBuffer1After[i] < ExtMapBuffer6After[i]
            && ExtHAOpenNow[i] > ExtHACloseNow[i]     
            //&& ExtHACloseNow[i]< ExtRealPriceDown[i]     
            //&& (WelchBBWidth_Yellow[i] != EMPTY_VALUE || WelchBBWidth_Red[i] != EMPTY_VALUE) 
            )
         {
            CrossDown1[i] = ExtHAOpenNow[i] + Range*0.5;
         }  
         
        
         // MA60
         if (  ExtHAClosePrevious[i] < ExtMapBuffer6Previous[i] 
            && ExtHACloseNow[i] > ExtMapBuffer6Now[i] 
            && ExtHACloseAfter[i] > ExtMapBuffer6After[i]
            && ExtHAOpenNow[i] < ExtHACloseNow[i]          
            )
         {
            CrossUp2[i] =  ExtHAOpenNow[i] - Range*0.5;
            //Print("ExtMapBuffer6After[i] ", ExtMapBuffer6After[i]); 
         }else if 
            ( ExtHAClosePrevious[i] > ExtMapBuffer6Previous[i] 
            && ExtHACloseNow[i]< ExtMapBuffer6Now[i] 
            && ExtHACloseAfter[i] < ExtMapBuffer6After[i]
            && ExtHAOpenNow[i] > ExtHACloseNow[i]             
            )
         {
            CrossDown2[i] = ExtHAOpenNow[i] + Range*0.5;
         }  
         
         
                 
                  
      }
  
   
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+