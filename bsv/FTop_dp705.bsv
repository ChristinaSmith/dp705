// FTop_dp705.bsv - the top level module
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith
import Generator   ::*;
import Checker     ::*;
//import SendV1      ::*;
//import RcvV1       ::*;
import GetPut      ::*;
import Connectable ::*;
import Buffer      ::*;


module mkFTop_dp705 (Empty);

// state instanced here
GeneratorIfc     gen1         <- mkGenerator(True);
GeneratorIfc     gen2         <- mkGenerator(False);
CheckerIfc       chk          <- mkChecker;
BufferIfc        buf1         <- mkBuffer;
//SendV1Ifc        send         <- mkSendV1;
//RcvV1Ifc         rcv          <- mkRcvV1;
Reg#(Bit#(16))  cycleCounter  <- mkReg(0);
//FIFO between send and rcv


// rules here
rule cycleCount;
  cycleCounter <= cycleCounter + 1;
endrule

rule gobble;
  if(cycleCounter==15000)$finish;
endrule

mkConnection(gen1.src, buf1.sink);
mkConnection(buf1.src, chk.sink1);
mkConnection(gen2.src, chk.sink2);

// interfaces provided here

endmodule
