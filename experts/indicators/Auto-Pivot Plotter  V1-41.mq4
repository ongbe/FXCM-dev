//+------------------------------------------------------------------+
//|                                     Auto-Pivot Plotter V1-41.mq4 |
//|                                  Copyright � 2006, Elton Treloar |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright � 2006, Elton Treloar"
#property link      ""

#property indicator_chart_window
#property indicator_buffers 8
#property indicator_color1 FireBrick
#property indicator_color2 Red
#property indicator_color3 Orange
#property indicator_color4 White
#property indicator_color5 PaleGreen
#property indicator_color6 Chartreuse
#property indicator_color7 LimeGreen
#property indicator_color8 LimeGreen
#property indicator_style1 STYLE_SOLID
#property indicator_style2 STYLE_SOLID
#property indicator_style3 STYLE_SOLID
#property indicator_style4 STYLE_DASH
#property indicator_style5 STYLE_SOLID
#property indicator_style6 STYLE_SOLID
#property indicator_style7 STYLE_SOLID
#property indicator_style8 STYLE_SOLID


//---- input parameters
extern int       StartHour=6;
extern int       StartMinute=59;
extern int       DaysToPlot=5;
//---- buffers
double Res3[];
double Res2[];
double Res1[];
double Pivot[];
double Supp1[];
double Supp2[];
double Supp3[];
double Extra1[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   SetIndexStyle(0,DRAW_LINE,STYLE_SOLID);
   SetIndexBuffer(0,Res3);
   SetIndexStyle(1,DRAW_LINE,STYLE_SOLID);
   SetIndexBuffer(1,Res2);
   SetIndexStyle(2,DRAW_LINE,STYLE_SOLID);
   SetIndexBuffer(2,Res1);
   SetIndexStyle(3,DRAW_LINE,STYLE_DASH,1);
   SetIndexBuffer(3,Pivot);
   SetIndexStyle(4,DRAW_LINE,STYLE_SOLID);
   SetIndexBuffer(4,Supp1);
   SetIndexStyle(5,DRAW_LINE,STYLE_SOLID);
   SetIndexBuffer(5,Supp2);
   SetIndexStyle(6,DRAW_LINE,STYLE_SOLID);
   SetIndexBuffer(6,Supp3);
   SetIndexStyle(7,DRAW_LINE,STYLE_SOLID);
   SetIndexBuffer(7,Extra1);
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
   int    counted_bars=IndicatorCounted();
   
   if(counted_bars<0) return(-1);
   //---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;

   int limit=Bars-counted_bars;
   int StartMinutesIntoDay=(StartHour*60)+StartMinute; // 8' o'clock x 60 = 480
   //Print("StartMinutesIntoDay ", StartMinutesIntoDay);
   int CloseMinutesIntoDay=StartMinutesIntoDay+580;//-Period(); //
   
   // ****************************************************
   //    Check That cloes time isn't now a negative number.
   //    Correct if it is by adding a full day's worth 
   //    of minutes.
   // ****************************************************
   
   //Print("CloseMinutesIntoDay ", CloseMinutesIntoDay, " Period ", Period());   
   if (CloseMinutesIntoDay<0)
      {
         CloseMinutesIntoDay=CloseMinutesIntoDay+580;
      }
      
   //Print("CloseMinutesIntoDay ", CloseMinutesIntoDay, " Period ", Period());   
   // ****************************************************
   //    Establish the nuber of bars in a day.
   // ****************************************************
   int BarsInDay= 840/Period();
    
   // ******************************************************************************************
   // ******************************************************************************************
   //                                        Main Loop                                      
   // ******************************************************************************************
   // ******************************************************************************************
   
   for(int i=0; i<limit; i++)
   { 
      // ***************************************************************************
      //       Only do all this if we are within the plotting range we want.
      //       i.e. DaysToPlot 
      //       If DaysToPlot is "0" (zero) we plot ALL available data. This can be 
      //    VERY slow with a large history and at small time frames. Expect to
      //    wait if plotting a year or more on a say a five minute chart. On my PC 
      //    two years of data at Five Minutes takes around 30 seconds per indicator. 
      //    i.e. 30 seconds for main pivot levels indicator then another 30 seconds 
      //    to plot the seperate mid-levels indicator. 
      // ***************************************************************************
      if ( (i<((DaysToPlot+1)*BarsInDay))||DaysToPlot==0)   // Used to limit the number of days
      {                                                     // that are mapped out. Less waiting ;)
      
      // *****************************************************
      //    Find previous day's opening and closing bars.
      // *****************************************************
      
      int PreviousClosingBar = FindLastTimeMatchFast(CloseMinutesIntoDay,i+1);
      int PreviousOpeningBar = FindLastTimeMatchFast(StartMinutesIntoDay,PreviousClosingBar+1);
      
     
      
      double PreviousHigh= High[PreviousClosingBar];
      double PreviousLow = Low [PreviousClosingBar];
      double PreviousClose = Close[PreviousClosingBar];
      
      // *****************************************************
      //    Find previous day's high and low.
      // *****************************************************
      
      for (int SearchHighLow=PreviousClosingBar;SearchHighLow<(PreviousOpeningBar+1);SearchHighLow++)
      {
         if (High[SearchHighLow]>PreviousHigh) PreviousHigh=High[SearchHighLow];
         if (Low[SearchHighLow]<PreviousLow) PreviousLow=Low[SearchHighLow];
      }
      
      // ************************************************************************
      //    Calculate Pivot lines and map into indicator buffers.
      // ************************************************************************
      
      double P =  (PreviousHigh+PreviousLow+PreviousClose)/3;
      double R1 = (2*P)-PreviousLow;
      double S1 = (2*P)-PreviousHigh;
      double R2 =  P+(PreviousHigh - PreviousLow);
      double S2 =  P-(PreviousHigh - PreviousLow);
      double R3 = (2*P)+(PreviousHigh-(2*PreviousLow));
      double S3 = (2*P)-((2* PreviousHigh)-PreviousLow); 
      
      Pivot[i]=P;
      Res1[i] =R1;    
      Res2[i] =R2;  
      Res3[i] =R3;  
      Supp1[i]=S1;   
      Supp2[i]=S2;  
      Supp3[i]=S3;
      // Extra1[i]=OpenPriceAt+i;

      //   **********************************************
      //      Calculate the mid-levels in to the buffers. 
      //      (for mid-levels version)
      //   **********************************************(Twe)
      // Res1[i] =((R1-P)/2)+P;    //M3
      // Res2[i] =((R2-R1)/2)+R1;  //M4
      // Res3[i] =((R3-R2)/2)+R2;  
      // Supp1[i]=((P-S1)/2)+S1;   //M2
      // Supp2[i]=((S1-S2)/2)+S2;  //M1
      // Supp3[i]=((S2-S3)/2)+S3;


      } //End of 'DaysToPlot 'if' statement.
   }   
      // ***************************************************************************************
      //                            End of Main Loop
      // ***************************************************************************************


   // *****************************************
   //    Return from Start() (Main Routine)
   return(0);
  }
//+-------------------------------------------------------------------------------------------------------+
//  END Custom indicator iteration function
//+-------------------------------------------------------------------------------------------------------+


// *****************************************************************************************
// *****************************************************************************************
// -----------------------------------------------------------------------------------------
//    The following routine will use "StartingBar"'s time and use it to find the 
//    general area that SHOULD contain the bar that matches "TimeToLookFor"
// -----------------------------------------------------------------------------------------
int FindLastTimeMatchFast(int TimeToLookFor,int StartingBar)
   {
   int StartingBarsTime=(TimeHour(Time[StartingBar])*60)+TimeMinute(Time[StartingBar]);
   
   // ***************************************************
   //    Check that our search isn't on the otherside of 
   //    the midnight boundary and correct for calculations
   // ***************************************************
   if (StartingBarsTime<TimeToLookFor)
      {
      StartingBarsTime=StartingBarsTime+840;
      }
      
   // ***************************************************
   //    Find out where the bar SHOULD be in time.
   // ***************************************************
   int HowFarBack=StartingBarsTime-TimeToLookFor;
   //Print("HowFarBack ", HowFarBack);
   // ***************************************************
   //    Translate that into Bars
   // ***************************************************
   int HowManyBarsBack=HowFarBack/Period();
   //Print("HowManyBarsBack ", HowManyBarsBack);
   
   // ***************************************************
   //    We've found our starting point
   //    Calculate it's relative time in minutes.
   // ***************************************************
   int SuggestedBar=StartingBar+HowManyBarsBack;
   
   int SuggestedBarsTime=(TimeHour(Time[SuggestedBar])*60)+TimeMinute(Time[SuggestedBar]);
   
   // ***************************************************
   //    If we have what we're after let's just skip the 
   //    crap and return the position of the bar in the 
   //    chart to our main routine
   // ***************************************************
   if (SuggestedBarsTime==TimeToLookFor)
      {
      return(SuggestedBar);
      }   
      
   // ***************************************************
   // Else find the difference in time from where we
   // were supposed to find the bar.
   // ***************************************************
   int DeltaTimeFound=TimeToLookFor-SuggestedBarsTime;
   int DeltaBarFound=DeltaTimeFound/Period();
   
   // ***************************************************
   // I'd be worried if Delta was below zero. Would mean
   // that we have EXTRA bars in that day.  Unlikely in 
   // the extreme.
   // So I'm only checking for the other case.
   // ...now let's search in a narrow range to find that 
   // bar we are after...
   // ***************************************************
   if (DeltaTimeFound>0)
      {
        for (int SearchCount=SuggestedBar ;SearchCount>(SuggestedBar-DeltaBarFound-2) ;SearchCount--)
            {
            // ******************************************************************************
            //    Find time (in minutes) of the current bar AND the two bars either side of it.
            // This is done to allow for any missing bars in the data.   i.e. If THE bar you 
            // were after were to be missing you'd never get a valid close/open time.  
            //    This is the same reason for searching rather than just looking back a certain
            // number of bars from the close time. Missing bars upset the count back and 
            // screw up all pivot calculations. There is still room for error but it's improved.
            // The best calculations will come from having the best data. ...of course. :)
            // ******************************************************************************
            //
            int PreviousBarsTime=(TimeHour(Time[SearchCount+1])*60)+TimeMinute(Time[SearchCount+1]);
            int CurrentBarsTime=(TimeHour(Time[SearchCount])*60)+TimeMinute(Time[SearchCount]);
            int NextBarsTime=(TimeHour(Time[SearchCount-1])*60)+TimeMinute(Time[SearchCount-1]);
      
            if (CurrentBarsTime==TimeToLookFor)
               {
               return(SearchCount);    // *** If current bar is what we are after than lets get out.
                                 // *** without mucking about with the rest of the checks.
               }
      
            // **********************************
            //    Check that previous bar doesn't
            // lay on a different day.
            //    Adjust if it is
            // **********************************
            if(PreviousBarsTime>CurrentBarsTime)  
               {                                       
               PreviousBarsTime=PreviousBarsTime-840;
               }
            // **********************************
            //    Check that following bar doesn't
            // lay on a different day. 
            //    Adjust if it is.
            // **********************************
            if(NextBarsTime<CurrentBarsTime)         
               {
               NextBarsTime=NextBarsTime+840;
               }
            // ******************************************
            //    If this is the best we can get
            // to the actual bar we are after, then 
            // exit, returning current bar number.
            // *******************************************    
            if(PreviousBarsTime<TimeToLookFor)
               {
                  if( TimeToLookFor<NextBarsTime)
                  {
                  return(SearchCount);
                  }
               }
            }
      }
   
   return (SuggestedBar);
   }

