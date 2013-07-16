//+------------------------------------------------------------------+
//|                                                     MA Cross.mq4 |
//|                                       Copyright 2013, Eugene Sia |
//|                                           http://eugenesia.co.uk |
//+------------------------------------------------------------------+

/**
 * This is a simple Metatrader 4 Expert Advisor I made to revise my
 * MQL4, after a long hiatus. Hoping to re-explore automated forex
 * trading!
 *
 * This EA trades based on a moving average crossovers, a common 
 * breakout strategy. When the short MA crosses the long MA, enter a
 * trade.
 */

#property copyright "Copyright 2013, Eugene Sia"
#property link      "http://eugenesia.co.uk"

//--- Constant definitions

// Prefix a unique identifier e.g. MACROSS so we don't conflict with
// other predefined constants.

// This defines the magic number for this EA. A magic number can be 
// assigned to an order, so that orders opened by this EA have this magic 
// number. This is how we distinguish between orders opened by this EA, 
// and those opened by the user or other EAs.
// Ref: http://articles.mql4.com/145
#define MACROSS_MAGIC_NUM 20130715
#define MACROSS_OPEN_BUY_SIGNAL 1
#define MACROSS_OPEN_SELL_SIGNAL -1
#define MACROSS_NO_SIGNAL 0

//--- input parameters

// extern keyword defines parameters that can be set by the user in the
// "Expert properties" dialog.
extern int       ShortMaPeriod = 10;
extern int       LongMaPeriod  = 50;

// These are in fractional pips, which are 0.1 of a pip.
extern int       StopLoss      = 500;
extern int       TakeProfit    = 1600;

// Number of lots for each trade.
extern double    Lots          = 1;

/**
 * Get moving average values for the most recent price points.
 * 
 * Params:
 * maPeriod: period of the MA.
 * numValues: Number of values to insert into the returned array.
 * ma: returned array of MA values, with ma[0] being the value for the
 *    current price, ma[1] the value for the previous bar's price, etc.
 *
 */
void MaRecentValues(double& ma[], int maPeriod, int numValues = 3)
  {
   // i is the index of the price array to calculate the MA value for.
   // e.g. i=0 is the current price, i=1 is the previous bar's price.
   for (int i=0; i < numValues; i++)
     {
      ma[i] = iMA(NULL,0,maPeriod,0,MODE_SMA,PRICE_CLOSE,i);
     }
  }


/**
 * Check if we should open a trade.
 *
 * Returns: +1 to open a buy order, -1 to open a sell order, 0 for no action.
 */
int OpenSignal()
  {
   int signal = MACROSS_NO_SIGNAL;

   // Execute only on the first tick of a new bar, to avoid repeatedly
   // opening orders when an open condition is satisfied.
   if (Volume[0] > 1) return(0);
   
   //---- get Moving Average values

   double shortMa[3];
   MaRecentValues(shortMa, ShortMaPeriod, 3);

   double longMa[3];
   MaRecentValues(longMa, LongMaPeriod, 3);
   
   //---- buy conditions
   if (shortMa[2] < longMa[2]
      && shortMa[1] > longMa[1])
     {
      signal = MACROSS_OPEN_BUY_SIGNAL;
     }

   //---- sell conditions
   if (shortMa[2] > longMa[2]
      && shortMa[1] < longMa[1])
     {
      signal = MACROSS_OPEN_SELL_SIGNAL;
     }

   //----
   return(signal);
  }



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
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
//----
   int signal = OpenSignal();

   // Set slippage to a large enough number to avoid error 138 - quote
   // outdated.
   int slippage = 30;
   
   if (signal == MACROSS_OPEN_BUY_SIGNAL)
     {
      Print("Buy signal");
      OrderSend(Symbol(),OP_BUY,Lots,Bid,slippage,
         Bid-StopLoss*Point, // Stop loss price.
         Bid+TakeProfit*Point, // Take profit price.
         NULL,MACROSS_MAGIC_NUM,0,Green);
     }

   else if (signal == MACROSS_OPEN_SELL_SIGNAL)
     {
      Print("Sell signal");
      OrderSend(Symbol(),OP_SELL,Lots,Ask,slippage,
         Ask+StopLoss*Point,  // Stop loss price.
         Ask-TakeProfit*Point, // Take profit price.
         NULL,MACROSS_MAGIC_NUM,0,Red);
     }
     
//----
   return(0);
  }
//+------------------------------------------------------------------+