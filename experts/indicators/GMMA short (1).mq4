/*
   Generated by EX4-TO-MQ4 decompiler V4.0.224.1 []
   Website: http://purebeam.biz
   E-mail : purebeam@gmail.com
*/
#property copyright "Code written by - Matt Trigwell"
#property link      ""

#property indicator_chart_window
#property indicator_buffers 6
#property indicator_color1 ForestGreen
#property indicator_color2 ForestGreen
#property indicator_color3 ForestGreen
#property indicator_color4 ForestGreen
#property indicator_color5 ForestGreen
#property indicator_color6 ForestGreen

double g_ibuf_76[];
double g_ibuf_80[];
double g_ibuf_84[];
double g_ibuf_88[];
double g_ibuf_92[];
double g_ibuf_96[];
double g_ibuf_100[];
double g_ibuf_104[];
double g_ibuf_108[];
double g_ibuf_112[];
double g_ibuf_116[];
double g_ibuf_120[];

int init() {
   SetIndexStyle(0, DRAW_LINE);
   SetIndexBuffer(0, g_ibuf_76);
   SetIndexStyle(1, DRAW_LINE);
   SetIndexBuffer(1, g_ibuf_80);
   SetIndexStyle(2, DRAW_LINE);
   SetIndexBuffer(2, g_ibuf_84);
   SetIndexStyle(3, DRAW_LINE);
   SetIndexBuffer(3, g_ibuf_88);
   SetIndexStyle(4, DRAW_LINE);
   SetIndexBuffer(4, g_ibuf_92);
   SetIndexStyle(5, DRAW_LINE);
   SetIndexBuffer(5, g_ibuf_96);
   SetIndexStyle(6, DRAW_LINE);
   SetIndexBuffer(6, g_ibuf_100);
   SetIndexStyle(7, DRAW_LINE);
   SetIndexBuffer(7, g_ibuf_104);
   SetIndexStyle(8, DRAW_LINE);
   SetIndexBuffer(8, g_ibuf_108);
   SetIndexStyle(9, DRAW_LINE);
   SetIndexBuffer(9, g_ibuf_112);
   SetIndexStyle(10, DRAW_LINE);
   SetIndexBuffer(10, g_ibuf_116);
   SetIndexStyle(11, DRAW_LINE);
   SetIndexBuffer(11, g_ibuf_120);
   return (0);
}

int deinit() {
   return (0);
}

int start() {
   int li_12 = IndicatorCounted();
   if (li_12 < 0) return (-1);
   if (li_12 > 0) li_12--;
   int li_8 = Bars - li_12;
   for (int li_0 = 0; li_0 < li_8; li_0++) {
      g_ibuf_76[li_0] = iMA(NULL, 0, 3, 0, MODE_EMA, PRICE_CLOSE, li_0);
      g_ibuf_80[li_0] = iMA(NULL, 0, 5, 0, MODE_EMA, PRICE_CLOSE, li_0);
      g_ibuf_84[li_0] = iMA(NULL, 0, 8, 0, MODE_EMA, PRICE_CLOSE, li_0);
      g_ibuf_88[li_0] = iMA(NULL, 0, 10, 0, MODE_EMA, PRICE_CLOSE, li_0);
      g_ibuf_92[li_0] = iMA(NULL, 0, 12, 0, MODE_EMA, PRICE_CLOSE, li_0);
      g_ibuf_96[li_0] = iMA(NULL, 0, 15, 0, MODE_EMA, PRICE_CLOSE, li_0);
      g_ibuf_100[li_0] = iMA(NULL, 0, 30, 0, MODE_EMA, PRICE_CLOSE, li_0);
      g_ibuf_104[li_0] = iMA(NULL, 0, 35, 0, MODE_EMA, PRICE_CLOSE, li_0);
      g_ibuf_108[li_0] = iMA(NULL, 0, 40, 0, MODE_EMA, PRICE_CLOSE, li_0);
      g_ibuf_112[li_0] = iMA(NULL, 0, 45, 0, MODE_EMA, PRICE_CLOSE, li_0);
      g_ibuf_116[li_0] = iMA(NULL, 0, 50, 0, MODE_EMA, PRICE_CLOSE, li_0);
      g_ibuf_120[li_0] = iMA(NULL, 0, 60, 0, MODE_EMA, PRICE_CLOSE, li_0);
   }
   return (0);
}
