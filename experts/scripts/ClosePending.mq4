//+------------------------------------------------------------------+
//|                                               CloseAllTrades.mq4 |
//|                                                     Matus German |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Matus German"

//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int i;

// script closes all opened and pending positions
int start()
  {
   for(int i=0;i<OrdersTotal();i++)
     {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) 
         {
            switch(OrderType())
            {
               case OP_BUYLIMIT  :OrderDelete(OrderTicket());
               case OP_SELLLIMIT :OrderDelete(OrderTicket());
               case OP_BUYSTOP   :OrderDelete(OrderTicket());
               case OP_SELLSTOP  :OrderDelete(OrderTicket()); break;
            }
                  
         }
     }

   return(0);
  }
//+------------------------------------------------------------------+