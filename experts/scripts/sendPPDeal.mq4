//+------------------------------------------------------------------+
//|                                                   sendPPDeal.mq4 |
//|                      Copyright © 2011, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2011, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

extern int nbLot = 1;
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
//----
   //----
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


//---- Calculate Pivots

///Comment("\nYesterday quotations:\nH ",yesterday_high,"\nL ",yesterday_low, "\nC ",yesterday_close);
double R = yesterday_high - yesterday_low;//range
double p = (yesterday_high + yesterday_low + yesterday_close)/3;// Standard Pivot
double r3 = p + (R * 1.000);
double r2 = p + (R * 0.618);
double r1 = p + (R * 0.382);
double s1 = p - (R * 0.382);
double s2 = p - (R * 0.618);
double s3 = p - (R * 1.000);

//---

if (Ask > p && (Ask < r1 )){
   
   // ACHAT=S1 SL=S2 TP=P
   OrderSend(Symbol(), OP_BUYLIMIT, nbLot, NormalizeDouble(s1,0), 3,  NormalizeDouble(s2,0), NormalizeDouble(p,0), "Fib. PP Deal (A)", 123456, 0,Green);


   // ACHAT=S1 SL=S2 TP=P
   OrderSend(Symbol(), OP_BUYLIMIT, nbLot, NormalizeDouble(p,0), 3,  NormalizeDouble(s1,0), NormalizeDouble(r1,0), "Fib. PP Deal (A)", 123456, 0,Green);


   // VENTE
   OrderSend(Symbol(), OP_SELLLIMIT, nbLot, NormalizeDouble(r1,0), 3,  NormalizeDouble(r2,0), NormalizeDouble(p,0), "Fib. PP Deal (V)", 654321, 0,Green);
}

if (Ask > r1 && (Ask < r2 )){

   // ACHAT
   OrderSend(Symbol(), OP_BUYLIMIT, nbLot, NormalizeDouble(r1,0), 3,  NormalizeDouble(p,0), NormalizeDouble(r2,0), "Fib. PP Deal (A)", 123456, 0,Green);


   // ACHAT
   OrderSend(Symbol(), OP_BUYLIMIT, nbLot, NormalizeDouble(p,0), 3,  NormalizeDouble(s1,0), NormalizeDouble(r1,0), "Fib. PP Deal (A)", 123456, 0,Green);
   

   //VENTE
   OrderSend(Symbol(), OP_SELLLIMIT, nbLot, NormalizeDouble(r2,0), 3,  NormalizeDouble(r3,0), NormalizeDouble(r1,0), "Fib. PP Deal (V)", 654321, 0,Green);
}

if (Ask < p && (Ask > s1 )){
   // ACHAT
   OrderSend(Symbol(), OP_BUYLIMIT, nbLot, NormalizeDouble(s1,0), 3,  NormalizeDouble(s2,0), NormalizeDouble(p,0), "Fib. PP Deal (A)", 123456, 0,Green);
   
   OrderSend(Symbol(), OP_BUYLIMIT, nbLot, NormalizeDouble(s2,0), 3,  NormalizeDouble(s3,0), NormalizeDouble(s1,0), "Fib. PP Deal (A)", 123456,0,Green);


   // VENTE
   OrderSend(Symbol(), OP_SELLLIMIT, nbLot, NormalizeDouble(p,0), 3,  NormalizeDouble(r1,0), NormalizeDouble(s1,0), "Fib. PP Deal (V)", 654321, 0,Green);

}

if (Ask < s1 && (Ask > s2 )){
   // ACHAT
   OrderSend(Symbol(), OP_BUYLIMIT, nbLot, NormalizeDouble(s2,0), 3,  NormalizeDouble(s3,0), NormalizeDouble(s1,0), "Fib. PP Deal (A)", 123456, 0,Green);

   OrderSend(Symbol(), OP_BUYLIMIT, nbLot, NormalizeDouble(s3,0), 3,  NormalizeDouble(s3,0)-15, NormalizeDouble(s2,0), "Fib. PP Deal (A)", 123456,0,Green);

   // VENTE
   OrderSend(Symbol(), OP_SELLLIMIT, nbLot, NormalizeDouble(s1,0), 3,  NormalizeDouble(p,0), NormalizeDouble(s2,0), "Fib. PP Deal (V)", 654321, 0,Green);

}
   
if (Ask < s2 ){
   // ACHAT
   OrderSend(Symbol(), OP_BUYLIMIT, nbLot, NormalizeDouble(s3,0), 3,  NormalizeDouble(s3,0) - 15,  NormalizeDouble(s2,0), "Fib. PP Deal (A)", 123456, 0,Green);


   // VENTE
   OrderSend(Symbol(), OP_SELLLIMIT, nbLot, NormalizeDouble(s1,0), 3,  NormalizeDouble(p,0), NormalizeDouble(s2,0), "Fib. PP Deal (V)", 654321, 0,Green);
   
   OrderSend(Symbol(), OP_SELLLIMIT, nbLot, NormalizeDouble(s2,0), 3,  NormalizeDouble(s1,0), NormalizeDouble(s3,0), "Fib. PP Deal (V)", 654321, 0,Green);

}
  
  
  

//----
   return(0);
  }
//+------------------------------------------------------------------+