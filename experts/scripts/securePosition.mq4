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
             switch(OrderType())
               {
               
                  case OP_BUY       :OrderModify(OrderTicket(),OrderOpenPrice(), Bid - 5 * Point,0,NULL); break;
                  case OP_SELL      :OrderModify(OrderTicket(),OrderOpenPrice(), Ask + 5 * Point,0,NULL); break;
                 
               }
            
         } else {
            OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),0,NULL);
            
         }
         
         
      }     
   }
   
//----
   return(0);
  }
//+------------------------------------------------------------------+