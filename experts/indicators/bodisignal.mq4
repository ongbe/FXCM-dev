//+------------------------------------------------------------------+
//|                                                   bodisignal.mq4 |
//|                        Copyright 2012, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2012, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Lime
#property indicator_color2 Red

double CrossUp[];
double CrossDown[];
extern int FasterEMA = 15;
extern int SlowerEMA = 30;
extern int MaMode = 2;
extern int MAperiod = 30;
extern int MaSigMode = 1;
extern bool SoundON=false;
double alertTag;
double control=2147483647;
 
 
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   SetIndexStyle(0, DRAW_ARROW, EMPTY,2);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, CrossUp);
   SetIndexStyle(1, DRAW_ARROW, EMPTY,2);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, CrossDown);
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
   double fasterBodinow, slowerBodinow, fasterBodiprevious,fasterBodiPprevious, slowerBodiprevious, slowerBodiPprevious, fasterBodiafter, slowerBodiafter;
   double MAUp_now, MADown_now;
   double Range, AvgRange;
   int counted_bars=IndicatorCounted();
//---- check for possible errors
   if(counted_bars<0) return(-1);
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;

   limit=Bars-counted_bars;
   
   for(i = 1; i <= limit; i++) {
   
      counter=i;
      Range=0;
      AvgRange=0;
      for (counter=i ;counter<=i+9;counter++)
      {
         AvgRange=AvgRange+MathAbs(High[counter]-Low[counter]);
      }
      Range=AvgRange/10;
       
      /*fasterBodinow = iCustom(NULL, 0, "BoDi", FasterEMA, 0, MODE_SMMA, PRICE_CLOSE, i);     
      fasterBodiprevious = iCustom(NULL, 0, "BoDi", FasterEMA, 0, MODE_SMMA, PRICE_CLOSE, i+1);
      fasterBodiafter = iCustom(NULL, 0, "BoDi", FasterEMA, 0, MODE_SMMA, PRICE_CLOSE, i-1);

      slowerBodinow = iCustom(NULL, 0, "BoDi", SlowerEMA, 0, MODE_SMMA, PRICE_CLOSE, i);
      slowerBodiprevious = iCustom(NULL, 0,"BoDi", SlowerEMA, 0, MODE_SMMA, PRICE_CLOSE, i+1);
      slowerBodiafter = iCustom(NULL, 0, "BoDi", SlowerEMA, 0, MODE_SMMA, PRICE_CLOSE, i-1);*/
      
      fasterBodinow = iBoDifunc(NULL,NULL,FasterEMA,0,0,MaMode,i);
      fasterBodiprevious = iBoDifunc(NULL,NULL,FasterEMA,0,0,MaMode,i+1);
      fasterBodiPprevious = iBoDifunc(NULL,NULL,FasterEMA,0,0,MaMode,i+2);
      fasterBodiafter = iBoDifunc(NULL,NULL,FasterEMA,0,0,MaMode,i-1);
      
      slowerBodinow = iBoDifunc(NULL,NULL,SlowerEMA,0,0,MaMode,i);
      slowerBodiprevious = iBoDifunc(NULL,NULL,SlowerEMA,0,0,MaMode,i+1);
      slowerBodiPprevious = iBoDifunc(NULL,NULL,SlowerEMA,0,0,MaMode,i+2);
      slowerBodiafter = iBoDifunc(NULL,NULL,SlowerEMA,0,0,MaMode,i-1);      
      
      
      MAUp_now    = iCustom(NULL,NULL, "MA in Color", MAperiod, MaSigMode, 1,i);  
      MADown_now  = iCustom(NULL,NULL, "MA in Color", MAperiod, MaSigMode, 2,i);  
      
      
      if ((fasterBodiPprevious > fasterBodiprevious && fasterBodiprevious < fasterBodinow && fasterBodiafter > fasterBodinow )
         && (slowerBodiPprevious > slowerBodiprevious && slowerBodiprevious < slowerBodinow && slowerBodiafter > slowerBodinow )
         && (MAUp_now != EMPTY_VALUE))
      {
         CrossUp[i] = Low[i] - Range*0.8;
      }

     if ((fasterBodiPprevious > fasterBodiprevious && fasterBodiprevious < fasterBodinow && fasterBodiafter > fasterBodinow )
         && (slowerBodiPprevious > slowerBodiprevious && slowerBodiprevious < slowerBodinow && slowerBodiafter > slowerBodinow )
         && (MADown_now != EMPTY_VALUE))
      {
         CrossDown[i] = High[i] + Range*0.8;
      }
          
                      
      /*if ((fasterBodinow > slowerBodinow) && (fasterBodiprevious < slowerBodiprevious) && (fasterBodiafter > slowerBodiafter)) {
         CrossUp[i] = Low[i] - Range*0.5;
      }
      else if ((fasterBodinow < slowerBodinow) && (fasterBodiprevious > slowerBodiprevious) && (fasterBodiafter < slowerBodiafter)) {
          CrossDown[i] = High[i] + Range*0.5;
      }
        if (SoundON==true && i==1 && CrossUp[i] > CrossDown[i] && alertTag!=Time[0]){
         Alert("Bodi Cross Trend going Down on ",Symbol()," ",Period());
        alertTag = Time[0];
      }
        if (SoundON==true && i==1 && CrossUp[i] < CrossDown[i] && alertTag!=Time[0]){
       Alert("Bodi Cross Trend going Up on ",Symbol()," ",Period());
        alertTag = Time[0];
        } */
  }
//----
   
//----
   return(0);
  }
  
  
  //--------------------------------------------- iBoDifunc() - start
//+----------------------------------------------------------------------------+
//| Input parameters:                                                          |
//|   Sy - Symbol.                                                             |
//|   Tf - Timeframe.                                                          |
//|   BoDi_per - Averaging period.                                             |
//|   BoDi_shift - The indicator shift relative to the chart.                  |
//|   Applied_price - Applied price.                                           |
//|   BoDi_MA_mode - Applied MA method.                                        |
//|   Shift - Index of the value taken from the indicator buffer.              |
//+----------------------------------------------------------------------------+
//|   Formula to calculate BoDi:                                               |
//}   BoDi = (UpperLine - LowerLine)*1000                                      |
//|    where: UpperLine - upper line of Bollinger Bands                        |
//|           LowerLine - lower line of Bollinger Bands                        |
//|           1000 - coefficient for better visualization                      |
//+----------------------------------------------------------------------------+


double iBoDifunc(string Sy,int Tf,int BoDi_per,int BoDi_shift,int Applied_price,int BoDi_MA_mode,int Shift)
{  
double ML, sum=0.0, a;
if (Sy=="" || Sy=="0") Sy=Symbol();
  
ML=iMA(Sy,Tf,BoDi_per,BoDi_shift,BoDi_MA_mode,Applied_price,Shift);
for (int i=Shift; i<=BoDi_per-1+Shift; i++)
{  switch(Applied_price)   
{  case PRICE_CLOSE:    a=iClose(Sy,Tf,i+BoDi_shift)-ML; break;
   case PRICE_OPEN:     a=iOpen (Sy,Tf,i+BoDi_shift)-ML; break;
   case PRICE_HIGH:     a=iHigh (Sy,Tf,i+BoDi_shift)-ML; break;
   case PRICE_LOW:      a=iLow  (Sy,Tf,i+BoDi_shift)-ML; break;
   case PRICE_MEDIAN:   a=(iHigh(Sy,Tf,i+BoDi_shift)+iLow(Sy,Tf,i+BoDi_shift))/2.0-ML; break;
   case PRICE_TYPICAL:  a=(iHigh(Sy,Tf,i+BoDi_shift)+iLow(Sy,Tf,i+BoDi_shift)+iClose(Sy,Tf,i+BoDi_shift))/3.0-ML; break;
   case PRICE_WEIGHTED: a=(iHigh(Sy,Tf,i+BoDi_shift)+iLow(Sy,Tf,i+BoDi_shift)+2*iClose(Sy,Tf,i+BoDi_shift))/4.0-ML; break;
   default: a=0.0;
}
sum+=a*a;
}
double semi_res=MathSqrt(sum/BoDi_per);
double upper=ML+semi_res;
double lower=ML-semi_res;
double diff=(upper-lower)*1000;
return (diff);
}
//--------------------------------------------- iBoDifunc() - end

