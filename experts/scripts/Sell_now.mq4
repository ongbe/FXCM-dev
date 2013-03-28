//+----------  --------------------------------------------------------+
//|                                               Trader Script1.mq4 |
//|                                                        Oje Uadia |
//|                                         moneyinthesack@yahoo.com |
//+------------------------------------------------------------------+
#property copyright "Oje Uadia"
#property link      "moneyinthesack@yahoo.com"
//#property show_inputs
#include <stderror.mqh>
#include <stdlib.mqh> 
double MaxExpo = 0.01;
int ticket, n;
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
  
   ticket= OrderSend(Symbol(),OP_SELL,getLotSize(),Bid,3, 0,0, "Manuel Sell" ,230380,0,Red);
   /*
   if(ticket<0)
   {
      Alert("OrderSend failed with error #", ErrorDescription(GetLastError()));
     
   } 
   Print("Starting script ",TimeToStr(TimeCurrent(),TIME_SECONDS));
   while(true)
   {
      RefreshRates();
      trailingStop();
      if (n==0) break;
      Sleep(500);         
   }
   Print("Closing script ",TimeToStr(TimeCurrent(),TIME_SECONDS));
   Comment("Closing script ",TimeToStr(TimeCurrent(),TIME_SECONDS));
   */
   
  }
  
double getLotSize()
{
   double MinLot = MarketInfo(Symbol(),MODE_MINLOT);
   double MaxLot = MarketInfo(Symbol(),MODE_MAXLOT);  
   int marge = MarketInfo(Symbol(),MODE_MARGINREQUIRED);
   double lotstep = MarketInfo(Symbol(),MODE_LOTSTEP);
   
   if (marge==0) return (MinLot);
  
   //double Lotsi = MathFloor(AccountFreeMargin()*MaxExpo/MarketInfo(Symbol(),MODE_MARGINREQUIRED));   
   double Lotsi = MathFloor(AccountFreeMargin()*MaxExpo/(marge*lotstep))* lotstep;
   if(Lotsi<MinLot)Lotsi=MinLot;
   if(Lotsi>MaxLot)Lotsi=MaxLot;
   if (Symbol() == "XAU_USD") return (1);
   return(Lotsi);   
}  


//+------------------------------------------------------------------+
//| trailingStop
//+------------------------------------------------------------------+
int trailingStop()
{
   int tip,Ticket,StepTrall=MarketInfo(Symbol(),MODE_STOPLEVEL);
   bool error;
   double OSL,OOP,OTP,NoLoss, StLo;
   string TekSymbol;
   n=0;
   
   for (int i=OrdersTotal(); i>=0; i--) 
   {  
      if (OrderSelect(i, SELECT_BY_POS)==true)
      {  
         tip = OrderType();
         TekSymbol=OrderSymbol();
         
         if (tip<2 && TekSymbol == Symbol() )
         {
            OSL            = NormalizeDouble(OrderStopLoss(), Digits);
            OOP            = NormalizeDouble(OrderOpenPrice(), Digits);
            OTP            = NormalizeDouble(OrderTakeProfit(), Digits);
            Ticket         = OrderTicket();
            
            if (tip==OP_BUY)             
            {
               n++;
               StLo = SlLastBar(1,Bid, StepTrall*2);               
               
               if (OSL >= OOP && OSL != 0) StLo = SlLastBar(1,Bid, 2);    
               if (Symbol() == "XAU_USD" ) StLo = SlLastBar(1,Bid, 2);
               
               
               if ((StLo > OSL+StepTrall*Point) || OSL==0 )
               {
                  if( OSL == 0) OTP = SlLastBar(-1,Ask, 2);
                  
                  OrderModify(Ticket,OOP,NormalizeDouble(StLo,Digits), OTP,0,White);
                  Comment(TekSymbol,"  TrailingStop ",Ticket," ",TimeToStr(TimeCurrent(),TIME_MINUTES), " trail", StepTrall);            
               }
            
            }
            if (tip==OP_SELL)             
            {
               n++;
               StLo = SlLastBar(-1,Ask, StepTrall*2);               
               if (OSL <= OOP && OSL != 0) StLo = SlLastBar(-1,Ask, 2);    
               if (Symbol() == "XAU_USD" ) StLo = SlLastBar(-1,Ask, 2);           
               
               if ((StLo < OSL-StepTrall*Point) || OSL==0 )
               {
                  if( OSL == 0) OTP = SlLastBar(1,Bid, 2);
               
                  OrderModify(Ticket,OOP,NormalizeDouble(StLo,Digits), OTP,0,White);
                  Comment(TekSymbol,"  TrailingStop "+Ticket," ",TimeToStr(TimeCurrent(),TIME_MINUTES), " trail", StepTrall);                  
               }
            }            
         }
      }
   }

   return(0);
}

//+------------------------------------------------------------------+
//| LAST BAR
//+------------------------------------------------------------------+

double SlLastBar(int tip,double price, int pTrailingStop)
{
   double fr=0;
   int jj,ii, delta, STOPLEVEL;
   int EMA_STOPLOSS=100;
   double POINT = Point;
   string TekSymbol = Symbol();
   
   STOPLEVEL = MarketInfo(Symbol(),MODE_STOPLEVEL);
   
   if (Symbol() == "XAU_USD" ){
    delta = 20;
   }else {
      delta = 5;
   }
   
   if (pTrailingStop>4)
   {
      if (tip==1) fr = price - pTrailingStop*POINT;  
      else        fr = price + pTrailingStop*POINT;  
   }
   else
   {
      //------------------------------------------------------- by Fractals
      if (pTrailingStop==2)
      {
         if (tip== 1)
         for (ii=1; ii<100; ii++) 
         {
            fr = iFractals(TekSymbol,0 ,MODE_LOWER,ii);
            if (fr!=0) {fr-=delta*POINT; if (price-STOPLEVEL*POINT > fr) break;}
            else fr=0;
         }
         if (tip==-1)
         for (jj=1; jj<100; jj++) 
         {
            fr = iFractals(TekSymbol,0,MODE_UPPER,jj);
            if (fr!=0) {fr+=delta*POINT; if (price+STOPLEVEL*POINT < fr) break;}
            else fr=0;
         }
      }
      //------------------------------------------------------- by candles
      if (pTrailingStop==1)
      {
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
      }   
      //------------------------------------------------------- by MVA
      if (pTrailingStop==4)
      {
         int PEMA = iMA(TekSymbol,0, EMA_STOPLOSS ,0,MODE_EMA,PRICE_CLOSE,1);
         if (tip== 1)
         {
            if(price-STOPLEVEL*POINT > PEMA) fr = PEMA - delta*POINT;
            else fr=0;
         }
         if (tip==-1)
         {
            if(price+STOPLEVEL*POINT < PEMA) fr = PEMA + delta*POINT;
            else fr=0;
         }
      }
   }
   //-------------------------------------------------------

   if (tip== 1)
   {  
      if (fr!=0){
      ObjectDelete("SL Buy");
      ObjectCreate("SL Buy",OBJ_ARROW,0,Time[0]+Period()*60,fr,0,0,0,0);                     
      ObjectSet   ("SL Buy",OBJPROP_ARROWCODE,6);
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
      ObjectSet   ("SL Sell", OBJPROP_COLOR, Pink);}
      if (STOPLEVEL>0){
      ObjectDelete("STOPLEVEL+");
      ObjectCreate("STOPLEVEL+",OBJ_ARROW,0,Time[0]+Period()*60,price+STOPLEVEL*POINT,0,0,0,0);                     
      ObjectSet   ("STOPLEVEL+",OBJPROP_ARROWCODE,4);
      ObjectSet   ("STOPLEVEL+",OBJPROP_COLOR, Pink);}
   }
   
   return(fr);
}