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
      while(OrdersTotal()>0){
         if(OrderSelect(0,SELECT_BY_POS,MODE_TRADES)) 
         {
            switch(OrderType())
            {
               case OP_BUY       :OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Bid,5),7,CLR_NONE); break;
               case OP_SELL      :OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Ask,5),7,CLR_NONE); break;
               case OP_BUYLIMIT  :break;
               case OP_SELLLIMIT :break;
               case OP_BUYSTOP   :break;
               case OP_SELLSTOP  :break;
               default           :Alert("Unknown order type: ",OrderType()," of trade ticket ",OrderTicket());
            }
                  
         }
     }

   return(0);
  }
//+------------------------------------------------------------------+