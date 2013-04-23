/*
   Generated by EX4-TO-MQ4 decompiler V4.0.224.1 []
   Website: http://purebeam.biz
   E-mail : purebeam@gmail.com
*/
#property copyright "Copyright � 2007, CompassFX, LLC."
#property link      "www.compassfx.com"

#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 DarkGreen
#property indicator_color2 Maroon
#property indicator_color3 DarkGoldenrod

extern int period = 500;

double g_ibuf_100[];
double g_ibuf_104[];
double g_ibuf_108[];
double g_ibuf_112[];
double g_ibuf_116[];

int init() {
   IndicatorBuffers(5);
   SetIndexStyle(0, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(1, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(2, DRAW_LINE, STYLE_DOT, 1);
   SetIndexBuffer(0, g_ibuf_104);
   SetIndexBuffer(1, g_ibuf_100);
   SetIndexBuffer(2, g_ibuf_108);
   SetIndexBuffer(3, g_ibuf_112);
   SetIndexBuffer(4, g_ibuf_116);
   IndicatorShortName("Dynamic S/R | www.compassfx.com");
   SetIndexLabel(0, "Resistance");
   SetIndexLabel(1, "Support");
   SetIndexLabel(2, "S/R_Mean");
   SetIndexDrawBegin(0, 25);
   SetIndexDrawBegin(1, 25);
   SetIndexDrawBegin(2, 25);
   return (0);
}

int start() {
   int l_ind_counted_0 = IndicatorCounted();
   if (Bars <= 25) return (0);
   int li_4 = Bars - l_ind_counted_0;
   if (l_ind_counted_0 > 0) li_4++;
   else {
      g_ibuf_104[li_4] = High[li_4];
      g_ibuf_100[li_4] = Low[li_4];
   }
   for (int li_8 = 0; li_8 < li_4; li_8++) g_ibuf_112[li_8] = (High[iHighest(NULL, 0, MODE_HIGH, period, li_8)] + Low[iLowest(NULL, 0, MODE_LOW, period, li_8)] + Close[li_8]) / 3.0;
   for (li_8 = 0; li_8 < li_4; li_8++) g_ibuf_116[li_8] = iMAOnArray(g_ibuf_112, Bars, 25, 0, MODE_SMA, li_8);
   for (li_8 = li_4 - 1; li_8 >= 0; li_8--) {
      if (g_ibuf_112[li_8 + 1] > g_ibuf_116[li_8 + 1] && g_ibuf_112[li_8] < g_ibuf_116[li_8]) g_ibuf_104[li_8] = High[iHighest(NULL, 0, MODE_HIGH, period, li_8)];
      else g_ibuf_104[li_8] = g_ibuf_104[li_8 + 1];
   }
   for (li_8 = li_4 - 1; li_8 >= 0; li_8--) {
      if (g_ibuf_112[li_8 + 1] < g_ibuf_116[li_8 + 1] && g_ibuf_112[li_8] > g_ibuf_116[li_8]) g_ibuf_100[li_8] = Low[iLowest(NULL, 0, MODE_LOW, period, li_8)];
      else g_ibuf_100[li_8] = g_ibuf_100[li_8 + 1];
   }
   for (li_8 = 0; li_8 < li_4; li_8++) g_ibuf_108[li_8] = NormalizeDouble((g_ibuf_104[li_8] + g_ibuf_100[li_8]) / 2.0, Digits);
   return (0);
}