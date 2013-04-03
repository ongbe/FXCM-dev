//+------------------------------------------------------------------+
//|                                                clearStopLoss.mq4 |
//|                      Copyright © 2011, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2011, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
  Comment("");
//----
   for(int i=0;i<OrdersTotal();i++)
     {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) 
         {
             OrderModify(OrderTicket(), OrderOpenPrice(), 0,0,NULL);
         }
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+