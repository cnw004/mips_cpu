# Pipelined Mips CPU

*members:*
 - Cole Whitley
 - Jason Corriveau
 - Sienna Mosher
 - Andrew Capuano

 ## Directory Structure
 - `src/`: Holds all of our module files that need to be included for the processor to be compiled
 - `docs`: Holds team contract and work plan as well as any supporting documentation not found as comments in the modules.

## Compilation
To run and compile, navigate to the main directory and run `./run`. This compiles our processor to a file called `output` and then runs `output`.

## Design Features
Our approach to this problem was fairly unique. Instead of wiring each individual module together into our single, large system we decided to make mid-level modules for each of the individual stages. This allowed us to abstract some of the complexity of wiring everything together. We have one module each for fetch, decode, execute, memory, and writeback. Inside each of those modules are other modules that are internal to those blocks. This made it so we had far fewer modules to handle in our pipeline_overview.v file. There are a few more than just these five modules because of the way that we decided to organize each of the mid-level modules.

In making some of our larger modules (with many inputs and outputs) we decided to name them in1, in2, ... and out1, out2, ... In hindsight, this was a poor design decision. However, at the time we found it easier to look at the picture and just count from top to bottom when labeling them and then include very descriptive javaDoc style comments are the top of each file explaining the inputs and outputs.

In pipeline_overview.v we used a naming convention that made the file incredibly readable. Each wire declared is named in the following way: `<STAGE>_in_<REFERENCE_VAR>`. For example, the fetch stage has an input to tell if the instruction is a jump or not called `fetch_in_jump`. This convention makes this file incredibly readable while also making it clear which input connects to which output.

## Testing Methodology

### Test Benches
We utilized small test benches to test some of our individual modules. This allowed us to ensure that each individual module was working properly before we stitched them all together into one large system. These tests were written mainly for modules that we had to alter or modules that we found to be more error prone than others. Some modules were taken from our last project and had already been tested, so individual test benches were not written for these.

### GTKWave
GTKWave was heavily leveraged in the testing of our system. After putting all of the pieces together, we decided to run add_test in order to test our system. We began by running add_test and following the instructions through our pipeline. By analyzing GTKWave we were able to see where and when instructions went amok. This allowed us to fix our processor and get it to a working state before adding in additional functionality for helloworld and other programs.
