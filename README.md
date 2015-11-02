# ma-cross-ea

Simple moving average (MA) crossover Expert Advisor (EA) for Metatrader 4, in MQL4.

This EA opens a trade when the short period MA crosses the long period MA. Stop loss and target profit are set according to user-configurable parameters.

This is a simple EA that produces good results on certain currency pairs, during certain time periods.


## Usage

Install Metatrader 4 on Windows or on Mac using PlayOnMac. This EA only works on MetaTrader 4, NOT MetaTrader 5.

Clone this repository in `C:\Program Files\Metatrader 4\Expert Advisors\MQL4\Expert Advisors\Experts` in Windows, or the equivalent on Mac.

    cd "C:\Program Files\Metatrader 4\Expert Advisors\MQL4\Expert Advisors\Experts"
    git clone [repo_url] ma_cross_ea

Open MetaEditor (the part of Metatrader that allows you to create and edit Expert Advisors). In the Navigator panel in the left sidebar, open `MQL4\Experts\ma_cross_ea\MA_Cross.mq4`. Click on "Compile" in the toolbar to compile it.

Open MetaTrader (the trading terminal). In the Navigator panel in the left sidebar, browse to Expert Advisors > ma\_cross\_ea > MA\_Cross. Drag the MA\_Cross icon to the currency you want to do auto-trading with, e.g. "EUR/USD".

A configuration dialog will open where you can configure the EA's parameters such as:
* ShortMaPeriod: Period for the faster MA. This MA will cause the EA to buy or sell when it crosses the slower MA.
* LongMaPeriod: Period for the slower MA.
* StopLoss: Stop loss price from trade entry price, in pips.
* TakeProfit: Take profit price from trade entry price, in pips.
* Lots: Number of lots per trade.


## Backtesting

Backtesting can be done using MetaTrader's "Strategy Tester" function, accessed through main menu View > Strategy Tester .

The testing results for a similar EA, on the EUR/USD currency pair, can be seen here: https://youtu.be/DHFfsjFaIgU


## Disclaimer

I am not responsible for any losses you sustain while using this Expert Advisor. Trade with caution!

