//+------------------------------------------------------------------+
//|                                                       random.mq4 |
//|                        Copyright 2013, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2013, Stéphane Alamichel"

string ea_version = "Alembex - RANDOM TRADER - v1.4";
extern int    myTakeProfit = 50;
extern int    myStoploss = 50;
extern int    myFakeTakeProfit = 500;
extern int    myFakeStoploss = 500;

//--------------------------------------------------------------------
int      STOPLEVEL,n,DIGITS,SPREAD;
double   BID,ASK,POINT,MARGININIT, OTP, StLo;
string   SymbolTral,TekSymbol;
int      Slippage      = 10;
//--------------------------------------------------------------------

extern string  parameters.trailing = "Money management" ;
extern double  MaxR = 0.05;   // max risk

int magicNumber1 = 456789;


int currentNbBuys=0, currentNbSells=0,nbCurrentTrade=0;
double myLots;
int Tradecount=0;
int myTradeSens;

double GrossProfit, GrossLoss,currentProfit;
double suiteGains=0, suitePertes=0,nbTradeGains, nbTradePertes, nbTradeGainsInRow, nbTradePertesInRow;
double cumulPertes=0, volume=0;
int sensPosition;

string  parameters.trade  = "Max trade allowed";
int  maxOpenBuyPosition      = 1;
int  maxOpenSellPosition     = 1;
int  maxActiveSymbolAllows   = 1;

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   
//----
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
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
//----
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
   
   // GET CURRENT ORDERS
   CalculateCurrentOrders(SymbolTral);   
   
   
   //Open trades
   CheckForOpen(GetRandomTradeCommand(), LotsOptimized());

   //Close trades
   CheckForClose();     
   
   displayComment();
   
   
//----
   return(0);
  }
  
//+------------------------------------------------------------------+
//| On verifie pour ouvrir une position                              |
//+------------------------------------------------------------------+    
void CheckForOpen(int psens, double pvols )
{
   string comments="";

   if (nbCurrentTrade < maxActiveSymbolAllows){

      myTradeSens = psens;
   
      if (myTradeSens == OP_BUY)  
      {   
         comments = putParlist(comments, "EA", "CU");
         //comments = putParlist(comments, "SL", ASK - myStoploss * POINT);
         //comments = putParlist(comments, "TP", ASK + myTakeProfit * POINT + SPREAD * 2 * POINT); 
         
         Buy(pvols, myStoploss, myTakeProfit,comments, magicNumber1);             
      
      }else{
   
         comments = putParlist(comments, "EA", "CN");
         //comments = putParlist(comments, "SL", BID + myStoploss * POINT);
         //comments = putParlist(comments, "TP", BID - myTakeProfit * POINT - * POINT); 
   
         Sell(pvols, myStoploss, myTakeProfit,comments, magicNumber1);     
      
      }
   }      
}

void CheckForClose()
{
   for (int i=OrdersTotal(); i>=0; i--) 
   {  if (OrderSelect(i, SELECT_BY_POS)==true)
      {  
         TekSymbol      = OrderSymbol();
         
         if (OrderType()<2 && (TekSymbol==SymbolTral) && OrderMagicNumber() == magicNumber1)
         {
            if (OrderType() == OP_BUY) 
            {
               //SL
               if (ASK < OrderOpenPrice() - myStoploss * POINT) closeOrder(Symbol(), "CU", OP_BUY);
               
               //TP
               if (BID >= OrderOpenPrice() + myTakeProfit * POINT + SPREAD * POINT) closeOrder(Symbol(), "CU", OP_BUY);               
               
            }else
            {                 
               //SL
               if (BID > OrderOpenPrice() + myStoploss * POINT) closeOrder(Symbol(), "CN", OP_SELL);
               
               //TP
               if (ASK <= OrderOpenPrice() - myTakeProfit * POINT - SPREAD * POINT) closeOrder(Symbol(), "CN", OP_SELL);                
              
               
            }  
         }
         
      }
   }
}    
    
    
//+------------------------------------------------------------------+
//| pile ou face                                         |
//+------------------------------------------------------------------+  
 
int GetRandomTradeCommand()
{  
   return (MathMod(MathRand(),2));
}
  
  
void closeOrder(string psymbol, string pEA, int tip)
{
   bool   Result;
   int tot = OrdersTotal();
   string comments;
   string trace;
   
   for(int i=0; i<tot; i++)
   {  
      if (OrderSelect(i,SELECT_BY_POS)==true)
      {   
         
         string orderEA = getParList(OrderComment(), "EA");
         
         if (magicNumber1 == OrderMagicNumber() && OrderSymbol() == psymbol)
         {
         
            if (OrderProfit() > 0) {
               GrossProfit+=OrderProfit();         
               suiteGains+=1;  
               nbTradeGains++;  
               nbTradeGainsInRow++;
            
               if(suiteGains == 1)
         	   {
         	      //on a essuyé les pertes
         		   if(OrderLots() != cumulPertes)
         		   {
         			   cumulPertes -= OrderLots();
         			   volume = cumulPertes;/////////////////////
         			   sensPosition = OrderType();
         			   
         			   trace="1";
         		   }
         		   else
         		   {
         			   volume = cumulPertes;
         			   sensPosition = OrderType();
         			   trace="2";
         		   }
         	   }else if(suiteGains == 2)
         	   {
         		   volume = LotsOptimized();//InitialVolume;////////////////////////
         		   sensPosition = OrderType();
         		   cumulPertes = 0;
         		   trace="3";
         	   }
            	
            }else{
               GrossLoss+=OrderProfit();            
         	   cumulPertes += OrderLots();
         	   suiteGains = 0;
         	   suitePertes++; 
         	   nbTradePertesInRow++;
         	   volume = LotsOptimized();////////////////////////
               if(OrderType() == OP_BUY) sensPosition = OP_SELL;
               if(OrderType() == OP_SELL) sensPosition = OP_BUY;
               trace="4";
            
            }
            
            //Print(OrderTicket(), " " , volume, " " , cumulPertes, " " , suiteGains ," ", trace);

         
            if( OrderType() == OP_BUY && OrderSymbol() == psymbol && OrderType() == tip && orderEA == pEA && magicNumber1 == OrderMagicNumber() )
            {
               Result=OrderClose(OrderTicket(), OrderLots(), BID, Slippage, CLR_NONE);            
               nbCurrentTrade--;   
               currentNbBuys--;
            }
            if(OrderType() == OP_SELL && OrderSymbol() == psymbol && OrderType() == tip && orderEA == pEA && magicNumber1 == OrderMagicNumber())
            {  
               Result=OrderClose(OrderTicket(),OrderLots(), ASK, Slippage, CLR_NONE);
               nbCurrentTrade--;   
               currentNbSells--;
            }
         
            if (volume==0)  volume = LotsOptimized();
         
            CheckForOpen(sensPosition, volume);       
         }          
       }
     }  
     CalculateCurrentOrders(Symbol());
     
}

//+------------------------------------------------------------------+
//| Calculate open positions                                         |
//+------------------------------------------------------------------+
void CalculateCurrentOrders(string symbol)
{   
      
   string EAEntry;
   currentNbBuys=0;
   currentNbSells=0;
   nbCurrentTrade=0;
   currentProfit=0;
   
//----
   for(int i=0;i<OrdersTotal();i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
      if(OrderSymbol()==Symbol())
      {
         if (OrderMagicNumber() == magicNumber1)
         {
            nbCurrentTrade++;   
            currentProfit += OrderProfit();   
            
            EAEntry = getParList(OrderComment(), "EA");       

            if(OrderType()==OP_BUY)  currentNbBuys++;
            if(OrderType()==OP_SELL) currentNbSells++;
         }
      }
   }
} 

//+------------------------------------------------------------------+
//|                      ORDERS                                      |
//+------------------------------------------------------------------+
void Buy(double nbLot, int pipStopLoss, int pipTakeProfit, string eaComment, int myMagic)
{
   double StopLossPrice=0,TakeProfitPrice =0, fakeStopLossPrice=0, fakeTakeProfitPrice =0;
   int ticket;
   double myPrice;
   
   myPrice = ASK;
   fakeStopLossPrice = ASK - myFakeStoploss * POINT - SPREAD * POINT ;
   fakeTakeProfitPrice = ASK + myFakeTakeProfit * POINT + SPREAD * POINT;
   StopLossPrice = ASK - myStoploss * POINT - SPREAD * POINT;
   TakeProfitPrice = ASK + myTakeProfit * POINT + SPREAD * POINT;
      
   if ( currentNbBuys < maxOpenBuyPosition)
   {   
      Tradecount++;
         
      ObjectCreate("ORDERSEND-"+Tradecount,OBJ_ARROW,0,Time[0]+Period()*60,myPrice,0,0,0,0);                     
      ObjectSet   ("ORDERSEND-"+Tradecount,OBJPROP_ARROWCODE,241);
      ObjectSet   ("ORDERSEND-"+Tradecount,OBJPROP_COLOR, DarkGreen);
      
      ObjectCreate("SL-"+Tradecount,OBJ_ARROW,0,Time[0]+Period()*60,StopLossPrice,0,0,0,0);                     
      ObjectSet   ("SL-"+Tradecount,OBJPROP_ARROWCODE,251);
      ObjectSet   ("SL-"+Tradecount,OBJPROP_COLOR, FireBrick); 
      
      ObjectCreate("TP-"+Tradecount,OBJ_ARROW,0,Time[0]+Period()*60,TakeProfitPrice,0,0,0,0);                     
      ObjectSet   ("TP-"+Tradecount,OBJPROP_ARROWCODE,252);
      ObjectSet   ("TP-"+Tradecount,OBJPROP_COLOR, DarkGreen);            
      
      ticket = OrderSend(Symbol(), OP_BUY, nbLot, myPrice, Slippage, fakeStopLossPrice, fakeTakeProfitPrice, eaComment, myMagic,0,Green);
      
      if (ticket > 0 ) {
        
         //OrderModify(ticket, OrderOpenPrice(), StopLossPrice, TakeProfitPrice, 0);   
         currentNbBuys++;
         
      }else
      {
         //OrderClose(ticket,nbLot,BID,Slippage,CLR_NONE);
         Print("Error opening BUY order : ",GetLastError(), " pipTakeProfit=", pipTakeProfit , " TakeProfitPrice=", TakeProfitPrice, "My price=", myPrice , " Ask=",ASK , " lots ", nbLot); 
      }           
   } 
}

void Sell(double nbLot, int pipStopLoss, int pipTakeProfit, string eaComment, int myMagic)
{
   double StopLossPrice=0,TakeProfitPrice=0,fakeStopLossPrice=0,fakeTakeProfitPrice=0;
   int ticket;
   double myPrice;

   myPrice = BID;
   fakeStopLossPrice =  BID + myFakeStoploss * POINT + SPREAD * POINT;
   fakeTakeProfitPrice = BID - myFakeTakeProfit * POINT - SPREAD * POINT;
   StopLossPrice =  BID + myStoploss * POINT + SPREAD * POINT;
   TakeProfitPrice = BID - myTakeProfit * POINT - SPREAD * POINT;   
   
   if ( currentNbSells < maxOpenSellPosition) {        
      
      Tradecount++;
      ObjectCreate("ORDERSEND-"+Tradecount,OBJ_ARROW,0,Time[0]+Period()*60,myPrice,0,0,0,0);                     
      ObjectSet   ("ORDERSEND-"+Tradecount,OBJPROP_ARROWCODE,242);
      ObjectSet   ("ORDERSEND-"+Tradecount,OBJPROP_COLOR, FireBrick);

      ObjectCreate("SL-"+Tradecount,OBJ_ARROW,0,Time[0]+Period()*60,StopLossPrice,0,0,0,0);                     
      ObjectSet   ("SL-"+Tradecount,OBJPROP_ARROWCODE,251);
      ObjectSet   ("SL-"+Tradecount,OBJPROP_COLOR, FireBrick); 
      
      ObjectCreate("TP-"+Tradecount,OBJ_ARROW,0,Time[0]+Period()*60,TakeProfitPrice,0,0,0,0);                     
      ObjectSet   ("TP-"+Tradecount,OBJPROP_ARROWCODE,252);
      ObjectSet   ("TP-"+Tradecount,OBJPROP_COLOR, DarkGreen);  
            
      ticket = OrderSend(Symbol(),OP_SELL, nbLot,myPrice,Slippage, fakeStopLossPrice, fakeTakeProfitPrice,eaComment, myMagic,0,Red);      
      
      if (ticket > 0 ) {
         currentNbSells++;            
      }else
      {
         //OrderClose(ticket,nbLot,ASK,Slippage,CLR_NONE);
         Print("Error opening Sell order : ",GetLastError(), " pipTakeProfit ", pipTakeProfit , " TakeProfitPrice=" , TakeProfitPrice, " My price=", myPrice , " Bid=",BID , " lots ", nbLot); 
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
  
//+------------------------------------------------------------------+
//|                      DISPLAY FUNCTIONS                          |
//+------------------------------------------------------------------+

  
void displayComment()
{
   
   string myTradeSenstxt;
   
   if (myTradeSens == 0 ){myTradeSenstxt="Buy";} else{myTradeSenstxt= "Sell";}
   
   string txt=StringConcatenate(txt,"======= [ CONFIG : " ,ea_version, " @ " ,Hour(),":",Minute(), " TimeFrame: " , Period(), " ] ======= \n"); 
   
   txt=StringConcatenate( txt, "---- Magic Number     : ", magicNumber1,  "\n");
   txt=StringConcatenate( txt, "---- Stop Loss ", myStoploss, " Take Profit ", myTakeProfit , "\n");
   txt=StringConcatenate( txt, "---- ASK     : ", ASK,  " BID = ", BID , " SPREAD=",SPREAD, "\n");
   
   //txt=StringConcatenate( txt, "---- LAST TRADE SENS : ", myTradeSenstxt , "\n");
   txt=StringConcatenate( txt, "---- Cumul lots perdants : ", cumulPertes , "\n");
   
   txt=StringConcatenate( txt, "---- nbCurrentTrade   : ", nbCurrentTrade  , " on ", maxActiveSymbolAllows, "\n");
   txt=StringConcatenate( txt, "---- currentProfit : ", currentProfit , "\n");
   txt=StringConcatenate( txt, "---- GrossProfit : ", GrossProfit , "\n");
   txt=StringConcatenate( txt, "---- GrossLoss : ", GrossLoss , "\n");
   txt=StringConcatenate( txt, "---- nbTradeGains : ", nbTradeGains , "\n");
   txt=StringConcatenate( txt, "---- nbTradePertes : ", nbTradePertes , "\n");
   
 
   txt=StringConcatenate(txt,"========================================= \n\n"); 
      
       
   Comment(txt);
}  
  
//+------------------------------------------------------------------+