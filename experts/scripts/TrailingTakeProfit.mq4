//+------------------------------------------------------------------+
//|                                                     Trailing.mq4 |
//|                      Copyright © 2011, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2011, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
double pt = 15;

int start()
  {
//----
   

   for (int i=OrdersTotal(); i>=0; i--) 
   {  if (OrderSelect(i, SELECT_BY_POS)==true)
      {  
         int StepTrall = MarketInfo(OrderSymbol(),MODE_STOPLEVEL);         
         
         if (OrderType() == OP_BUY) OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),Bid+pt,NULL);
         if (OrderType() == OP_SELL)OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),Ask-pt,NULL);
      }     
   }
//----
   return(0);
  }
//+------------------------------------------------------------------+