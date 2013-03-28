//+------------------------------------------------------------------+
//|                                                LJ_SYNERGY_ID.mq4 |
//|                       Copyright ?2007, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright ?2007, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_separate_window
#property indicator_maximum 2
#property indicator_minimum 0

#property indicator_buffers 3
#property indicator_color1 Lime
#property indicator_width1 1
#property indicator_color2 Red
#property indicator_width2 1
#property indicator_color3 Gray
#property indicator_width3 1

extern int count = 1000;
extern int bbwperiod = 20;
extern double bbwdev = 20000.0;
extern double deadzone = 1;
extern double hotzone = 100;

double up[];
double down[];
double side[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators

      SetIndexBuffer(0,up);
      SetIndexStyle(0, DRAW_ARROW);
      SetIndexArrow(0, 233);
      SetIndexEmptyValue(0,0.0);
      
      SetIndexBuffer(1,down);
      SetIndexStyle(1, DRAW_ARROW);
      SetIndexArrow(1, 234);
      SetIndexEmptyValue(1,0.0);
      
      SetIndexBuffer(2,side);
      SetIndexStyle(2, DRAW_ARROW);
      SetIndexArrow(2, 251);
      SetIndexEmptyValue(2,0.0);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
      double sigup = 0;
      double sigdown = 0;
  //    double sigup1 = 0;
  //    double sigdown1 = 0;
      
  //    double nonebbwmom = 0.0;
      
      for (int i = 0; i< count; i++){
         
         sigup   = iCustom( NULL, 0, "LJ_SIG", count, 0, i );
         sigdown = iCustom( NULL, 0, "LJ_SIG", count, 1, i );
   //      sigup1   = iCustom( NULL, 0, "LJ_SIG", count, 0, i + 1 );
   //      sigdown1 = iCustom( NULL, 0, "LJ_SIG", count, 1, i + 1 );
         
   //      nonebbwmom = iCustom( NULL, 0, "LJ_BBW_Mom_SIG", count, bbwperiod, bbwdev, deadzone, hotzone, 1, i );
         
         if ( sigup > 0 ){
         
            side[i] = 0;
            down[i] = 0;
            up[i] = 1;
            
         }
         
         if ( sigdown > 0 ){
         
            up[i]=0;
            side[i]=0;
            down[i] = 1;         
         }
         
         if ( sigup <= 0 && sigdown <= 0 ){
            
            up[i] = 0;
            down[i] = 0;
            side[i] = 1;
            
         }
      
      }   
      return(0);
  }
//+------------------------------------------------------------------+