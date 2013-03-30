#property link      ""
string ea_version = "CASH ME IF YOU CAN v1.10";

//trade counter

extern string  parameters.tolerance  = "Trade Tolerance";
int    pnlSeuil = 45;
double pnlSeuilTolerance; //percent
extern bool   enableTrading = true;

extern int pTrailingStopSlow = 2;

string TradeObjStatus;

extern string  parameters.MovingAverage  = "Moving Average";
/// Bodi vars
extern int MAMode = 0;
extern int FasterEMA = 15;
extern int SlowerEMA = 30;
// Moving Average
extern int MAFastPeriod = 10;
extern int MASlowPeriod = 200;

extern string  parameters.TradeFlags  = "Trade Flags";
extern bool EnableMAFilter = true;
extern bool EnableHAFilter = true;
extern bool EnableFractalFilter = true;
extern bool EnableBreakOutFilter = true;
extern bool EnableBreakOutSpreadFilter = false;
extern bool EnableBackBoneFilter = true;
extern bool EnableGaussFilter = true;
extern bool EnableVolatilityFilter = true;

extern int backBoneCounterDown = 0;
extern int bPeriod = 200;

extern string  parameters.trade  = "Max trade allowed";
extern int  maxOpenBuyPosition      = 3;
extern int  maxOpenSellPosition     = 3;
extern int  maxActiveSymbolAllows   = 3;


int  currentGaussTradeOrder    		= 0;
int  maxGaussTradeOrder              = 1;
int  myFiboCondition = 0;


//---- buffers
double ExtMapBuffer1Now;
double ExtMapBuffer6Now;
double ExtMapBuffer1After;
double ExtMapBuffer6After;
double ExtMapBuffer1Previous;
double ExtMapBuffer6Previous;

double ExtHAOpenNow;
double ExtHAOpenAfter;
double ExtHAOpenPrevious;
double ExtHALowPrevious;
double ExtHAHighPrevious;

double ExtHACloseNow;
double ExtHACloseAfter;
double ExtHAClosePrevious;
double ExtHACloseBefPrevious;

double emaFastPrev,emaFastAfter,emaLowNow, emaLowPrev,emaLowAfter,emaFastNow;
double FractalSupPrevious, FractalResPrevious,FractalSupNow, FractalResNow;

// Bodi
double fasterBodinow, slowerBodinow, fasterBodiprevious,fasterBodiPprevious, slowerBodiprevious, slowerBodiPprevious, fasterBodiafter, slowerBodiafter,fasterBodiSignalnow, slowerBodiSignalnow;


//internal
double alertTag, alertSoundTag, count;
int    ticket;
int    currentNbBuys=0, currentNbSells=0;
int    iStartTradingHourAM, iEndTradingHourAM,iStartTradingHourPM,iEndTradingHourPM,
       iStartTradingMinuteAM, iEndTradingMinuteAM,iStartTradingMinutePM,iEndTradingMinutePM;
double myLots;
int    myTakeProfit;
int    myStoploss;
int    myPrice;
int    myMaxStoploss;
int    Tradecount=0;
int    trailingDeal[9000];
bool   isTradingAllow = true;
double CurrentMaxPNL,CurrentPNL;
bool   isPNLLocked = false;
string trailingName;
string tradeMode="SWING";

/// GAUSSIAN VARS
double gauss_rb0_now 	;
double gauss_rb1_now 	;
double gauss_rb2_now 	;
double gauss_rb3_now 	;
double gauss_rb4_now 	;
double gauss_rb5_now 	;
double gauss_rb6_now 	;
double gauss_rb7_now 	;
double gauss_rb0_bef 	;
double gauss_rb1_bef 	;
double gauss_rb2_bef 	;
double gauss_rb3_bef 	;
double gauss_rb4_bef 	;
double gauss_rb5_bef 	;
double gauss_rb6_bef 	;
double gauss_rb7_bef 	;
double gauss_rb0_after  ;
double gauss_rb1_after  ;
double gauss_rb2_after  ;
double gauss_rb3_after  ;
double gauss_rb4_after  ;
double gauss_rb5_after  ;
double gauss_rb6_after  ;
double gauss_rb7_after  ;
int gperiod=10;

// PRICE CHANNEL
double priceChanHigh[300];
double priceChanLow[300];
double priceChanMed[300];


// MOVING AVERAGE
double MAFastUpNow    		;
double MAFastUpAfter        ;
double MAFastUpPrevious     ;
double MAFastDownNow        ;
double MAFastDownAfter      ;
double MAFastDownPrevious   ;
double MASlowUpNow    		;
double MASlowUpAfter        ;
double MASlowUpPrevious     ;
double MASlowDownNow        ;
double MASlowDownAfter      ;
double MASlowDownPrevious   ;
double MASlowNow   ;
double MAFastNow   ;

// BOLLINGER BAND
double BackBoneHigh;
double BackBoneLow;
double BackBoneMidUp_now;
double BackBoneMidDown_now;

int  nbSymb 						   = 0;

// Flags
double flagMAInd = 1;
double flagFastMAInd = 1;
double flagSlowMAInd = 1;
double flagHAInd = 1;
double flagFractalInd = 1;
double flagBreakOutInd = 1;
double flagBreakOutSpreadInd = 1;
double flagGaussInd = 1;
double flagBackBoneInd = 1;
double flagVolatilityInd = 1;
double flagSlowVolatilityInd = 1;
double flagFastVolatilityInd = 1;
double flagMACrossInd = 1;


// Pivot
double Pivot;
double Resist1;
double Resist2;
double Support1;
double Support2;
double Support3;
double Resist3;
double                  pPoint;
double r1 , s1 ,s2, r2, r3, s3;
int NowDay;
double StpBuy;
double StpSell;
double PrftBuy;
double PrftSell;
double currentLevel;
double FibSupport1 ;
double FibResist1  ;
double FibSupport2 ;
double FibResist2  ;
double FibSupport3 ;
double FibResist3  ;
double currentSupportlevel, currentResistancelevel;

/* DM RES SUPP */
double DM_TF_CURR_RESISTANCE;
double DM_TF_CURR_SUPPORT;
double DM_TF_CURR_MIDDLE;
double DM_TF_SUPP_RESISTANCE;
double DM_TF_SUPP_SUPPORT;
double DM_TF_SUPP_MIDDLE;   
double DM_THRESHOLD;
int TFSUP;
   
/* Price vars */
string PriceDirection;
string TrendDirection;
string PriceBehavior;
int typeDecisionOrder;
double tradeDecisionTag, tradeDecisionCounter;
bool tradeDecisionOK;

/* Trade Management */
double tradeBuyObjectives1,tradeBuyObjectives2,tradeBuyObjectives3;
double tradeSellObjectives1,tradeSellObjectives2,tradeSellObjectives3;
double tradeInvalidObjectives[50][5];
string tradeTxtBody;
int p=1;

double SymbObjPoint1;
double SymbObjPoint2; 
double SymbObjPoint3;
         
         

extern string  parameters.trailing = "Money management" ;
extern double            MaxR = 0.05;   // max risk

int magicNumber1;

   
//--------------------------------------------------------------------
//extern string  parameters.mm  = "0-off  1-Candle  2-Fractals  3-FIBO  4-Parabolic  >4-pips";
 int     TrailingStopSlow;      // 0 off 
 int     TrailingStopFast;      // 0 off 
 int     StepTrall       ;      // step Thrall, moving not less than StepTrall n 
 int     delta           ;      // offset from the fractal or candles or Parabolic 
 int     BreakOutDelta   ;
 bool    visualization        = true;      

int MY_TF_STOPLOSS=0;
   
string         parameters.Parabolic = "";
double  Step                 = 0.02;
double  Maximum              = 0.2;
int     VelocityPeriodBar    = 30;
double  K_Velocity           = 1.0;    //magnification stoploss of Velocity


//--------------------------------------------------------------------
int      STOPLEVEL,n,DIGITS,SPREAD;
double   BID,ASK,POINT,MARGININIT, OTP, StLo;
string   SymbolTral,TekSymbol;
int      Slippage      = 2;
//--------------------------------------------------------------------


double revPriceUp=0, revPriceDown=0;

//--------------------------------------------------------------------
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
  
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }

//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+

void setEaConfigPerSymbol()
{
visualization        = true; 
int vcoef;

if (Symbol() == "FRA40")
{     
      if (Period() == PERIOD_M1){
         gperiod=5;
         pnlSeuil = 30;   
         pnlSeuilTolerance = 100;
         
         myStoploss=3;
         myTakeProfit=0;
         myMaxStoploss=5;        

         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 6;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 8;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 3;
         
         magicNumber1 = 101;
         
         SymbObjPoint1= 8;
         SymbObjPoint2= 12; 
         SymbObjPoint3= 15;
         
         DM_THRESHOLD = 15;
         
         //p=-1;
                  
      }else if (Period() == PERIOD_M5){
         gperiod=7;
         pnlSeuil = 18;   
         pnlSeuilTolerance = 40;
           
         myStoploss=7;
         myTakeProfit=0;
         myMaxStoploss=4;       
         
         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 8;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 4;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 4;
         
         SymbObjPoint1= 8;
         SymbObjPoint2= 13; 
         SymbObjPoint3= 21;
        
         magicNumber1 = 105;
         
         DM_THRESHOLD = 40;
      } else {
         
         gperiod=10;
         pnlSeuil = 12;   
         pnlSeuilTolerance = 40;   
              
         myStoploss=20;
         myTakeProfit=0;
         myMaxStoploss=25;  
         
         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 15;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 2;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 3;
         
         SymbObjPoint1= 8;
         SymbObjPoint2= 15; 
         SymbObjPoint3= 24;
         
         magicNumber1 = 199;
      }     
      
      // Trade Management

      
      // Traging Hours
      iStartTradingHourAM=6;
      iStartTradingMinuteAM=10;
      
      iEndTradingHourAM=11;
      iEndTradingMinuteAM=00;
      
      iStartTradingHourPM=12;
      iStartTradingMinutePM=30;
      
      iEndTradingHourPM=16;
      iEndTradingMinutePM=35;
      
      
      
}else if (Symbol() == "GER30")
{
      if (Period() == PERIOD_M1){
         gperiod=5;
         pnlSeuil = 15;   
         pnlSeuilTolerance = 20;
         
         myStoploss=7;
         myTakeProfit=0;
         myMaxStoploss=4;        

         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 8;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 4;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 3;
         
         SymbObjPoint1= 8;
         SymbObjPoint2= 13; 
         SymbObjPoint3= 25;
         
         
         magicNumber1 = 201;
         
         DM_THRESHOLD = 20;
                           
      }else if (Period() == PERIOD_M5){
         gperiod=7;
         pnlSeuil = 22;   
         pnlSeuilTolerance = 40;
           
         myStoploss=8;
         myTakeProfit=0;
         myMaxStoploss=4;       
         
         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 12;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 5;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 5;
         
         SymbObjPoint1= 13;
         SymbObjPoint2= 21; 
         SymbObjPoint3= 34;
        
         magicNumber1 = 205;
         
         DM_THRESHOLD = 60;
      } else {
         
         gperiod=10;
         pnlSeuil = 20;   
         pnlSeuilTolerance = 40;   
              
         myStoploss=24;
         myTakeProfit=0;
         myMaxStoploss=30;  
         
         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 12;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 2;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 5;
         
         magicNumber1 = 299;
         
         SymbObjPoint1= 13;
         SymbObjPoint2= 21; 
         SymbObjPoint3= 34;
         
      }     
            
      // Traging Hours
      iStartTradingHourAM=6;
      iStartTradingMinuteAM=10;
      
      iEndTradingHourAM=8;
      iEndTradingMinuteAM=30;
      
      iStartTradingHourPM=12;
      iStartTradingMinutePM=30;
      
      iEndTradingHourPM=16;
      iEndTradingMinutePM=35;     
      
      
}else if (Symbol() == "UK100")
{
      if (Period() == PERIOD_M1){
         gperiod=5;
         pnlSeuil = 12;   
         pnlSeuilTolerance = 50;
         
         myStoploss=7;
         myTakeProfit=0;
         myMaxStoploss=8;           
   
         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 8;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 2;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 5;
         
         magicNumber1 = 301;
         
         
         SymbObjPoint1= 8;
         SymbObjPoint2= 12; 
         SymbObjPoint3= 18;         
         
         
                           
      }else if (Period() == PERIOD_M5){
         gperiod=7;
         pnlSeuil = 18;   
         pnlSeuilTolerance = 40;
           
         myStoploss=12;
         myTakeProfit=0;
         myMaxStoploss=20;      
         
         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 12;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 8;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 5;
         
         magicNumber1 = 305;
         
         SymbObjPoint1= 13;
         SymbObjPoint2= 21; 
         SymbObjPoint3= 34;
                  
      } else {
         
         gperiod=10;
         pnlSeuil = 20;   
         pnlSeuilTolerance = 40;   
              
         myStoploss=24;
         myTakeProfit=0;
         myMaxStoploss=30;  
         
         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 15;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 10;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 5;
         
         magicNumber1 = 399;

         SymbObjPoint1= 13;
         SymbObjPoint2= 21; 
         SymbObjPoint3= 34;        
      }     
      
      // Traging Hours
      iStartTradingHourAM=8;
      iStartTradingMinuteAM=5;
      
      iEndTradingHourAM=11;
      iEndTradingMinuteAM=00;
      
      iStartTradingHourPM=12;
      iStartTradingMinutePM=30;
      
      iEndTradingHourPM=16;
      iEndTradingMinutePM=35;     
      
}else if (Symbol() == "US30")
{ 
     if (Period() == PERIOD_M1){
         gperiod=5;
         pnlSeuil = 14;   
         pnlSeuilTolerance = 60;
         
         myStoploss=15;
         myTakeProfit=0;
         myMaxStoploss=20;        

         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 12;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 2;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 5;
         
         magicNumber1 = 401;
         
         SymbObjPoint1= 10;
         SymbObjPoint2= 20; 
         SymbObjPoint3= 50;         
                  
      }else if (Period() == PERIOD_M5){
         gperiod=7;
         pnlSeuil = 18;   
         pnlSeuilTolerance = 40;
           
         myStoploss=24;
         myTakeProfit=0;
         myMaxStoploss=40;       
         
         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 16;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 4;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 5;
         magicNumber1 = 405;

         SymbObjPoint1= 15;
         SymbObjPoint2= 35; 
         SymbObjPoint3= 80;
                  
      } else {
         
         gperiod=10;
         pnlSeuil = 12;   
         pnlSeuilTolerance = 40;   
              
         myStoploss=24;
         myTakeProfit=0;
         myMaxStoploss=40;  
         
         TrailingStopSlow     = pTrailingStopSlow;           // 0 off 
         TrailingStopFast     = 15;                           // 0 off 
         StepTrall            = 0;                          // step Thrall, moving not less than StepTrall n 
         delta                = 6;                          // offset from the fractal or candles or Parabolic 
         BreakOutDelta        = 5;
         
         magicNumber1 = 499;

         SymbObjPoint1= 25;
         SymbObjPoint2= 38; 
         SymbObjPoint3= 90;
         
                  
      }
           
      // Traging Hours
      iStartTradingHourAM=14;
      iStartTradingMinuteAM=30;
      
      iEndTradingHourAM=15;
      iEndTradingMinuteAM=30;
      
      iStartTradingHourPM=19;
      iStartTradingMinutePM=50;
      
      iEndTradingHourPM=20;
      iEndTradingMinutePM=00;
      
}
}

void setEaTradeMode()
{
   tradeMode = "SWING";    
   
     
   
   /*if (tradeMode == "SCALPING" )
   {
      EnableFractalFilter = false;      
      EnableGaussFilter = false;      
   } else 
   {
      EnableFractalFilter = true;      
      EnableGaussFilter = true;
   }*/
   
   
      
}  

//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
   //---- check for history and trading
   tradeDecisionOK= False;
   
   if (Bars<100 || IsTradeAllowed()==false) return;   
   if (Time[0]-tradeDecisionTag >= Period() * 60 * 5) {
      tradeDecisionOK= True;
      tradeDecisionCounter=0;
      tradeDecisionTag=NULL;
   }
   
   if (tradeDecisionCounter > 0) tradeDecisionCounter--;
   
   
   //if (count != iBarShift(NULL,0,0) && backBoneCounterDown > 0 )  {backBoneCounterDown--;count=iBarShift(NULL,0,0);}
   RefreshRates();
   
   SymbolTral = Symbol();
   STOPLEVEL=MarketInfo(SymbolTral,MODE_STOPLEVEL);
   if (STOPLEVEL < 4) STOPLEVEL = 4;
   POINT  = MarketInfo(SymbolTral,MODE_POINT);
   DIGITS = MarketInfo(SymbolTral,MODE_DIGITS);
   BID    = MarketInfo(SymbolTral,MODE_BID);
   ASK    = MarketInfo(SymbolTral,MODE_ASK);
   SPREAD = MarketInfo(SymbolTral,MODE_SPREAD);
   MARGININIT = MarketInfo(SymbolTral,MODE_MARGININIT);

   
   
   setEaConfigPerSymbol(); 
   
   // GET CURRENT ORDERS
   CalculateCurrentOrders(SymbolTral);
   
   //GET NB ACTIVE SYMBOL
   getActiveSymbol();  
   
   // PRE REQUISITE
   checkForTrading();
   
   
   // GET TRADER DETAIL
   //if (isTradingAllow)
   //{
      //GET TRADER DETAIL
      getTraderDetail(Period());
      
      setEaTradeMode();   
      
      // Check des conditions
      CheckForEntryCondition();
   
      // Get price direction
      CheckPriceDirection();   
      
      // Get Trend Direction
      CheckTrendDirection();
   
      // Check to open a trade
      CheckForOpen();      
   //}
   
   // Check StopLoss
   CheckForStopLoss();
   
   // Trailing stops
   //TrailingStop();
   
   // Get Objectives
   getTradeObjectives();
   
   CheckForClosebyObjectives();    
   
   
   //CheckForClosebyPnl();    
   
   
   
   //sendReport();
   
   displayComment();
   
   return(0);
  }
//+------------------------------------------------------------------+
  
//+------------------------------------------------------------------+
//| Calculate Optimal Lot Size                                       |
//+------------------------------------------------------------------+  
double LotsOptimized()
{
   int malus = 0;
   double MinLot = MarketInfo(Symbol(),MODE_MINLOT);
   double MaxLot = MarketInfo(Symbol(),MODE_MAXLOT);
   double Prots = MaxR;

   /*double metod  = 0;
   if(Choice_method)metod = AccountBalance();
   else metod = AccountFreeMargin();*/
  
   //double Lotsi=MathFloor((AccountFreeMargin()-malus)*MaxR/MarketInfo(Symbol(),MODE_MARGINREQUIRED)/MarketInfo(Symbol(),MODE_LOTSTEP))*MarketInfo(Symbol(),MODE_LOTSTEP);
   
   double Lotsi=1;
   
   if(Lotsi<MinLot)Lotsi=MinLot;
   if(Lotsi>MaxLot)Lotsi=MaxLot;  
   
   Lotsi=MinLot;
   
   return(Lotsi);
   
}
//+------------------------------------------------------------------+
//| Calculate open positions                                         |
//+------------------------------------------------------------------+
void CalculateCurrentOrders(string symbol)
{   
      
   string EAEntry;
   currentNbBuys=0;
   currentNbSells=0;
   int n;
   
//----
   for(int i=0;i<OrdersTotal();i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
      if(OrderSymbol()==Symbol())
      {
         if (OrderMagicNumber() == magicNumber1)
         {
            n++;
      
            EAEntry = getParList(OrderComment(), "EA");
            //Print(EAEntry); 

            if(OrderType()==OP_BUY)  currentNbBuys++;
            if(OrderType()==OP_SELL) currentNbSells++;
         }
      }
   }

   if (n == 0 && CurrentMaxPNL > 0) { CurrentMaxPNL =0; }
   if (n == 0) TradeObjStatus="";
} 
  
  


void getTraderDetail(int pTimeFrame)
{
   int i=1;
   
   
   /* Moving Average */
   MAFastUpNow    		= iCustom(Symbol(),NULL, "MA in Color", MAFastPeriod, MAMode, 1,i);  
   MAFastUpAfter    	= iCustom(Symbol(),NULL, "MA in Color", MAFastPeriod, MAMode, 1,i-1);  
   MAFastUpPrevious   	= iCustom(Symbol(),NULL, "MA in Color", MAFastPeriod, MAMode, 1,i+1);  
   MAFastDownNow    	= iCustom(Symbol(),NULL, "MA in Color", MAFastPeriod, MAMode, 2,i);  
   MAFastDownAfter    	= iCustom(Symbol(),NULL, "MA in Color", MAFastPeriod, MAMode, 2,i-1);  
   MAFastDownPrevious  = iCustom(Symbol(),NULL, "MA in Color", MAFastPeriod, MAMode, 2,i+1);  
   
   MAFastNow    		= iMA(Symbol(),NULL, MAFastPeriod, 0, MAMode, 0,i);  

   MASlowUpNow    		= iCustom(Symbol(),NULL, "MA in Color", MASlowPeriod, MAMode, 1,i);  
   MASlowUpAfter    	= iCustom(Symbol(),NULL, "MA in Color", MASlowPeriod, MAMode, 1,i-1);  
   MASlowUpPrevious   	= iCustom(Symbol(),NULL, "MA in Color", MASlowPeriod, MAMode, 1,i+1);  
   MASlowDownNow    	= iCustom(Symbol(),NULL, "MA in Color", MASlowPeriod, MAMode, 2,i);  
   MASlowDownAfter    	= iCustom(Symbol(),NULL, "MA in Color", MASlowPeriod, MAMode, 2,i-1);  
   MASlowDownPrevious  = iCustom(Symbol(),NULL, "MA in Color", MASlowPeriod, MAMode, 2,i+1);
   
   MASlowNow    		= iMA(Symbol(),NULL, MASlowPeriod, 0, MAMode, 0,i);   

   /* Heiken Hashi*/ 
   ExtHAOpenNow =iCustom(Symbol(),NULL, "Heiken Ashi", 2,i);
   ExtHAOpenAfter =iCustom(Symbol(),NULL, "Heiken Ashi", 2,i-1);
   ExtHAOpenPrevious =iCustom(Symbol(),NULL, "Heiken Ashi", 2,i+1);
  
   ExtHACloseNow =iCustom(Symbol(),NULL, "Heiken Ashi", 3,i);
   ExtHACloseAfter =iCustom(Symbol(),NULL, "Heiken Ashi", 3,i-1);
   ExtHAClosePrevious =iCustom(Symbol(),NULL, "Heiken Ashi", 3,i+1);   
   ExtHACloseBefPrevious =iCustom(Symbol(),NULL, "Heiken Ashi", 3,i+2);

   if (ExtHAOpenPrevious < ExtHAClosePrevious )
   {
      ExtHAHighPrevious =iCustom(Symbol(),NULL, "Heiken Ashi", 1,i+1);   
      ExtHALowPrevious =iCustom(Symbol(),NULL, "Heiken Ashi", 0,i+1);      
      
   } else {
      ExtHALowPrevious =iCustom(Symbol(),NULL, "Heiken Ashi", 1,i+1);
      ExtHAHighPrevious =iCustom(Symbol(),NULL, "Heiken Ashi", 0,i+1);   
   }
      
   /* Fractal Support / resistance */
   FractalSupPrevious = iCustom(Symbol(),NULL, "Fractal Support and Resistance", 1,i+1);      
   FractalResPrevious = iCustom(Symbol(),NULL, "Fractal Support and Resistance", 0,i+1);   
   FractalSupNow = iCustom(Symbol(),NULL, "Fractal Support and Resistance", 1,i);      
   FractalResNow = iCustom(Symbol(),NULL, "Fractal Support and Resistance", 0,i);   


   /* BackBone Band*/
   BackBoneHigh        = iCustom(Symbol(),NULL, "Bands", bPeriod, 0, 0.15, 0, 1, i);      
   BackBoneMidUp_now   = iCustom(Symbol(),NULL, "MA in Color", bPeriod, MAMode, 1,i);
   BackBoneMidDown_now = iCustom(Symbol(),NULL, "MA in Color", bPeriod, MAMode, 2,i);   
   BackBoneLow         = iCustom(Symbol(),NULL, "Bands", bPeriod, 0, 0.15, 0, 2, i);   

   /* Bodi */
   fasterBodinow = iCustom(NULL,NULL,"BoDi2", FasterEMA,0,MAMode,0,0,i);
   fasterBodiprevious = iCustom(NULL,NULL,"BoDi2",FasterEMA,0,MAMode,0,0,i+1);
   fasterBodiPprevious = iCustom(NULL,NULL,"BoDi2",FasterEMA,0,MAMode,0,0,i+2);
   fasterBodiafter = iCustom(NULL,NULL,"BoDi2",FasterEMA,0,MAMode,0,0,i-1);
   fasterBodiSignalnow = iCustom(NULL,NULL,"BoDi2", FasterEMA,0,MAMode,0,3,i);
   
   slowerBodinow = iCustom(NULL,NULL,"BoDi2",SlowerEMA,0,MAMode,0,0,i);
   slowerBodiprevious = iCustom(NULL,NULL,"BoDi2",SlowerEMA,0,MAMode,0,0,i+1);
   slowerBodiPprevious = iCustom(NULL,NULL,"BoDi2",SlowerEMA,0,MAMode,0,0,i+2);
   slowerBodiafter = iCustom(NULL,NULL,"BoDi2",SlowerEMA,0,MAMode,0,0,i-1);      
   slowerBodiSignalnow = iCustom(NULL,NULL,"BoDi2",SlowerEMA,0,MAMode,0,3,i);

   gauss_rb0_now 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 0,i);
   gauss_rb1_now 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 1,i);
   gauss_rb2_now 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 2,i);
   gauss_rb3_now 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 3,i);
   gauss_rb4_now 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 4,i);
   gauss_rb5_now 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 5,i);
   gauss_rb6_now 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 6,i);
   gauss_rb7_now 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 7,i);
	
   gauss_rb0_bef 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 0,i+1);
   gauss_rb1_bef 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 1,i+1);
   gauss_rb2_bef 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 2,i+1);
   gauss_rb3_bef 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 3,i+1);
   gauss_rb4_bef 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 4,i+1);
   gauss_rb5_bef 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 5,i+1);
   gauss_rb6_bef 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 6,i+1);
   gauss_rb7_bef 	= iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod, 7,i+1);

   gauss_rb0_after = iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod,0,i-1);
   gauss_rb1_after = iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod,1,i-1);
   gauss_rb2_after = iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod,2,i-1);
   gauss_rb3_after = iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod,3,i-1);
   gauss_rb4_after = iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod,4,i-1);
   gauss_rb5_after = iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod,5,i-1);
   gauss_rb6_after = iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod,6,i-1);
   gauss_rb7_after = iCustom(Symbol(),NULL, "wmmm-GaussianRainbow",gperiod,7,i-1);    

   /* Pivot point */
   isCalsPivot();
   getPivotPriceLevel();
   
   
   /* Support / Resistant */
   TFSUP=0;
   
   if (Period() == PERIOD_M1) TFSUP = PERIOD_M5;
   if (Period() == PERIOD_M5) TFSUP = PERIOD_M15;
   if (Period() == PERIOD_M15) TFSUP = PERIOD_M30;
   
   DM_TF_CURR_RESISTANCE = iCustom(Symbol(),NULL, "DM_DSR", 0, 1);
   DM_TF_CURR_SUPPORT = iCustom(Symbol(),NULL, "DM_DSR", 1, 1);
   DM_TF_CURR_MIDDLE = iCustom(Symbol(),NULL, "DM_DSR", 2, 1);
   DM_TF_SUPP_RESISTANCE = iCustom(Symbol(),TFSUP, "DM_DSR", 0, 1);
   DM_TF_SUPP_SUPPORT = iCustom(Symbol(),TFSUP, "DM_DSR", 1, 1);
   DM_TF_SUPP_MIDDLE = iCustom(Symbol(),TFSUP, "DM_DSR", 2, 1);

}

void getPivotPriceLevel()
{
   int             err,err2,TgtProfit;
   
   double       StopBuy;
   double     ProfitBuy;
   double        bLevel;
   double      StopSell;
   double    ProfitSell;
   double        sLevel;
         
   // is first tick?   
   if (Bid >= Resist3) 						   currentSupportlevel = Resist3;   
   if (Bid >= Resist2 && Bid <= Resist3)     currentSupportlevel = Resist2;
   if (Bid >= Resist1 && Bid <= Resist2)     currentSupportlevel = Resist1;
   if (Bid > Pivot    && Bid <= Resist1)     currentSupportlevel = Pivot;
   if (Bid > Support1    && Bid <= Pivot)     currentSupportlevel = Support1;
   if (Bid >= Support2 && Bid <= Support1)    currentSupportlevel = Support2;
   if (Bid >= Support3 && Bid <= Support2)    currentSupportlevel = Support3;
   if (Bid <= Support3 )                     currentSupportlevel = Support3 -10;

   if (Bid >= Resist3) 						   currentResistancelevel = Resist3+10;   
   if (Bid >= Resist2 && Bid <= Resist3)      currentResistancelevel = Resist3;
   if (Bid >= Resist1 && Bid <= Resist2)      currentResistancelevel = Resist2;
   if (Bid > Pivot    && Bid <= Resist1)      currentResistancelevel = Resist1;
   if (Bid > Support1    && Bid <= Pivot)     currentResistancelevel = Pivot;
   if (Bid >= Support2 && Bid <= Support1)    currentResistancelevel = Support1;
   if (Bid >= Support3 && Bid <= Support2)    currentResistancelevel = Support2;
   if (Bid <= Support3) 					   currentResistancelevel = Support3;  
   
   /*if ((Ask > Pivot - (delta * SPREAD * POINT))        && (Ask <= Pivot ))                             currentLevel = Pivot;
   if ((Ask >= Support1 - (delta * SPREAD * POINT))     && (Ask <= Support1 + (delta * SPREAD * POINT)))   currentLevel = Support1;
   if ((Ask >= Support2 - (delta * SPREAD * POINT))     && (Ask <= Support2 + (delta * SPREAD * POINT)))   currentLevel = Support2;
   if ((Ask >= Support3 - (delta * SPREAD * POINT))     && (Ask <= Support3 + (delta * SPREAD * POINT)))   currentLevel = Support3;*/
   
}


void CheckPriceDirection()
{
   PriceDirection = "NEUTRE";
   
   if ((flagMAInd == 1 ) && (Ask > MAFastUpNow && Bid > MAFastUpNow) && (Ask > MASlowUpNow && Bid > MASlowUpNow)) PriceDirection = "HAUSSIER";   
   if ((flagMAInd == -1 ) && (Ask < MAFastUpNow && Bid < MAFastUpNow) && (Ask < MASlowUpNow && Bid < MASlowUpNow)) PriceDirection = "BAISSIER";
   
}

void CheckTrendDirection()
{
   TrendDirection = "RANGING";
   if (Ask < DM_TF_CURR_SUPPORT || Ask > DM_TF_CURR_RESISTANCE ) TrendDirection = "TRENDING TF1";   
   if ((Ask < DM_TF_CURR_SUPPORT && Ask < DM_TF_SUPP_SUPPORT ) || (Ask > DM_TF_CURR_RESISTANCE && Ask > DM_TF_SUPP_RESISTANCE )) TrendDirection = "TRENDING TF5";
}

void getTradeObjectives()
{   

   int tip,Ticket, MAGIC;
   bool error;
   double OOP;
   
   tradeBuyObjectives1 = 0;
   tradeBuyObjectives2 = 0;
   tradeBuyObjectives2 = 0;
   tradeSellObjectives1 = 0;
   tradeSellObjectives2 = 0;
   tradeSellObjectives2 = 0;
   
   tradeTxtBody   ="";

   for (int i=OrdersTotal(); i>=0; i--) 
   {  if (OrderSelect(i, SELECT_BY_POS)==true)
      {  tip = OrderType();
         TekSymbol=OrderSymbol();         
         POINT          = MarketInfo(TekSymbol,MODE_POINT);
         DIGITS         = MarketInfo(TekSymbol,MODE_DIGITS);
         Ticket         = OrderTicket();
         OOP            = OrderOpenPrice();
                  
         n=i;   
         
         
         if (tip<2 && (TekSymbol==SymbolTral) && OrderMagicNumber() == magicNumber1)
         {       
           if (tip == OP_BUY)
            {
            
               tradeBuyObjectives1 = OOP + SymbObjPoint1;
               tradeBuyObjectives2 = OOP + SymbObjPoint2;
               tradeBuyObjectives3 = OOP + SymbObjPoint3;
                
               
               tradeTxtBody = StringConcatenate (tradeTxtBody, OrderTicket(), " Buy Primary Obj. : ", tradeBuyObjectives1, " Buy Secondary Obj. : ", tradeBuyObjectives2, " Buy Tertiary Obj. : ", tradeBuyObjectives3, "\n"); 
               
            } else
            {
               tradeSellObjectives1 = OOP - SymbObjPoint1;
               tradeSellObjectives2 = OOP - SymbObjPoint2;
               tradeSellObjectives3 = OOP - SymbObjPoint3;
               
               tradeTxtBody = StringConcatenate (tradeTxtBody, OrderTicket(), " Sell Primary Obj. : ", tradeSellObjectives1," Sell Secondary Obj. : ", tradeSellObjectives2, " Sell Tertiary Obj. : ", tradeSellObjectives3, "\n"); 

            }
           
           
            //Print(OrderTicket(), " OOP ",OOP , " OB1 ", tradeObjectives1," OB2 ", tradeObjectives2);
         }
      }
   }
}



void CheckForEntryCondition(){
   if (!EnableGaussFilter) flagGaussInd=1;
   if (!EnableMAFilter) flagMAInd=1;
   if (!EnableHAFilter) flagHAInd=1;
   if (!EnableFractalFilter) flagFractalInd=1;
   if (!flagVolatilityInd) flagVolatilityInd=1;
   if (!flagBreakOutInd) flagBreakOutInd=1;
   if (!flagBreakOutSpreadInd) flagBreakOutSpreadInd=1;   
   if (!EnableBackBoneFilter) {flagGaussInd=1; backBoneCounterDown=0;}
   
   
   myFiboCondition = 0;
   flagMACrossInd = 0;
   
   //if (Period() == 1) p=-1;
   
   if (EnableGaussFilter)
   {
      flagGaussInd = 0;
      if ((gauss_rb0_now > gauss_rb1_now ) && (gauss_rb2_now > gauss_rb3_now ) && (gauss_rb4_now > gauss_rb5_now ) && (gauss_rb6_now > gauss_rb7_now )) flagGaussInd = 1;
      if ((gauss_rb0_now < gauss_rb1_now ) && (gauss_rb2_now < gauss_rb3_now ) && (gauss_rb4_now < gauss_rb5_now ) && (gauss_rb6_now < gauss_rb7_now )) flagGaussInd = -1;
   }
   
   if (EnableMAFilter)
   {
      flagMAInd = 0;
      flagFastMAInd = 0;
      flagSlowMAInd = 0;
      if (MAFastUpNow != EMPTY_VALUE) flagFastMAInd = 1;
      if (MAFastDownNow != EMPTY_VALUE) flagFastMAInd = -1;
      if (MASlowUpNow != EMPTY_VALUE) flagSlowMAInd = 1;
      if (MASlowDownNow != EMPTY_VALUE) flagSlowMAInd = -1;
      
      if (flagFastMAInd == 1 && flagSlowMAInd == 1 )  flagMAInd = 1;
      if (flagFastMAInd == -1 && flagSlowMAInd == -1 )  flagMAInd = -1;
   } 
   
   
   if (MAFastUpPrevious != EMPTY_VALUE 
   && MASlowUpPrevious != EMPTY_VALUE 
   && MAFastUpAfter != EMPTY_VALUE 
   && MASlowUpAfter != EMPTY_VALUE
   && MAFastUpNow != EMPTY_VALUE
   && MASlowUpNow != EMPTY_VALUE &&
      MAFastUpPrevious < MASlowUpPrevious && MAFastUpAfter > MASlowUpAfter && MAFastUpNow > MASlowUpNow) flagMACrossInd = 1;
   
   if (MAFastDownPrevious != EMPTY_VALUE 
   && MASlowDownPrevious != EMPTY_VALUE 
   && MAFastDownAfter != EMPTY_VALUE 
   && MASlowDownAfter != EMPTY_VALUE 
   && MAFastDownNow != EMPTY_VALUE 
   && MASlowDownNow != EMPTY_VALUE 
   && MAFastDownPrevious > MASlowDownPrevious && MAFastDownAfter < MASlowDownAfter && MAFastDownNow < MASlowDownNow) flagMACrossInd = -1;
  
   if (EnableHAFilter)
   {
      flagHAInd = 0;
      //if ((ExtHAOpenPrevious > ExtHAClosePrevious && ExtHAOpenNow < ExtHACloseNow ) || (ExtHAOpenPrevious < ExtHAClosePrevious && ExtHAOpenNow < ExtHACloseNow)) flagHAInd = 1;
      //if (( ExtHAOpenPrevious < ExtHAClosePrevious && ExtHAOpenNow > ExtHACloseNow ) || (ExtHAOpenPrevious > ExtHAClosePrevious && ExtHAOpenNow > ExtHACloseNow)) flagHAInd = -1;
      if (ExtHAOpenPrevious < ExtHAClosePrevious && ExtHAOpenNow < ExtHACloseNow) flagHAInd = 1;
      if (ExtHAOpenPrevious > ExtHAClosePrevious && ExtHAOpenNow > ExtHACloseNow) flagHAInd = -1;
      
      //harami 
      if (ExtHAOpenPrevious > ExtHAClosePrevious && ExtHAOpenPrevious > ExtHACloseNow && ExtHAClosePrevious < ExtHAOpenNow && ExtHAOpenNow < ExtHACloseNow ) flagHAInd = 1;
      if (ExtHAOpenPrevious < ExtHAClosePrevious && ExtHAOpenPrevious < ExtHACloseNow && ExtHAClosePrevious > ExtHAOpenNow && ExtHAOpenNow > ExtHACloseNow ) flagHAInd = -1;
      
      // Avalement
      if (ExtHAOpenPrevious > ExtHAClosePrevious && ExtHAOpenNow < ExtHAClosePrevious && ExtHACloseNow > ExtHAClosePrevious && ExtHAOpenNow < ExtHACloseNow) flagHAInd = 1;
      if (ExtHAOpenPrevious < ExtHAClosePrevious && ExtHAOpenNow > ExtHAClosePrevious && ExtHACloseNow < ExtHAClosePrevious && ExtHAOpenNow > ExtHACloseNow) flagHAInd = -1;
      
   }
   
   if (EnableFractalFilter)
   {
      flagFractalInd = 0;
      if (ExtHAOpenPrevious <= FractalResNow && ExtHACloseNow > FractalResNow) flagFractalInd = 1;
      if (ExtHAOpenPrevious >= FractalSupNow && ExtHACloseNow < FractalSupNow) flagFractalInd = -1;
   } 

   if (EnableBreakOutFilter)
   {
      flagBreakOutInd = 0;
      if (ExtHAOpenPrevious <= DM_TF_CURR_RESISTANCE && ExtHACloseNow > DM_TF_CURR_RESISTANCE) flagBreakOutInd = 1;
      if (ExtHAOpenPrevious >= DM_TF_CURR_SUPPORT && ExtHACloseNow < DM_TF_CURR_SUPPORT) flagBreakOutInd = -1;
      
      if ( DM_TF_CURR_RESISTANCE - DM_TF_CURR_SUPPORT < DM_THRESHOLD  && flagBreakOutInd == 1 ) flagBreakOutSpreadInd = 1;
      if ( DM_TF_CURR_RESISTANCE - DM_TF_CURR_SUPPORT < DM_THRESHOLD  && flagBreakOutInd == -1) flagBreakOutSpreadInd = -1;      
      

   }  
   
   if (EnableBackBoneFilter)
   {
      flagBackBoneInd = 0;
      if (flagHAInd == 1 && (ExtHAOpenPrevious < BackBoneHigh || ExtHAClosePrevious < BackBoneHigh) && ExtHACloseNow > BackBoneHigh) {flagBackBoneInd = 1;}
      if (flagHAInd == -1 &&(ExtHAOpenPrevious > BackBoneLow || ExtHAClosePrevious > BackBoneLow ) && ExtHACloseNow < BackBoneLow) {flagBackBoneInd = -1;}
   }

   if (EnableVolatilityFilter)
   {
      flagVolatilityInd = 0;
      flagFastVolatilityInd = 0;
      flagSlowVolatilityInd = 0;
       
      //fasterBodiPprevious < fasterBodiprevious &&
      //slowerBodiPprevious < slowerBodiprevious &&
      if (fasterBodiprevious < fasterBodinow && fasterBodiafter > fasterBodinow && fasterBodinow >  fasterBodiSignalnow) flagFastVolatilityInd = 1;
      if (slowerBodiprevious < slowerBodinow && slowerBodiafter > slowerBodinow && slowerBodinow > slowerBodiSignalnow ) flagSlowVolatilityInd = 1;
      
      
      if (Period() == PERIOD_M1)
      {
         flagVolatilityInd = flagFastVolatilityInd;
         
      } else {
         if (flagFastVolatilityInd && flagSlowVolatilityInd)
         {
            flagVolatilityInd = 1;
         }
      }
      //Print("fasterBodiSignalnow", fasterBodiSignalnow, "slowerBodiSignalnow", slowerBodiSignalnow);
      
   }      
   
} 

/*
   Strategie : RETRACEMENT
   Type = 1
*/
void stratRetracementBackBone()
{
   if (StringFind(PriceBehavior, "HARAMI", 0) >= 0 
      || StringFind(PriceBehavior, "DYN", 0) >= 0
      || StringFind(PriceBehavior, "BREAKOUT", 0) >= 0
      || StringFind(PriceBehavior, "PIVOT", 0) >= 0 
      //|| StringFind(PriceBehavior, "BACKBONE", 0) >= 0 
      ) return(NULL);
   
  // STEP 1 : Identification retracement 
   if ((flagSlowMAInd >=0  && flagFastMAInd == -1 && ExtHACloseNow > MASlowNow && ExtHACloseNow < MAFastNow ) 
       || (flagSlowMAInd <=0 && flagFastMAInd == 1  && ExtHACloseNow < MASlowNow && ExtHACloseNow > MAFastNow))
   {  
      // Validation
      if (flagSlowMAInd >=0  && flagFastMAInd == -1 && ExtHACloseNow > MASlowNow && ExtHACloseNow < MAFastNow ) 
         PriceBehavior = "RETRACEMENT EN COURS A LA BAISSE";
      
      if (flagSlowMAInd <=0 && flagFastMAInd == 1  && ExtHACloseNow < MASlowNow && ExtHACloseNow > MAFastNow) 
         PriceBehavior = "RETRACEMENT EN COURS A LA HAUSSE";
   } 
      // Invalidation
      if (PriceBehavior == "RETRACEMENT EN COURS A LA BAISSE" && flagFastMAInd == 1 ) PriceBehavior = "";
      if (PriceBehavior == "RETRACEMENT EN COURS A LA HAUSSE" && flagFastMAInd == -1 ) PriceBehavior ="";
   
   
   //Step 2 : On valide le retracement jusqua la backbone
   
   if (PriceBehavior == "RETRACEMENT EN COURS A LA BAISSE" && ExtHAClosePrevious < BackBoneLow && ExtHAOpenPrevious > BackBoneHigh && flagFastMAInd == 1)  
      PriceBehavior = "RETRACEMENT A LA BAISSE - OK";
   
   if (PriceBehavior == "RETRACEMENT EN COURS A LA HAUSSE" && ExtHAClosePrevious > BackBoneHigh && ExtHAOpenPrevious < BackBoneLow && flagFastMAInd == -1)
      PriceBehavior = "RETRACEMENT A LA HAUSSE - OK";
   
   // Step 3 : Validation du nouveau depart sinon invalidation
   
   if (PriceBehavior ==  "RETRACEMENT A LA HAUSSE - OK" || PriceBehavior ==  "RETRACEMENT A LA BAISSE - OK")
   {
      // Invalidation
      if (PriceBehavior == "RETRACEMENT A LA HAUSSE - OK" && (flagBackBoneInd == 1 || MAFastNow > MASlowNow || flagSlowMAInd >= 0)) 
         PriceBehavior = "ECHEC RETRACEMENT HAUSSE"; 
      
      if (PriceBehavior == "RETRACEMENT A LA BAISSE - OK" && (flagBackBoneInd == -1 || MAFastNow < MASlowNow || flagSlowMAInd <= 0)) 
         PriceBehavior = "ECHEC RETRACEMENT BAISSE"; 
         
      // Step 4 : Le signal est donné sur franchissement des bornes Hi/sup
      if (PriceBehavior == "RETRACEMENT A LA HAUSSE - OK" && flagGaussInd == -1 && tradeDecisionOK) {
         myFiboCondition = -1*p;
         typeDecisionOrder = 1;         
         
         
         if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
      }   
      if (PriceBehavior == "RETRACEMENT A LA BAISSE - OK" && flagGaussInd == 1 && tradeDecisionOK) {
         myFiboCondition = 1*p;
         typeDecisionOrder = 1;    
              
         if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
      }            
   }
}

/*
   Strategie : REBOND SUPPORT / RESISTANCE DYNAMIQUE
   Type = 2
*/
void stratDMSupportResistance()
{
   if (StringFind(PriceBehavior, "HARAMI", 0) >= 0 
   || StringFind(PriceBehavior, "RETRACEMENT", 0) >= 0
   || StringFind(PriceBehavior, "BREAKOUT", 0) >= 0 
   || StringFind(PriceBehavior, "PIVOT", 0) >= 0 
   //|| StringFind(PriceBehavior, "BACKBONE", 0) >= 0 
   ) return(NULL);
      
   if ((ExtHALowPrevious <= DM_TF_CURR_SUPPORT )
      || (ExtHAClosePrevious <= DM_TF_CURR_SUPPORT && ExtHAOpenNow > DM_TF_CURR_SUPPORT && ExtHACloseNow > DM_TF_CURR_SUPPORT)
      )
      PriceBehavior = "DYN SUPP/REST - SUPPORT TOUCHE";

   if ((ExtHAHighPrevious >= DM_TF_CURR_RESISTANCE )
     || (ExtHAClosePrevious >= DM_TF_CURR_RESISTANCE && ExtHAOpenNow < DM_TF_CURR_RESISTANCE && ExtHACloseNow < DM_TF_CURR_RESISTANCE)
      )       
      PriceBehavior = "DYN SUPP/REST - RESISTANCE TOUCHE";
   
   if (PriceBehavior == "DYN SUPP/REST - SUPPORT TOUCHE" || PriceBehavior == "DYN SUPP/REST - REBOND SUR SUPPORT")
   {
      //if (ExtHACloseNow < DM_TF_CURR_SUPPORT)  PriceBehavior = "DYN SUPP/REST - CASSAGE SUPPORT";  
      if (ExtHACloseNow < DM_TF_CURR_SUPPORT || ExtHACloseNow > MASlowNow)  PriceBehavior = "";  
      if (flagHAInd == 1 && ExtHACloseNow > MAFastNow && flagFastMAInd == 1 && ExtHACloseNow > DM_TF_CURR_SUPPORT) PriceBehavior = "DYN SUPP/REST - REBOND SUR SUPPORT";      
   }
   
   if (PriceBehavior == "DYN SUPP/REST - RESISTANCE TOUCHE" || PriceBehavior == "DYN SUPP/REST - RETOUR A LA BAISSE")
   {
      //if (ExtHACloseNow > DM_TF_CURR_RESISTANCE)  PriceBehavior = "DYN SUPP/REST - FRANCHISSEMENT RESISTANCE";            
      if (ExtHACloseNow > DM_TF_CURR_RESISTANCE || ExtHACloseNow < MASlowNow )  PriceBehavior = "";            
      if (flagHAInd == -1 && ExtHACloseNow < MAFastNow && flagFastMAInd == -1 && ExtHACloseNow < DM_TF_CURR_RESISTANCE) PriceBehavior = "DYN SUPP/REST - RETOUR A LA BAISSE";      
   }

   // invalidation
   
   
   if (PriceBehavior == "DYN SUPP/REST - REBOND SUR SUPPORT")
   {
      
   }   
        
   // passage d'ordre
   if (PriceBehavior == "DYN SUPP/REST - REBOND SUR SUPPORT"
      || PriceBehavior == "DYN SUPP/REST - FRANCHISSEMENT RESISTANCE OK"      
      && (tradeDecisionCounter > 0 || tradeDecisionOK))  {
      myFiboCondition = 1*p;
      typeDecisionOrder = 2;   
      myPrice = DM_TF_CURR_SUPPORT;
      
      if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
   } 
   if (PriceBehavior == "DYN SUPP/REST - CASSAGE SUPPORT OK"
      || PriceBehavior == "DYN SUPP/REST - RETOUR A LA BAISSE"
      && (tradeDecisionCounter > 0 || tradeDecisionOK))  {   
      myFiboCondition = -1*p;
      typeDecisionOrder = 2;    
      myPrice = DM_TF_CURR_RESISTANCE;
        
      if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
   } 
 
}

/*
   Strategie : BREAKOUT NIVEAUX PIVOTS
   Type = 3
*/
void stratPivotSupportResistance()
{
   if (StringFind(PriceBehavior, "HARAMI", 0) >= 0 
   || StringFind(PriceBehavior, "RETRACEMENT", 0) >= 0
   || StringFind(PriceBehavior, "BREAKOUT", 0) >= 0 
   || StringFind(PriceBehavior, "DYN", 0) >= 0 
   || StringFind(PriceBehavior, "BACKBONE", 0) >= 0 
   ) return(NULL);
   
   if ((ExtHALowPrevious <= currentSupportlevel || ExtHAClosePrevious <= currentSupportlevel )  && ExtHACloseNow > currentSupportlevel )      
      PriceBehavior = "PIVOT SUPP/REST - SUPPORT TOUCHE";
   
   if ((ExtHAHighPrevious >= currentResistancelevel || ExtHAClosePrevious >= currentResistancelevel ) && ExtHACloseNow < currentResistancelevel)
      PriceBehavior = "PIVOT SUPP/REST - RESISTANCE TOUCHE";
   
   
   if (PriceBehavior == "PIVOT SUPP/REST - SUPPORT TOUCHE")
   {
      //if (ExtHACloseNow < currentSupportlevel)  PriceBehavior = "PIVOT SUPP/REST - FRANCHISSEMENT SUPPORT";            
      if (flagHAInd == 1 && ExtHACloseNow > MAFastNow && flagFastMAInd == 1) PriceBehavior = "PIVOT SUPP/REST - REBOND SUR SUPPORT";      
   }
   
   if (PriceBehavior == "PIVOT SUPP/REST - RESISTANCE TOUCHE")
   {
      //if (ExtHACloseNow > currentResistancelevel)  PriceBehavior = "PIVOT SUPP/REST - FRANCHISSEMENT RESISTANCE";
      if (flagHAInd == -1 && ExtHACloseNow < MAFastNow && flagFastMAInd == -1) PriceBehavior = "PIVOT SUPP/REST - RETOUR A LA BAISSE";      
   }   
   
   if (PriceBehavior == "PIVOT SUPP/REST - REBOND SUR SUPPORT" && (ExtHACloseNow < MAFastNow || ExtHACloseNow < currentSupportlevel)) PriceBehavior ="";
   if (PriceBehavior == "PIVOT SUPP/REST - RETOUR A LA BAISSE" && (ExtHACloseNow > MAFastNow || ExtHACloseNow > currentResistancelevel)) PriceBehavior ="";
   
   if (PriceBehavior == "PIVOT SUPP/REST - REBOND SUR SUPPORT" && (tradeDecisionCounter > 0 || tradeDecisionOK))  {
      myFiboCondition = 1*p;
      typeDecisionOrder = 3;
      
      myPrice = currentSupportlevel;
      
      if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
   } 
   
   if (PriceBehavior == "PIVOT SUPP/REST - RETOUR A LA BAISSE" && (tradeDecisionCounter > 0 || tradeDecisionOK))  {
      myFiboCondition = -1*p;
      typeDecisionOrder = 3;
      
      myPrice = currentResistancelevel;
      
      if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
   }  
}

/*
   Strategie : BREAKOUT SUPPORT / RESISTANCE DYNAMIQUE
   Type = 4
*/
void stratSupportResistanceBreakOut()
{
   if (StringFind(PriceBehavior, "HARAMI", 0) >= 0 
   || StringFind(PriceBehavior, "DYN", 0) >= 0
   || StringFind(PriceBehavior, "RETRACEMENT", 0) >= 0 
   || StringFind(PriceBehavior, "PIVOT", 0) >= 0 
   ) return(NULL);
   
   if (flagBreakOutInd == 1) 
      PriceBehavior = "BREAKOUT - FRANCHISSEMENT RESISTANCE";
   
   if (flagBreakOutInd == -1) 
      PriceBehavior = "BREAKOUT - CASSAGE SUPPORT";


   if (StringFind(PriceBehavior, "BREAKOUT - FRANCHISSEMENT RESISTANCE") >=0)
   {
      if (ExtHACloseNow < DM_TF_CURR_RESISTANCE || flagGaussInd == -1 ||  flagHAInd == -1 ) PriceBehavior = ""; // PriceBehavior =  "BREAKOUT - FRANCHISSEMENT RESISTANCE - ECHEC" ;
      if (flagGaussInd == 1 && flagHAInd == 1 && flagVolatilityInd == 1) PriceBehavior =  "BREAKOUT - FRANCHISSEMENT RESISTANCE - VALIDER" ;
      
   }
   
   if (StringFind(PriceBehavior, "BREAKOUT - CASSAGE SUPPORT") >= 0) 
   {
      if (ExtHACloseNow > DM_TF_CURR_SUPPORT || flagGaussInd == 1 ||  flagHAInd == 1) PriceBehavior = ""; // PriceBehavior =  "BREAKOUT - CASSAGE SUPPORT - ECHEC" ;
      if (flagGaussInd == -1 && flagHAInd == -1 && flagVolatilityInd == 1) PriceBehavior =  "BREAKOUT - CASSAGE SUPPORT - VALIDER" ;
         
   }
   
   if (PriceBehavior == "BREAKOUT - FRANCHISSEMENT RESISTANCE - VALIDER" && (tradeDecisionCounter > 0 || tradeDecisionOK))  {
      myFiboCondition = 1*p;
      typeDecisionOrder = 4;      
      myPrice = DM_TF_CURR_RESISTANCE;
      
      if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
   } 
   
   if (PriceBehavior == "BREAKOUT - CASSAGE SUPPORT - VALIDER" && (tradeDecisionCounter > 0 || tradeDecisionOK))  {
      myFiboCondition = -1*p;
      typeDecisionOrder = 4; 
      myPrice = DM_TF_CURR_SUPPORT;
      
      if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
   } 
      
}


/*
   Strategie : HARAMI
   Type = 6
*/
void stratChandelierHarami()
{  
   if (StringFind(PriceBehavior, "RETRACEMENT", 0) >= 0 
      || StringFind(PriceBehavior, "DYN", 0) >= 0
      || StringFind(PriceBehavior, "BREAKOUT", 0) >= 0 
      //|| StringFind(PriceBehavior, "BACKBONE", 0) >= 0 
      ) return(NULL);   
   
   if ((ExtHAOpenPrevious > ExtHAOpenNow && ExtHACloseNow > ExtHAClosePrevious
         || ExtHAOpenPrevious > ExtHACloseNow && ExtHACloseNow > ExtHAClosePrevious)
      && ExtHACloseNow < DM_TF_CURR_SUPPORT)
      PriceBehavior = "HARAMI HAUSSIER" ;  
      
            
      
   if ((ExtHAOpenPrevious < ExtHAOpenNow && ExtHACloseNow < ExtHAClosePrevious
           || ExtHAOpenPrevious < ExtHACloseNow && ExtHACloseNow < ExtHAClosePrevious)
      && ExtHACloseNow > DM_TF_CURR_RESISTANCE)      
         PriceBehavior = "HARAMI BAISSIER" ;
      
   if (  StringFind(PriceBehavior, "HARAMI HAUSSIER") >= 0)
   {
      if (ExtHACloseNow < MAFastNow || flagGaussInd == -1) PriceBehavior="";
      if (ExtHACloseNow > MAFastNow && flagGaussInd == 1)
         PriceBehavior = "HARAMI HAUSSIER - VALIDER";
   }           
   
   if ( StringFind(PriceBehavior,"HARAMI BAISSIER") >=0 )
   {
      if (ExtHACloseNow > MAFastNow || flagGaussInd == 1 ) PriceBehavior="";
      if (ExtHACloseNow < MAFastNow && flagGaussInd == -1)
         PriceBehavior = "HARAMI BAISSIER - VALIDER";
   }           
   
   
   if (PriceBehavior =="HARAMI HAUSSIER - VALIDER" && (tradeDecisionCounter > 0 || tradeDecisionOK))  {
      myFiboCondition = 1*p;
      typeDecisionOrder = 6;  
      
      myPrice = MAFastNow;
      
      if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
   } 
   
   if (PriceBehavior == "HARAMI BAISSIER - VALIDER" && (tradeDecisionCounter > 0 || tradeDecisionOK))  {
      myFiboCondition = -1*p;
      typeDecisionOrder = 6;  
      
      myPrice = MAFastNow;  
        
      if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
   }   
   
}

/*
 Strategie : RANGING INTO BACKBONE THEN BREAKOUT
 Type = 7
*/

void stratBackBoneTrader()
{
   
   if (StringFind(PriceBehavior, "HARAMI", 0) >= 0 
      || StringFind(PriceBehavior, "DYN", 0) >= 0
      || StringFind(PriceBehavior, "BREAKOUT", 0) >= 0
      || StringFind(PriceBehavior, "PIVOT", 0) >= 0 
      ) return(NULL);
   
   //todo
   
   if ((MAFastNow < MASlowNow)
      && ((ExtHAOpenPrevious > BackBoneLow && ExtHAOpenPrevious < BackBoneHigh && ExtHAClosePrevious < BackBoneLow )
         || (ExtHAHighPrevious > BackBoneLow && ExtHAClosePrevious < MASlowNow )
         || flagBackBoneInd == -1
         )
      )
      PriceBehavior = "BACKBONE - COLONNE TOUCHEE PAR LE BAS" ;        

   if ((MAFastNow > MASlowNow)
      && ((ExtHAClosePrevious > BackBoneLow && ExtHAClosePrevious < BackBoneHigh && ExtHAOpenPrevious > BackBoneHigh)
         || (ExtHALowPrevious < BackBoneHigh && ExtHAClosePrevious > MASlowNow )
         || flagBackBoneInd == 1)
      )
      PriceBehavior = "BACKBONE - COLONNE TOUCHEE PAR LE HAUT" ;              
   
   // INVALIDATION STEP 1
   if (PriceBehavior == "BACKBONE - COLONNE TOUCHEE PAR LE HAUT" && ExtHACloseNow < MASlowNow ) PriceBehavior = "";
   if (PriceBehavior == "BACKBONE - COLONNE TOUCHEE PAR LE BAS" && ExtHACloseNow > MASlowNow ) PriceBehavior = "";
   
   // step2
   if (PriceBehavior == "BACKBONE - COLONNE TOUCHEE PAR LE HAUT" && ExtHACloseNow > MASlowNow && MAFastNow > MASlowNow && ExtHACloseNow > MAFastNow && flagGaussInd == 1)  PriceBehavior = "BACKBONE - ON REPART A LA HAUSSE";
   if (PriceBehavior == "BACKBONE - COLONNE TOUCHEE PAR LE BAS"  && ExtHACloseNow < MASlowNow && MAFastNow < MASlowNow && ExtHACloseNow < MAFastNow && flagGaussInd == -1) PriceBehavior = "BACKBONE - ON REPART A LA BAISSE";


   // INVALIDATION STEP 2   
   if (PriceBehavior == "BACKBONE - ON REPART A LA HAUSSE" && (MAFastNow < MASlowNow || flagFastMAInd == -1 || flagGaussInd == -1)) PriceBehavior = "";
   if (PriceBehavior == "BACKBONE - ON REPART A LA BAISSE" && (MAFastNow > MASlowNow || flagFastMAInd == 1 || flagGaussInd == 1)) PriceBehavior = "";
   
   
   
   
   //passage d'ordre
   if (PriceBehavior == "BACKBONE - ON REPART A LA HAUSSE" && (tradeDecisionCounter > 0 || tradeDecisionOK)) 
   {
      myFiboCondition = 1*p;
      typeDecisionOrder = 7;      
      
      myPrice = BackBoneHigh;
      
      if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
      
   } 
   
   if (PriceBehavior == "BACKBONE - ON REPART A LA BAISSE"  && (tradeDecisionCounter > 0 || tradeDecisionOK)) 
   {
      myFiboCondition = -1*p;
      typeDecisionOrder = 7;
      myPrice = BackBoneLow;
      
      if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
   }   
}

/*
   Strategie : MEDIAM STRATEGIE
   Type = 8
*/
void stratMedianeTrader()
{
   if (StringFind(PriceBehavior, "HARAMI", 0) >= 0 
   || StringFind(PriceBehavior, "RETRACEMENT", 0) >= 0
   || StringFind(PriceBehavior, "BREAKOUT", 0) >= 0 
   || StringFind(PriceBehavior, "DYN", 0) >= 0 
   || StringFind(PriceBehavior, "BACKBONE", 0) >= 0 
   ) return(NULL);
   
   // touche de mediane
   if ((ExtHALowPrevious <= DM_TF_CURR_MIDDLE || ExtHAClosePrevious <= DM_TF_CURR_MIDDLE )  
      && ExtHACloseNow > DM_TF_CURR_MIDDLE       
      )      
      PriceBehavior = "MEDIANE - A ETE TOUCHE - PAR LE HAUT";
   
   if ((ExtHAHighPrevious >= DM_TF_CURR_MIDDLE || ExtHAClosePrevious >= DM_TF_CURR_MIDDLE ) 
      && ExtHACloseNow < DM_TF_CURR_MIDDLE      
      )
      PriceBehavior = "MEDIANE - A ETE TOUCHE - PAR LE BAS";
   
   // franchissement
   if (ExtHAOpenPrevious < DM_TF_CURR_MIDDLE && ExtHAClosePrevious > DM_TF_CURR_MIDDLE && ExtHAOpenNow > DM_TF_CURR_MIDDLE && ExtHACloseNow > ExtHAOpenNow)      
      PriceBehavior = "MEDIANE - A ETE FRANCHI DU BAS VERS LE HAUT";
   
   if (ExtHAOpenPrevious > DM_TF_CURR_MIDDLE && ExtHAClosePrevious < DM_TF_CURR_MIDDLE && ExtHAOpenNow < DM_TF_CURR_MIDDLE && ExtHACloseNow < ExtHAOpenNow)        
      PriceBehavior = "MEDIANE - A ETE FRANCHI DU HAUT VERS LE BAS";
   
   
   // STEP 2  
   
   
   if (PriceBehavior == "MEDIANE - A ETE TOUCHE - PAR LE HAUT")
   {
      if (ExtHACloseNow < DM_TF_CURR_MIDDLE)  PriceBehavior = "";
      if (flagHAInd == 1 && flagGaussInd == 1 && flagFastMAInd == 1 && ExtHACloseNow > MASlowNow) 
         PriceBehavior = "MEDIANE - REBOND SUR SUPPORT";      
         
         
   }
   
   if (PriceBehavior == "MEDIANE - A ETE TOUCHE - PAR LE BAS")
   {
      if (ExtHACloseNow > DM_TF_CURR_MIDDLE)  PriceBehavior = "";
      if (flagHAInd == -1 && flagGaussInd == -1 && flagFastMAInd == -1 && ExtHACloseNow < MASlowNow) PriceBehavior = "MEDIANE - RETOUR A LA BAISSE";      
   }
   
   
   /// STEP3
   
   if (PriceBehavior == "MEDIANE - REBOND SUR SUPPORT" && (ExtHACloseNow < DM_TF_CURR_MIDDLE || MathAbs(ExtHACloseNow - DM_TF_CURR_MIDDLE) > 5 )) PriceBehavior ="";
   if (PriceBehavior == "MEDIANE - RETOUR A LA BAISSE" && (ExtHACloseNow > DM_TF_CURR_MIDDLE || MathAbs(ExtHACloseNow - DM_TF_CURR_MIDDLE) > 5 )) PriceBehavior ="";
   
   if (PriceBehavior == "MEDIANE - REBOND SUR SUPPORT" 
      //   || PriceBehavior == "MEDIANE - A ETE FRANCHI DU HAUT VERS LE BAS - VALIDER"
      ) {
      myFiboCondition = 1*p;
      typeDecisionOrder = 8;
      
      //determination du meilleur prix d'achat
      
      
         if (DM_TF_CURR_MIDDLE < BackBoneHigh) {
            myPrice = BackBoneHigh;
         }else {
            myPrice = DM_TF_CURR_MIDDLE;
         }
      
      //if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
   } 
   
   if (PriceBehavior == "MEDIANE - RETOUR A LA BAISSE" 
       //  || PriceBehavior == "MEDIANE - A ETE FRANCHI DU BAS VERS LE HAUT - VALIDER"
       ){
      myFiboCondition = -1*p;
      typeDecisionOrder = 8;
      
      if (DM_TF_CURR_MIDDLE > BackBoneLow) {
         myPrice = BackBoneLow;
      }else{
         myPrice = DM_TF_CURR_MIDDLE;
      }
      
      //if (tradeDecisionCounter == 0) {tradeDecisionCounter = 50; tradeDecisionTag = Time[0];}
   }  
}
 
/*
   ARBRE DE DECISION
*/
void getTradeDecision()
{

    
   //if (tradeDecisionCounter == 0) typeDecisionOrder = 0;  

   /***************************************************
      SCENARIO : HARAMI
      TYPE DECISION = 6
   ************************************************** */   
   //stratChandelierHarami();
      
   /***************************************************
      SCENARIO 2: DYNAMIQUE ACHAT SUR SUPPORT / VENTE SUR ECHEC RESISTANCE
      TYPE DECISION = 2
   ************************************************** */   
   //stratDMSupportResistance();
   
   /***************************************************
      SCENARIO 3: PIVOT ACHAT SUR SUPPORT / VENTE SUR ECHEC RESISTANCE
      TYPE DECISION = 3
   ************************************************** */         
   //stratPivotSupportResistance();
   
   
   /***************************************************
      SCENARIO : BREAKOUT
      TYPE DECISION = 4
   ************************************************** */
   //stratSupportResistanceBreakOut();
   
   //stratMovingAverageFractBreakOut();
   

   /***************************************************
      SCENARIO : RETRACEMENT SUR COLONNE VERTEBRALE
      TYPE DECISION = 1
   ************************************************** */
   //stratRetracementBackBone(); 
   
      
   /***************************************************
      SCENARIO : RETRACEMENT SUR COLONNE VERTEBRALE
      TYPE DECISION = 7
   ************************************************** */   
   //stratBackBoneTrader();
   
   
   /***************************************************
      SCENARIO : MEDIANE TRADER
      TYPE DECISION = 8
   ************************************************** */   
   stratMedianeTrader();
      
   /*  GOLDEN/DEATH CROSS */
   
   /*if (flagMACrossInd == 1) {
      myFiboCondition = 1*p;
      typeDecisionOrder = 3;
   }
   if (flagMACrossInd == -1) {
      myFiboCondition = -1*p;
      typeDecisionOrder = 3;
   }*/
   
   /*
   
   if ((flagSlowMAInd == 1 && flagGaussInd == 1 && flagBackBoneInd == 1 && flagHAInd == 1)
      || (flagSlowMAInd == -1 && flagGaussInd == -1 && flagBackBoneInd == -1 && flagHAInd == -1))
   {
      if (flagSlowMAInd == 1 && flagGaussInd == 1 && flagBackBoneInd == 1 && flagHAInd == 1) PriceBehavior = "DEPART HAUSSE";
      if (flagSlowMAInd == -1 && flagGaussInd == -1 && flagBackBoneInd == -1 && flagHAInd == -1) PriceBehavior = "DEPART BAISSE";
   }
   
   
   if ((PriceBehavior == "CA FREMIT A LA HAUSSE" || PriceBehavior == "CA FREMIT A LA BAISSE" ) && flagFastVolatilityInd == 0) PriceBehavior= "";
   
   if (PriceBehavior == "DEPART HAUSSE")
   {
      if (flagBackBoneInd == -1) PriceBehavior = "ECHEC - DEPART HAUSSE";      
     
      if (flagFastVolatilityInd != 0 && flagSlowVolatilityInd == 0 ){
         PriceBehavior = "CA FREMIT A LA HAUSSE" ;
         myFiboCondition = 1*p;
         typeDecisionOrder = 8;         
      } else if (flagFastVolatilityInd != 0 && flagSlowVolatilityInd != 0 ){
         PriceBehavior = "CA PART TROP VITE" ;  
      }
   }
   
   if (PriceBehavior == "DEPART BAISSE")
   {
      if (flagBackBoneInd == 1) PriceBehavior = "ECHEC - DEPART BAISSE";
      
      if (flagFastVolatilityInd != 0 && flagSlowVolatilityInd == 0 ){
         PriceBehavior = "CA FREMIT A LA BAISSE" ;
         myFiboCondition = -1*p;
         typeDecisionOrder = 8;
         PriceBehavior  = "";
      } else if (flagFastVolatilityInd != 0 && flagSlowVolatilityInd != 0 ){
         PriceBehavior = "CA PART TROP VITE" ;  
      }
   }
   */
   
         
   //if (PriceBehavior != "") Print( Symbol(), "-", PriceBehavior);
}

   
//+------------------------------------------------------------------+
//| Check for open order conditions                                  |
//+------------------------------------------------------------------+
void CheckForOpen()
  {
   
   myLots = LotsOptimized();
   string comments="";
   
   // Get Trade decision
   getTradeDecision();
   
   //------------------------------------------------------------------
   //                               Gaussian
   //------------------------------------------------------------------
   if (currentGaussTradeOrder < maxGaussTradeOrder)
   {
      
      if (myFiboCondition != 0)
      {
         if (myFiboCondition == 1)  
         {
            
            
            myStoploss = getPipStopLoss(OP_BUY);
            
            //closeOrder(Symbol(), "CN", OP_SELL);
            
            comments = putParlist(comments, "EA", "CU");
            comments = putParlist(comments, "PR", myPrice);
            comments = putParlist(comments, "SL", myStoploss);
            comments = putParlist(comments, "TO", typeDecisionOrder);
            
            if (myTakeProfit != 0) comments = putParlist(comments, "TP", myTakeProfit); 
            comments = putParlist(comments, "TF", Period()); 
            
            if (alertTag!=Time[0]) 
            {
               Buy(myLots, myStoploss, SymbObjPoint1,comments, magicNumber1);    
               Buy(myLots, myStoploss, SymbObjPoint2,comments, magicNumber1);    
               Buy(myLots, myStoploss, 0,comments, magicNumber1);    
            
               
            } 
         }
         if (myFiboCondition == -1)  
         {
            
            myPrice = myPrice -1;
            myStoploss = getPipStopLoss(OP_SELL);
            
            //closeOrder(Symbol(), "CU", OP_BUY);
            
            comments = putParlist(comments, "EA", "CN");
            comments = putParlist(comments, "PR", myPrice);
            comments = putParlist(comments, "SL", myStoploss);
            comments = putParlist(comments, "TO", typeDecisionOrder);
            
            if (myTakeProfit != 0) comments = putParlist(comments, "TP", myTakeProfit); 
            comments = putParlist(comments, "TF", Period()); 
            
            
            if (alertTag!=Time[0] )
            {      
               Sell(myLots, myStoploss, SymbObjPoint1,comments, magicNumber1);     
               Sell(myLots, myStoploss, SymbObjPoint2,comments, magicNumber1);     
               Sell(myLots, myStoploss, 0,comments, magicNumber1);     
            
               alertTag=Time[0];
            }
            
         }      
      }
   } 
   
   
   return;   
  }
  
//+------------------------------------------------------------------+
//| TrailingStop                           |
//+------------------------------------------------------------------+
void CheckForStopLoss()
{
   int  tip,MAGIC, SL;
   bool error;
   double OSL, BID, ASK, StLo;
   
   for (int i=OrdersTotal(); i>=0; i--) 
   {  if (OrderSelect(i, SELECT_BY_POS)==true)
      {
         tip         = OrderType();
         TekSymbol   =OrderSymbol();
         OSL         = OrderStopLoss();
         MAGIC       = OrderMagicNumber();  
         
         if (tip<2 && (TekSymbol==SymbolTral))
         {
         
            BID            = MarketInfo(OrderSymbol(),MODE_BID);
            ASK            = MarketInfo(OrderSymbol(),MODE_ASK);  
            SL             = StrToInteger(getParList(OrderComment(), "SL"));
            
            if (tip==OP_BUY)             
            { 
               StLo = SlLastBar(1,ASK, TrailingStopSlow);                     
               if (SL != 0) StLo = ASK-SL;
                        
               if (OSL == 0 && StLo != 0) 
               {
                  //Print ("Ticket ", OrderTicket(), " ", tip);
                  error=OrderModify(OrderTicket(),OrderOpenPrice(),StLo, OrderTakeProfit(),0,White);                      
               }
            }
         
            if (tip==OP_SELL)
            { 
               StLo = SlLastBar(-1,BID, TrailingStopSlow);
               if (SL != 0) StLo = BID+SL;
               
               if (OSL == 0 && StLo != 0) 
               {
                  //Print ("Ticket ", OrderTicket(), " ", tip);
                  error=OrderModify(OrderTicket(),OrderOpenPrice(),StLo, OrderTakeProfit(),0,White);       
               }
            }
                       
         }
      }      
   }
} 
    
//+------------------------------------------------------------------+
//| TrailingStop                           |
//+------------------------------------------------------------------+
void TrailingStop(int trailmode)
{
   int tip,Ticket, PIP_BUY_OOP_OSL, PIP_SELL_OOP_OSL, PIP_OOP_BID, PIP_OOP_ASK, EA_SL_PIP, EA_TP_PIP, MAGIC, EA_TR_MODE;
   bool error;
   double OSL,OOP,NoLoss;
   n=0;
   for (int i=OrdersTotal(); i>=0; i--) 
   {  if (OrderSelect(i, SELECT_BY_POS)==true)
      {  tip = OrderType();
         TekSymbol=OrderSymbol();
         
         double minlot            = MarketInfo(TekSymbol,MODE_MINLOT);
         
         if (tip<2 && (TekSymbol==SymbolTral))
         {
            
            POINT          = MarketInfo(TekSymbol,MODE_POINT);
            DIGITS         = MarketInfo(TekSymbol,MODE_DIGITS);
            BID            = MarketInfo(TekSymbol,MODE_BID);
            ASK            = MarketInfo(TekSymbol,MODE_ASK);
            OSL            = NormalizeDouble(OrderStopLoss(), Digits);
            OOP            = NormalizeDouble(OrderOpenPrice(), Digits);
            Ticket         = OrderTicket();
            OTP            = OrderTakeProfit();
            MAGIC          = OrderMagicNumber();  
            
            PIP_BUY_OOP_OSL= getnbPips(OSL, OOP); //PIP between OOP and OSL
            PIP_SELL_OOP_OSL = getnbPips(OOP, OSL); //PIP between OOP and OSL
            PIP_OOP_BID    = getnbPips(BID, OOP); //PIP between OOP and BID
            PIP_OOP_ASK    = getnbPips(OOP, ASK); //PIP between OOP and ASK
            EA_SL_PIP      = StrToInteger(getParList(OrderComment(), "SL"));
            EA_TP_PIP      = StrToInteger(getParList(OrderComment(), "TP"));
            EA_TR_MODE     = StrToInteger(getParList(OrderComment(), "TR"));            
            
            if (tip==OP_BUY)             
            {  n++;
               OrderSelect(i, SELECT_BY_POS);
               
               NoLoss = TProfit(1,TekSymbol, MAGIC);
               
               StLo = SlLastBar(1,ASK, trailmode);   
               
               //if (OSL == 0) StLo = SlLastBar(1,BID, TrailingStopSlow);                                
               //if (OSL >= OOP ) StLo = SlLastBar(1,BID, TrailingStopSlow);                
               if (minlot >= 1) StLo = MathRound(StLo); 
               
               //Print(Ticket, "PIP_OOP_BID ", PIP_OOP_BID, " StLo ", StLo , " trailmode ", trailmode, " OSL ",OSL );
               
               if (StLo==0) continue;  
               if (StLo==OSL ) continue; 
               
               if ((StLo > OSL+StepTrall*POINT)|| OSL==0 )
               {  error=OrderModify(Ticket,OOP,NormalizeDouble(StLo,DIGITS), OTP,0,White);
                  //Print(TekSymbol,"  TrailingStop ",Ticket," ",TimeToStr(TimeCurrent(),TIME_MINUTES),"   SL ",StLo, " OSL ", OSL, " OTP ", OTP, " SEUIL ", OSL+StepTrall*POINT," MODE ", trailmode);
                  if (!error) Print(TekSymbol,"  Error order ",Ticket," TrailingStop ",
                              GetLastError(),"   ",SymbolTral,"   SL ",StLo, " OSL ", OSL, " OTP ", OTP, " SEUIL ", OSL+StepTrall*POINT," MODE ", trailmode);
               }
            }
            if (tip==OP_SELL)        
            {  n++;
               OrderSelect(i, SELECT_BY_POS);               
               
               NoLoss = TProfit(-1,TekSymbol, MAGIC); 
               
               StLo = SlLastBar(-1,BID, trailmode);                 
               
               //if (OSL == 0) StLo = SlLastBar(-1,ASK, TrailingStopSlow);                 
               //if (OSL <= OOP ) StLo = SlLastBar(-1,ASK, TrailingStopSlow);                 
               if (minlot >= 1) StLo = MathRound(StLo);                
               
               //Print(Ticket, "PIP_OOP_ASK ", PIP_OOP_ASK , " StLo ", StLo ," OSL ", OSL , " trailmode ", trailmode );

               if (StLo==0) continue;  
               if (StLo==OSL ) continue; 

               if ((StLo < OSL-StepTrall*POINT) || OSL==0 )
               {                 
                  error=OrderModify(Ticket,OOP,NormalizeDouble(StLo,DIGITS), OTP,0,White);                  
                  //Print(TekSymbol,"  TrailingStop "+Ticket," ",TimeToStr(TimeCurrent(),TIME_MINUTES));                  
                  if (!error ) Print(TekSymbol,"  Error order ",Ticket," TrailingStop ", GetLastError(),"   ",SymbolTral,"   SL ",StLo, " OSL ", OSL, " OTP ", OTP, " OOP ", OOP, " SEUIL ", OSL+StepTrall*POINT," MODE ", trailmode);
               }
            } 
         }
      }
   }
}
//--------------------------------------------------------------------
double SlLastBar(int tip,double price, int pTrailingStop)
{
   double fr=0,FibMid;
   int jj,ii;
   if (pTrailingStop>4)
   {
      trailingName = pTrailingStop + " Points";
      if (tip==1) fr = price - pTrailingStop*POINT;  
      else        fr = price + pTrailingStop*POINT;  
   }
   else
   {
      //------------------------------------------------------- by Fractals
      if (pTrailingStop==2)
      {
         trailingName = "By Fractal";
         if (tip== 1)
         for (ii=1; ii<100; ii++) 
         {
            fr = iFractals(TekSymbol, Period() ,MODE_LOWER,ii);
            if (fr!=0) {fr-=delta*POINT; if (price-STOPLEVEL*POINT > fr) break;}
            else fr=0;
         }
         if (tip==-1)
         for (jj=1; jj<100; jj++) 
         {
            fr = iFractals(TekSymbol,Period(),MODE_UPPER,jj);
            if (fr!=0) {fr+=delta*POINT; if (price+STOPLEVEL*POINT < fr) break;}
            else fr=0;
         }
      }
      //------------------------------------------------------- by candles
      /*if (pTrailingStop==1)
      {
         trailingName = "ByCandles";
         if (tip== 1)
         for (ii=1; ii<500; ii++) 
         {
            fr = iLow(TekSymbol,0,ii)-delta*POINT;
            if (fr!=0) if (price-STOPLEVEL*POINT > fr) break;
            else fr=0;
         }
         if (tip==-1)
         for (jj=1; jj<500; jj++) 
         {
            fr = iHigh(TekSymbol,0,jj)+delta*POINT;
            if (fr!=0) if (price+STOPLEVEL*POINT < fr) break;
            else fr=0;
         }
      }   */
      //------------------------------------------------------- by MVA
      if (pTrailingStop==1)
      {
         
         int PEMA = iMA(TekSymbol,0, MASlowPeriod , 0, MODE_SMA, PRICE_CLOSE,1);
         trailingName = "By MovingAverage "+MASlowPeriod+" "+PEMA ;
         
         if (tip== 1)
         {
            if(price-STOPLEVEL*POINT > PEMA) fr = PEMA-delta *POINT;
            else fr=0;
         }
         if (tip==-1)
         {
            if(price+STOPLEVEL*POINT < PEMA) fr = PEMA+delta *POINT;
            else fr=0;
         }
      }
      //------------------------------------------------------- by PCH
      if (pTrailingStop==3)
      {
         trailingName = "ByPriceChanel";
         //FibMid=(Fib6[1]+Fib7[1])/2;
         //Print(" FibMid", FibMid);
         if (tip== 1)
         {
            if(price-STOPLEVEL*POINT > priceChanMed[1]) {fr = priceChanMed[1] - delta*POINT;}           
            else fr=0;
            
          
         }
         if (tip==-1)
         {
            if(price+STOPLEVEL*POINT < priceChanMed[1]){ fr = priceChanMed[1] + delta*POINT;}
           
            else fr=0;
         } 
         
      }
      //------------------------------------------------------- by PSAR
      if (pTrailingStop==-4)
      {
         trailingName = "BySAR";
         double PSAR = iSAR(TekSymbol,Period(),Step,Maximum,0);
         if (tip== 1)
         {
            if(price-STOPLEVEL*POINT > PSAR) fr = PSAR - delta*POINT;
            else fr=0;
         }
         if (tip==-1)
         {
            if(price+STOPLEVEL*POINT < PSAR) fr = PSAR + delta*POINT;
            else fr=0;
         }
      }
      
      
   }
   //-------------------------------------------------------
   if (visualization && TekSymbol==SymbolTral)
   {
      if (tip== 1)
      {  
         if (fr!=0){
         ObjectDelete("SL Buy");
         ObjectCreate("SL Buy",OBJ_ARROW,0,Time[0]+Period()*60,fr,0,0,0,0);                     
         ObjectSet   ("SL Buy",OBJPROP_ARROWCODE,6);
         ObjectSet   ("SL Buy",OBJPROP_WIDTH,3);
         ObjectSet   ("SL Buy",OBJPROP_COLOR, Blue);}
         
         if (STOPLEVEL>0){
         ObjectDelete("STOPLEVEL-");
         ObjectCreate("STOPLEVEL-",OBJ_ARROW,0,Time[0]+Period()*60,price-STOPLEVEL*POINT,0,0,0,0);                     
         ObjectSet   ("STOPLEVEL-",OBJPROP_ARROWCODE,4);         
         ObjectSet   ("STOPLEVEL-",OBJPROP_COLOR, Blue);}
      }
      if (tip==-1)
      {
         if (fr!=0){
         ObjectDelete("SL Sell");
         ObjectCreate("SL Sell",OBJ_ARROW,0,Time[0]+Period()*60,fr,0,0,0,0);
         ObjectSet   ("SL Sell",OBJPROP_ARROWCODE,6);         
         ObjectSet   ("SL Sell",OBJPROP_WIDTH,3);         
         ObjectSet   ("SL Sell", OBJPROP_COLOR, Pink);}
         
         if (STOPLEVEL>0){
         ObjectDelete("STOPLEVEL+");
         ObjectCreate("STOPLEVEL+",OBJ_ARROW,0,Time[0]+Period()*60,price+STOPLEVEL*POINT,0,0,0,0);                     
         ObjectSet   ("STOPLEVEL+",OBJPROP_ARROWCODE,4);
         ObjectSet   ("STOPLEVEL+",OBJPROP_WIDTH,3);
         ObjectSet   ("STOPLEVEL+",OBJPROP_COLOR, Pink);}
      }
   }
   
   return(fr);
}
//-------------------------------------------------------------------- calculation of total (general) TP
double TProfit(int tip,string Symb, int pMagic)
{
   int b,s;
   double price,price_b,price_s,lot,SLb,SLs,lot_s,lot_b;
   for (int j=0; j<OrdersTotal(); j++)
   {  if (OrderSelect(j,SELECT_BY_POS,MODE_TRADES)==true)
      {  
         if ((pMagic==OrderMagicNumber()) && OrderSymbol()==Symb)
         {
            if (OrderSymbol()==Symb)
            {
               price = OrderOpenPrice();
               lot   = OrderLots();
               if (OrderType()==OP_BUY ) {price_b += price*lot; lot_b+=lot; b++;}                     
               if (OrderType()==OP_SELL) {price_s += price*lot; lot_s+=lot; s++;}
           }  
         }
      }  
   }
   //--------------------------------------
   if (visualization && Symb==SymbolTral)
   {
      ObjectDelete("NoLossBuy");
      ObjectDelete("NoLossBuy_");
      ObjectDelete("NoLossSell");
      ObjectDelete("NoLossSell_");
   }
   if (b!=0) 
   {  SLb = price_b/lot_b;
      if (visualization && Symb==SymbolTral){
         ObjectCreate("NoLossBuy",OBJ_ARROW,0,Time[0]+Period()*60*5,SLb,0,0,0,0);                     
         ObjectSet   ("NoLossBuy",OBJPROP_ARROWCODE,6);
         ObjectSet   ("NoLossBuy",OBJPROP_COLOR, Blue);         
         ObjectCreate("NoLossBuy_",OBJ_ARROW,0,Time[0]+Period()*60*5,SLb,0,0,0,0);                     
         ObjectSet   ("NoLossBuy_",OBJPROP_ARROWCODE,200);
         ObjectSet   ("NoLossBuy_",OBJPROP_COLOR, Blue);}
   }
   if (s!=0) 
   {  SLs = price_s/lot_s;
      if (visualization && Symb==SymbolTral){
         ObjectCreate("NoLossSell",OBJ_ARROW,0,Time[0]+Period()*60*5,SLs,0,0,0,0);                     
         ObjectSet   ("NoLossSell",OBJPROP_ARROWCODE,6);
         ObjectSet   ("NoLossSell",OBJPROP_COLOR, Pink);         
         ObjectCreate("NoLossSell_",OBJ_ARROW,0,Time[0]+Period()*60*5,SLs,0,0,0,0);                     
         ObjectSet   ("NoLossSell_",OBJPROP_ARROWCODE,202);
         ObjectSet   ("NoLossSell_",OBJPROP_COLOR, Pink);}
   }
if (tip== 1) return(SLb);
if (tip==-1) return(SLs);
}
//--------------------------------------------------------------------



void closeOrder(string psymbol, string pEA, int tip)
{
   bool   Result;
   int tot = OrdersTotal();
   
   for(int i=0; i<tot; i++)
   {      
      
      if (OrderSelect(i,SELECT_BY_POS)==true)
      {   
         string orderEA = getParList(OrderComment(), "EA");
         
         //Print (" Order ", Result , " Type=", OrderType(), " " , OrderTicket());
         
         if( OrderType() == OP_BUY && OrderSymbol() == psymbol && OrderType() == tip && orderEA == pEA && magicNumber1 == OrderMagicNumber() )
         {
            Result=OrderClose(OrderTicket(), OrderLots(), BID, Slippage, CLR_NONE);
           // Print (" CloseOrder ", Result , " Type=Buy ", OrderTicket(), " ",BID, " Slippage = ", Slippage, " tot = ", tot);
          
         }
         if(OrderType() == OP_SELL && OrderSymbol() == psymbol && OrderType() == tip && orderEA == pEA && magicNumber1 == OrderMagicNumber())
         {  
            Result=OrderClose(OrderTicket(),OrderLots(), ASK, Slippage, CLR_NONE);
           // Print (" CloseOrder ", Result , " Type=Sell ", OrderTicket(), " " , ASK, " Slippage = ", Slippage, " tot = ", tot);
         } 
       }
     }  
     
     CalculateCurrentOrders(Symbol());
}

     
//+------------------------------------------------------------------+
//|                      ORDERS                                      |
//+------------------------------------------------------------------+
void Buy(double nbLot, int pipStopLoss, int pipTakeProfit, string eaComment, int myMagic)
{
   
   /*if (Symbol() =="FRA40") 
   {
      Sleep(1000);
   } else {
      Sleep(500);
   }*/
   
   RefreshRates();
   
   SymbolTral = Symbol();
   STOPLEVEL=MarketInfo(SymbolTral,MODE_STOPLEVEL);
   POINT  = MarketInfo(SymbolTral,MODE_POINT);
   DIGITS = MarketInfo(SymbolTral,MODE_DIGITS);
   BID    = MarketInfo(SymbolTral,MODE_BID);
   ASK    = MarketInfo(SymbolTral,MODE_ASK);
   SPREAD = MarketInfo(SymbolTral,MODE_SPREAD);
   MARGININIT = MarketInfo(SymbolTral,MODE_MARGININIT);
   
   
   double StopLossPrice=0,TakeProfitPrice =0;

   //if (pipStopLoss < STOPLEVEL) pipStopLoss = MarketInfo(Symbol(), MODE_STOPLEVEL); // This may rise the risk over the requested
   //if (myMaxStoploss < pipStopLoss) pipStopLoss = myMaxStoploss;
   
   if (myMaxStoploss + delta < pipStopLoss) {
      //Print ("Buy aborted too risque: TO=",  typeDecisionOrder , " SL=", pipStopLoss, " / " , myMaxStoploss + delta, " Price ", Ask , " StopPrice ", ASK-pipStopLoss);
      return (false);
   }
   
   closeOrder(Symbol(), "CN", OP_SELL);
      
   if ( currentNbBuys < maxOpenBuyPosition)
   {   
      if (pipStopLoss != 0 ) StopLossPrice = ASK-pipStopLoss;      
      if (pipTakeProfit != 0) TakeProfitPrice = ASK+pipTakeProfit; 
         
      //debug
      //Print ("Buy ", Ask, " Lots ", nbLot, " pipStopLoss ", pipStopLoss, " pipTakeProfit ", pipTakeProfit," StopLossPrice ", StopLossPrice, " TakeProfitPrice ", TakeProfitPrice);                   
      
      if (enableTrading){
         Tradecount++;
         
         ObjectCreate("ORDERSEND-"+Tradecount,OBJ_ARROW,0,Time[0]+Period()*60,myPrice,0,0,0,0);                     
         ObjectSet   ("ORDERSEND-"+Tradecount,OBJPROP_ARROWCODE,241);
         ObjectSet   ("ORDERSEND-"+Tradecount,OBJPROP_COLOR, DarkGreen);
         
         ticket = OrderSend(Symbol(), OP_BUY, nbLot, myPrice, Slippage, 0, TakeProfitPrice, eaComment, myMagic,0,Green);
         PriceBehavior= "";
         tradeDecisionTag = 0;
         
         if (ticket > 0 ) {
            closeOrder(Symbol(), "CN", OP_SELL);
            
            //OrderModify(ticket, OrderOpenPrice(), StopLossPrice, TakeProfitPrice, 0);   
            currentNbBuys++;
            
            if (alertSoundTag != Time[0]) 
            {
               PlaySound("alert.wav");  
               alertSoundTag=Time[0];     
            }
            alertTag=Time[0];     
            
         }else
         {
            //OrderClose(ticket,nbLot,BID,Slippage,CLR_NONE);
            //Print("Error opening BUY order : ",GetLastError(), " pipTakeProfit=", pipTakeProfit , " TakeProfitPrice=", TakeProfitPrice, "My price=", myPrice , " Ask=",ASK ); 
         }
      }else{
         Print("FAKE BUY ", ASK, " SL ",StopLossPrice, " TP ",  TakeProfitPrice);
      }
      
   } 
}

void Sell(double nbLot, int pipStopLoss, int pipTakeProfit, string eaComment, int myMagic)
{
   double StopLossPrice=0,TakeProfitPrice=0;
   
   /*if (Symbol() =="FRA40") 
   {
      Sleep(1000);
   } else {
      Sleep(500);
   }*/
   
   RefreshRates();
   
   SymbolTral = Symbol();
   STOPLEVEL=MarketInfo(SymbolTral,MODE_STOPLEVEL);
   POINT  = MarketInfo(SymbolTral,MODE_POINT);
   DIGITS = MarketInfo(SymbolTral,MODE_DIGITS);
   BID    = MarketInfo(SymbolTral,MODE_BID);
   ASK    = MarketInfo(SymbolTral,MODE_ASK);
   SPREAD = MarketInfo(SymbolTral,MODE_SPREAD);
   MARGININIT = MarketInfo(SymbolTral,MODE_MARGININIT);
   
   //if (pipStopLoss < STOPLEVEL) pipStopLoss = MarketInfo(Symbol(), MODE_STOPLEVEL); // This may rise the risk over the requested
   //if (myMaxStoploss < pipStopLoss) pipStopLoss = myMaxStoploss;
   
   if (myMaxStoploss + delta  < pipStopLoss) {
      //Print ("Sell aborted too risque: TO=",  typeDecisionOrder , " SL=", pipStopLoss, " / " ,myMaxStoploss + delta, " Price  ", Bid, " StopPrice ", BID+pipStopLoss);
      return(false);
   }
   
   closeOrder(Symbol(), "CU", OP_BUY);
   
   
   if ( currentNbSells < maxOpenSellPosition) {   
      
      
      if (pipStopLoss != 0 ) StopLossPrice = BID+pipStopLoss;      
      if (pipTakeProfit != 0 ) TakeProfitPrice = BID-pipTakeProfit;
      
      //debug
      //Print ("Sell ", Bid, " Lots ", nbLot, " pipStopLoss ", pipStopLoss, " pipTakeProfit ", pipTakeProfit," StopLossPrice ", StopLossPrice, " TakeProfitPrice ", TakeProfitPrice);                   
      
      if (enableTrading){
         Tradecount++;
         ObjectCreate("ORDERSEND-"+Tradecount,OBJ_ARROW,0,Time[0]+Period()*60,myPrice,0,0,0,0);                     
         ObjectSet   ("ORDERSEND-"+Tradecount,OBJPROP_ARROWCODE,242);
         ObjectSet   ("ORDERSEND-"+Tradecount,OBJPROP_COLOR, FireBrick);
         
         ticket = OrderSend(Symbol(),OP_SELL, nbLot,myPrice,Slippage,0, TakeProfitPrice,eaComment, myMagic,0,Red);      
         PriceBehavior= "";
         tradeDecisionTag = 0;
         
         if (ticket > 0 ) {
            //OrderModify(ticket, OrderOpenPrice(), StopLossPrice, TakeProfitPrice, 0);   
            closeOrder(Symbol(), "CU", OP_BUY);
            
            currentNbSells++;            
            alertTag=Time[0];  
            
            if (alertSoundTag != Time[0]) 
            {
               PlaySound("alert2.wav");
               alertSoundTag=Time[0];     
            }
            
         }else
         {
            //OrderClose(ticket,nbLot,ASK,Slippage,CLR_NONE);
            //Print("Error opening Sell order : ",GetLastError(), " pipTakeProfit ", pipTakeProfit , " TakeProfitPrice=" , TakeProfitPrice, " My price=", myPrice , " Bid=",BID ); 
         } 
      }else{
         Print("FAKE SELL ", BID, " SL ",StopLossPrice, " TP ",  TakeProfitPrice);
      }         
   }      
}

//+------------------------------------------------------------------+
//|                      INTERNAL FUNCTIONS                          |
//+------------------------------------------------------------------+

string putParlist(string list, string pbalise, string pvalues)
{
   string out;
   out = StringConcatenate("[", pbalise, "#", pvalues, "]");
   out = StringConcatenate(list, out);
   return(out);
}

string getParList(string plist ,string pbalise)
{
   int out,from,to,len;
   string tmp;
   
   from = StringFind(plist, pbalise,0);

   // add the balise lenght
   from = from + StringLen(pbalise) + 1;
   
   to = StringFind(plist, "]", from);
   len = to - from;
   tmp = StringSubstr(plist, from, len);
   
   return(tmp);
}

double getnbPips(double price1, double price2)
{
   if (POINT ==0) POINT =1;
   double myPip = (price1-price2) / POINT;
   return (myPip);
}


void getActiveSymbol()
{
   int n=0;
   string tmpSymbol;
   
   for (int i=OrdersTotal(); i>=0; i--) 
   {  if (OrderSelect(i, SELECT_BY_POS)==true)
      {  int tip = OrderType();
         
         if (tip<2 && (tmpSymbol!=OrderSymbol()) && (OrderSymbol()!=Symbol()))
         {
           tmpSymbol = OrderSymbol();
           n++;
         }
     }
   }     
  
   nbSymb = n;
}

bool checkForTrading()
{
   isTradingAllow = false;
      
   datetime startAMTime = StrToTime(StringConcatenate(iStartTradingHourAM,":", iStartTradingMinuteAM)) ;
   datetime endAMTime = StrToTime(StringConcatenate(iEndTradingHourAM,":", iEndTradingMinuteAM)) ;
   datetime startPMTime = StrToTime(StringConcatenate(iStartTradingHourPM,":", iStartTradingMinutePM)) ;
   datetime endPMTime = StrToTime(StringConcatenate(iEndTradingHourPM,":", iEndTradingMinutePM)) ;

   datetime now = StrToTime(StringConcatenate(Hour(),":", Minute())) ;
    
   if ((now >= startAMTime && now <= endAMTime ) || (now >= startPMTime && now <= endPMTime )   )         
   {
      isTradingAllow = true;
   }else{
     isTradingAllow = false;
   } 
   
   //if (nbSymb >= maxActiveSymbolAllows )return (false);

}

int getPipStopLoss(int tip)
{
   double StLose;
   int ret;
   TekSymbol      = Symbol();
   POINT          = MarketInfo(TekSymbol,MODE_POINT);
   DIGITS         = MarketInfo(TekSymbol,MODE_DIGITS);
   BID            = MarketInfo(TekSymbol,MODE_BID);
   ASK            = MarketInfo(TekSymbol,MODE_ASK);
                    
   if(tip == OP_BUY)
   {
      StLose = SlLastBar(1, ASK, 2);      
      
      if (typeDecisionOrder == 2) StLose = DM_TF_CURR_SUPPORT - delta;
      if (typeDecisionOrder == 4) StLose = DM_TF_CURR_RESISTANCE - delta;
      if (typeDecisionOrder == 6) StLose = MAFastNow - delta;
      if (typeDecisionOrder == 7) StLose = BackBoneLow - delta;
      if (typeDecisionOrder == 8) StLose = DM_TF_CURR_MIDDLE - delta;
            
      ret = getnbPips(ASK, StLose);
   }
   if(tip == OP_SELL) 
   {
      StLose = SlLastBar(-1, BID, 2);      
      
      if (typeDecisionOrder == 2) StLose = DM_TF_CURR_RESISTANCE+delta;
      if (typeDecisionOrder == 4) StLose = DM_TF_CURR_SUPPORT+delta;
      if (typeDecisionOrder == 6) StLose = MAFastNow+delta;
      if (typeDecisionOrder == 7) StLose = BackBoneHigh + delta;
      if (typeDecisionOrder == 8) StLose = DM_TF_CURR_MIDDLE + delta;
      
      ret = getnbPips(StLose, BID);   
   }
   
   //Print("StLose ", StLose, " ret ", ret, " STOPLEVEL ", STOPLEVEL, " myMaxStoploss ", myMaxStoploss );
    
   if (ret < STOPLEVEL || ret == 0) ret = myStoploss;
   
   //Print("StLo ", StLo, " ret ", ret );
   return (ret);
}

void CheckForClosebyObjectives()
{

   int tip,Ticket, MAGIC;
   bool error;
   double BID, ASK, NoLoss ;
   
   for (int i=OrdersTotal(); i>=0; i--) 
   {  if (OrderSelect(i, SELECT_BY_POS)==true)
      {  tip            = OrderType();
         TekSymbol      = OrderSymbol();         
         POINT          = MarketInfo(TekSymbol,MODE_POINT);
         DIGITS         = MarketInfo(TekSymbol,MODE_DIGITS);
         Ticket         = OrderTicket();
         BID            = MarketInfo(TekSymbol,MODE_BID);
         ASK            = MarketInfo(TekSymbol,MODE_ASK);
         MAGIC          = OrderMagicNumber();
         
         if (tip<2 && (TekSymbol==SymbolTral) && OrderMagicNumber() == magicNumber1)
         {
            if (tip == OP_BUY) 
            {
               if ((BID >= tradeBuyObjectives3 && tradeBuyObjectives3 != 0 ) || TradeObjStatus == "BUY_OBJ3_OK" ) {                   
                  TradeObjStatus = "BUY_OBJ3_OK";
                  //CheckForClosebyPnl(30);                  
                  TrailingStop(1);
               } else if ((BID >= tradeBuyObjectives2 && tradeBuyObjectives2 != 0) || TradeObjStatus == "BUY_OBJ2_OK" ) {
                  TradeObjStatus = "BUY_OBJ2_OK";
                  //CheckForClosebyPnl(40);
                  TrailingStop(TrailingStopSlow);
               } else if (BID >= tradeBuyObjectives1 && tradeBuyObjectives1 != 0) {
                  TradeObjStatus = "BUY_OBJ1_OK";
                  securePosition();
                  //TrailingStop(TrailingStopFast);
               }else
               {
                  TrailingStop(TrailingStopSlow);
               }
            }else
            {
               if ((ASK <= tradeSellObjectives3 && tradeSellObjectives3 != 0) || TradeObjStatus == "SELL_OBJ3_OK" ) {
                  TradeObjStatus = "SELL_OBJ3_OK";
                  //CheckForClosebyPnl(30);
                  TrailingStop(1);
               } else if ((ASK <= tradeSellObjectives2 && tradeSellObjectives2 != 0) || TradeObjStatus == "SELL_OBJ2_OK" ){
                  //TradeObjStatus = "SELL_OBJ2_OK";
                  //CheckForClosebyPnl(40);
                  TrailingStop(TrailingStopSlow);
               } else if (ASK <= tradeSellObjectives1 && tradeSellObjectives1 != 0) {
                  TradeObjStatus = "SELL_OBJ1_OK";
                  securePosition();
                  //TrailingStop(TrailingStopFast);
               }  else
               {
                  TrailingStop(TrailingStopSlow);
               }             
            }  
         }
         
      }
   }
}    

 
void CheckForClosebyPnl(double pnlSeuilToler){
   int i, totalSymbol=0;
   CurrentPNL=0;
   pnlSeuilTolerance = pnlSeuilToler;
   int tempProfit;
   
   bool result;
   for ( i=0; i<OrdersTotal(); i++)
   {  
      if (OrderSelect(i, SELECT_BY_POS)==true)
      {  
         if (OrderSymbol() == Symbol() && magicNumber1 == OrderMagicNumber()){
            CurrentPNL = CurrentPNL + OrderProfit();  
         }       
      }
   }   
   
   if (CurrentMaxPNL < CurrentPNL){
      CurrentMaxPNL = CurrentPNL;
   }
   
   //if (isPNLLocked) {
      if (CurrentMaxPNL != 0 && (CurrentMaxPNL - CurrentPNL)/ CurrentMaxPNL > pnlSeuilToler/100 ){
         int tot = OrdersTotal();
         for ( i=0; i<tot; i++)
         { 
            //Print(i, " " , OrderType(), " " , OrderTicket()," ", OrderLots() , " " ,OrderOpenPrice());
            
            if(OrderSelect(i,SELECT_BY_POS)) 
            {
               if (OrderSymbol() == Symbol() && magicNumber1 == OrderMagicNumber() && OrderProfit() > 0){
                  
                  if (OrderType() == OP_BUY) result = OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Bid,5),7,CLR_NONE);
                  if (OrderType() == OP_SELL) result =  OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Ask,5),7,CLR_NONE);
                  
                  //Print(i, " " , OrderType(), " " , OrderTicket()," ", OrderLots() , " " ,OrderOpenPrice(), " " , OrderProfit());
                  
                  if (result) {
                     CurrentMaxPNL = CurrentPNL - OrderProfit(); 
                     //Print("CurrentMaxPNL ", CurrentMaxPNL, " ", (CurrentMaxPNL - CurrentPNL)/ CurrentMaxPNL > pnlSeuilToler/100, " TradeObjStatus ", TradeObjStatus); 
                     
                     if (TradeObjStatus == "BUY_OBJ3_OK" || TradeObjStatus == "SELL_OBJ3_OK") TradeObjStatus="";
                     if (TradeObjStatus == "BUY_OBJ2_OK" || TradeObjStatus == "SELL_OBJ2_OK") TradeObjStatus="";
                 
                  }
                  
               }
               
            }else {
               Print("OrderSelect returned the error of ",GetLastError());
            }
         }
         //Print ("Close All;", i ,"/", tot, " Max=", CurrentMaxPNL , " cur=", CurrentPNL, "  ",( CurrentMaxPNL - CurrentPNL)/ CurrentMaxPNL, " Tol= ",pnlSeuilToler," " ,pnlSeuilToler/100 );
         //isPNLLocked = false;         
      }
  // } 
}


//+------------------------------------------------------------------+
//| initialization of Calspivot function                             |
//+------------------------------------------------------------------+
void isCalsPivot()
  {
   int    tHour;
   double hLine;
   double lLine;
   int i,k;
   
   //Print("Time ", TimeHour(Time[1]));


      double rates[1][6],yesterday_close,yesterday_high,yesterday_low;
      ArrayCopyRates(rates, Symbol(), PERIOD_D1);

      if(DayOfWeek() == 1)
      {
         if(TimeDayOfWeek(iTime(Symbol(),PERIOD_D1,1)) == 5)
         {
             yesterday_close = rates[1][4];
             yesterday_high = rates[1][3];
             yesterday_low = rates[1][2];
         }
         else
         {
            for(int d = 5;d>=0;d--)
            {
               if(TimeDayOfWeek(iTime(Symbol(),PERIOD_D1,d)) == 5)
               {
                   yesterday_close = rates[d][4];
                   yesterday_high = rates[d][3];
                   yesterday_low = rates[d][2];
               }
         
            }  
         }
      }
      else
      {
          yesterday_close = rates[1][4];
          yesterday_high = rates[1][3];
          yesterday_low = rates[1][2];
      }
      
      double R = yesterday_high - yesterday_low;//range
      Pivot = (yesterday_high + yesterday_low + yesterday_close)/3;// Standard Pivot
      Resist3 = Pivot + (R * 1.000);
      Resist2 = Pivot + (R * 0.618);
      Resist1 = Pivot + (R * 0.382);
      Support1 = Pivot - (R * 0.382);
      Support2 = Pivot - (R * 0.618);
      Support3 = Pivot - (R * 1.000);

      
      //Print ("Pivot",Pivot, "Resist1 ", Resist1, " FibResist1 ", FibResist1);
   
  }

void securePosition()
{
   int count;
   bool result;
   for ( int i=0; i<OrdersTotal(); i++)
   { 
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) 
      {
         if (OrderSymbol() == Symbol() && magicNumber1 == OrderMagicNumber() && OrderProfit() >= 2 )
         {  
            //Print ("Securing position ", OrderTicket(), " TYPE ", OrderType(), " OOP " , OrderOpenPrice(), " OSL " , OrderStopLoss(), " PROFIT ", OrderProfit());
            
            if (OrderType() == OP_BUY && OrderStopLoss() < OrderOpenPrice()) 
               result = OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),NULL);            
               
            if (OrderType() == OP_SELL && OrderStopLoss() > OrderOpenPrice()) 
               result = OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),NULL);            
               
              // if (!result) Print ("Securing position KO" );
            
         }
      }
   }   
}  
   

void displayComment()
{
   
   string txt=StringConcatenate(txt,"======= [ CONFIG : " ,ea_version, " @ " ,Hour(),":",Minute(), " TimeFrame: " , Period(), " ] ======= \n"); 
   
   txt = StringConcatenate( txt, "---- Trailing mode : ", trailingName  , "\n" );
   txt = StringConcatenate( txt, "---- Morning       : From ", iStartTradingHourAM, ":" ,iStartTradingMinuteAM, " To ", iEndTradingHourAM,":", iEndTradingMinuteAM, " ");
   txt = StringConcatenate( txt, "|| Afternoon : From ", iStartTradingHourPM, ":" ,iStartTradingMinutePM, " To ", iEndTradingHourPM,":", iEndTradingMinutePM, "\n");
   
   if (isTradingAllow) { 
      txt=StringConcatenate( txt, "---- Marché        : OUVERT / ");
   }else{
      txt=StringConcatenate( txt, "---- Marché        : FERME / ");
   }  
   
   if (enableTrading){
      txt=StringConcatenate( txt, " Trading       : ON", "\n");
   }else{
      txt=StringConcatenate( txt, " Trading       : OFF", "\n");
   } 
   txt=StringConcatenate( txt, "---- Magic Number     : ", magicNumber1,  "\n");
   txt=StringConcatenate( txt, "---- Stop Loss ", myStoploss, " Max " , myMaxStoploss, " Delta : ", delta,  " BreakOutDelta :, " , BreakOutDelta, "\n");
   txt=StringConcatenate( txt, "---- ASK     : ", ASK,  " BID = ", BID, " MY PRICE " , myPrice , "\n");
   
   txt=StringConcatenate( txt, "---- Trading Mode     : >> ", tradeMode,  " << \n");
   txt=StringConcatenate( txt, "---- Objectives     : >> ", SymbObjPoint1, " ", SymbObjPoint2, " ", SymbObjPoint3,  " << \n");
   
      
   txt=StringConcatenate(txt,"========================================= \n");    

   txt=StringConcatenate(txt,"===== [ TRADE MANAGER ] ===== \n");
   txt=StringConcatenate(txt, tradeTxtBody );
   if (TradeObjStatus !="")
   {  
      txt=StringConcatenate(txt, " Trade Objectif : ", TradeObjStatus , "\n");  
   }   
   txt=StringConcatenate(txt,"========================================= \n");
   
   txt=StringConcatenate(txt,"===== [ MARKET PARAMETERS ] ===== \n"); 
   txt=StringConcatenate( txt, " Price Direction : ", PriceDirection , "\n");    
   txt=StringConcatenate( txt, " Trend Direction : ", TrendDirection , "\n");     
   txt=StringConcatenate( txt, " Price Behavior : ", "Counter " , tradeDecisionCounter, " OK :" , tradeDecisionOK, " Type = " , typeDecisionOrder, " ", PriceBehavior , " ", Time[0]-tradeDecisionTag, "\n");  
   txt=StringConcatenate( txt, " Pivot Resistance ", currentResistancelevel , "\n");           
   txt=StringConcatenate( txt, " Pivot Support ", currentSupportlevel , "\n");           
   txt=StringConcatenate(txt,"========================================= \n"); 
   
      
   txt=StringConcatenate(txt,"===== [ DYNAMIC PARAMETERS ] ===== \n"); 
   txt=StringConcatenate( txt, " Mov. Average Period : Fast = ", MAFastPeriod , " Slow = ", MASlowPeriod ,"\n"); 
   txt=StringConcatenate( txt, " Mov. Average Mode : ", MAMode , "\n");    
   txt=StringConcatenate( txt, " Volatility Period : Fast = ", FasterEMA , " Slow = ", SlowerEMA , "\n");  
   txt=StringConcatenate( txt, " Bollinger Period : gauss=", gperiod , " / Band=", bPeriod, "\n");       
   txt=StringConcatenate(txt,"========================================= \n"); 
      
   txt=StringConcatenate(txt,"===== [ DYNAMIC FLAGS ] ===== \n");       
   if (EnableMAFilter) txt=StringConcatenate( txt, " Moving Average  ", flagMAInd , " Fast = ", flagFastMAInd, " Slow = ", flagSlowMAInd, "\n");  
   if (EnableGaussFilter) txt=StringConcatenate( txt, " Moving Average Crossing ", flagMACrossInd , "\n");  
   if (EnableHAFilter) txt=StringConcatenate( txt, " Heiken Ashi     ", flagHAInd , "\n");  
   if (EnableFractalFilter) txt=StringConcatenate( txt, " Fractal Sup/Res ", flagFractalInd , "\n");  
   if (EnableBreakOutFilter) txt=StringConcatenate( txt, " BreakOut Sup/Res ", flagBreakOutInd , "\n");  
   if (EnableBreakOutSpreadFilter) txt=StringConcatenate( txt, " Spread BreakOut Sup/Res ", flagBreakOutSpreadInd , "\n");  
   
   
   if (EnableGaussFilter) txt=StringConcatenate( txt, " Gaussian Rain.  ", flagGaussInd , "\n");     
   if (EnableVolatilityFilter) txt=StringConcatenate( txt, " Volatility  ", flagVolatilityInd ,  " Fast = ",flagFastVolatilityInd, " Slow =", flagSlowVolatilityInd," \n");  
   if (EnableBackBoneFilter) txt=StringConcatenate( txt, " BackBone Band  ", flagBackBoneInd , " / CounterDown : " , backBoneCounterDown, " Current Spread ", MathRound(BackBoneHigh - BackBoneLow), " / Seuil :", MathRound(Bid * 0.01), "\n");  
      
   txt=StringConcatenate(txt,"========================================= \n"); 
   
   txt=StringConcatenate(txt,"===== [ DYNAMIC LOGS ] ===== \n"); 
   if (CurrentMaxPNL != 0) txt=StringConcatenate( txt, " Max P&L: ", CurrentMaxPNL , " € | ", isPNLLocked   , " | ", MathRound(((CurrentMaxPNL - CurrentPNL)/ CurrentMaxPNL)*100), " % "," [ " , pnlSeuil, " € / ", pnlSeuilTolerance , " %]\n");
   txt=StringConcatenate( txt, " Fractal Resistance ", FractalResPrevious , "/", FractalResNow , "\n");   
   txt=StringConcatenate( txt, " Fractal Suppport ", FractalSupPrevious , "/", FractalSupNow, "\n"); 
   if (MAFastUpNow != EMPTY_VALUE) txt=StringConcatenate( txt, " Fast Mov. Average Up  ", MAFastUpNow , "\n");   
   if (MAFastDownNow != EMPTY_VALUE) txt=StringConcatenate( txt, " Fast Mov. Average DW  ", MAFastDownNow , "\n"); 

   if (MASlowUpNow != EMPTY_VALUE) txt=StringConcatenate( txt, " Slow Mov. Average Up  ", MASlowUpNow , "\n");   
   if (MASlowDownNow != EMPTY_VALUE) txt=StringConcatenate( txt, " Slow Mov. Average DW  ", MASlowDownNow , "\n"); 

   txt=StringConcatenate( txt, " Resistance ", "TF=", DM_TF_CURR_RESISTANCE , " TF",TFSUP,"=", DM_TF_SUPP_RESISTANCE , "\n");   
   txt=StringConcatenate( txt, " Support  ", "TF=", DM_TF_CURR_SUPPORT , " TF",TFSUP,"=", DM_TF_SUPP_SUPPORT , "\n");
   txt=StringConcatenate( txt, " Mediane  ", "TF=", DM_TF_CURR_MIDDLE , " TF",TFSUP,"=", DM_TF_SUPP_MIDDLE , "\n");
   txt=StringConcatenate( txt, " Seuil " ,DM_THRESHOLD , " on " , DM_TF_CURR_RESISTANCE - DM_TF_CURR_SUPPORT, "\n");   

   txt=StringConcatenate( txt, " BackBone High   ", BackBoneHigh , "\n"); 
   txt=StringConcatenate( txt, " BackBone Low    ", BackBoneLow , "\n");    

   txt=StringConcatenate( txt, " ExtHAHighPrevious  ", ExtHAHighPrevious , "\n");  
   txt=StringConcatenate( txt, " ExtHALowPrevious  ", ExtHALowPrevious , "\n"); 

   /*
   txt=StringConcatenate( txt, " Resist3  ", Resist3  , "\n");  
   txt=StringConcatenate( txt, " Resist2  ", Resist2  , "\n");  
   txt=StringConcatenate( txt, " Resist1  ", Resist1  , "\n");  
   txt=StringConcatenate( txt, " Pivot    ---> ", Pivot    , " <--- \n");     
   txt=StringConcatenate( txt, " Support1 ", Support1 , "\n");  
   txt=StringConcatenate( txt, " Support2 ", Support2 , "\n");  
   txt=StringConcatenate( txt, " Support3 ", Support3 , "\n");     
   */
   
   
   txt=StringConcatenate(txt,"========================================= \n\n"); 


/*   for(int i=0;i<OrdersTotal();i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
      if(OrderSymbol()==Symbol())
      {
      int ticket = OrderTicket();
      
      txt=StringConcatenate( txt, "Ticket: ", ticket,  " TrailingMode: ", trailingDeal[ticket], "\n");
  
      }
   }   */

   
   Comment(txt);

}

