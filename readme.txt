This little project shows how to build a source synchronous DDR interface with a 5 to 2 multiplexor.

The plan is to use the OSERDES2E logic of the Virtex-7 in DDR mode to make the output data and DDR clock.

The 5:2 ration is handled by going 5:20:2. That is, demultiplexin the five channels by four to get twenty then running the OSERDES in 10:1 mode to get back to 2.

Wish me luck.

