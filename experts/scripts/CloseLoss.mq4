//+------------------------------------------------------------------+
//|                                               CloseAllTrades.mq4 |
//|                                                     Matus German |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Matus German"

//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+

// script closes all opened and pending positions
int start()
  {
     for(int i=0;i<OrdersTotal();i++)
     {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) 
         {
            if (OrderProfit() < 0 ) 
            {
               switch(OrderType())
               {
                  case OP_BUY       :OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Bid,5),7,CLR_NONE); break;
                  case OP_SELL      :OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Ask,5),7,CLR_NONE); break;
                  case OP_BUYLIMIT  :OrderDelete(OrderTicket()); break;
                  case OP_SELLLIMIT :OrderDelete(OrderTicket()); break;
                  case OP_BUYSTOP   :OrderDelete(OrderTicket()); break;
                  case OP_SELLSTOP  :OrderDelete(OrderTicket()); break;
                  default           :Alert("Unknown order type: ",OrderType()," of trade ticket ",OrderTicket());
               }
             }    
         }
     }

   return(0);
  }
//+------------------------------------------------------------------+