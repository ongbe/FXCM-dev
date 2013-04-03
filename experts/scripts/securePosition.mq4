//+------------------------------------------------------------------+
//|                                               securePosition.mq4 |
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
//----


for (int i=OrdersTotal(); i>=0; i--) 
   {  if (OrderSelect(i, SELECT_BY_POS)==true)
      {  
         if (OrderStopLoss() == 0) {
         
         int StepTrall = MarketInfo(OrderSymbol(),MODE_STOPLEVEL);         
         
             switch(OrderType())
               {
               
                  case OP_BUY       :OrderModify(OrderTicket(),OrderOpenPrice(), Bid - StepTrall * Point,OrderTakeProfit(),NULL); break;
                  case OP_SELL      :OrderModify(OrderTicket(),OrderOpenPrice(), Ask + StepTrall * Point,OrderTakeProfit(),NULL); break;
                 
               }
            
         } else {
            OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),NULL);
            
         }
         
         
      }     
   }
   
//----
   return(0);
  }
//+------------------------------------------------------------------+