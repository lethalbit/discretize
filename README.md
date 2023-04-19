# discretize

> **Warning** This is still in the early alpha stages, the output logic, netlist, and
> KiCad files may be sub-optimal, or require an obscene number of devices.

This is a toolkit for taking HDL designs and converting them to discrete transistor based designs. It implements a [yosys](https://github.com/YosysHQ/yosys) script to synthesize the design as well as some templates for [KiCad](https://www.kicad.org/) of common components.

## How It Works

TODO

## Building

There are two ways to build `synth_discretize`, the in-tree and out-of-tree way.
### Out Of Tree

To build the native Yosys plugin, you need to have `yosys-config` in your path, a C++ compiler, python, and [nox](https://nox.thea.codes/) installed.

To build the native module, simply run `nox -s build`, and it will build the `synth_discretize` and put it into the `build` directory.

### In Tree

To build Yosys in-tree, first ensure you have [everything you need](https://github.com/YosysHQ/yosys#building-from-source) to build Yosys from source. Then you can simply run `nox -s build -- --in-tree` and it will build it for you, the results will be in the `build/bin` directory.

To do so manually, you can follow the example below:

```
$ git clone https://github.com/YosysHQ/yosys.git
$ cd yosys
$ ln -sv /path/to/discretize/techlib $(pwd)/techlibs/discretize
$ make config-gcc
$ make -j $(nproc)
$ make DESTDIR="$(pwd)/build" install
```

## Usage

Using the pass is just like any other Yosys pass, you simply load up your design and then call `synth_discretize` with the appropriate options.

For example, to synthesize the counter test you would do the following:

```
yosys> read_verilog ./tests/counter.v
1. Executing Verilog-2005 frontend: ./tests/counter.v
Parsing Verilog input from `./tests/counter.v' to AST representation.
Generating RTLIL representation for module `\counter'.
Successfully finished Verilog frontend.

yosys> synth_discretize

...

2.17. Printing statistics.

=== counter ===

   Number of wires:                826
   Number of wire bits:           2066
   Number of public wires:           5
   Number of public wire bits:      19
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                478
     $_SDFF_PN0_                     8
     GND                             1
     NFET                          246
     PFET                          222
     VCC                             1

```

you can then use the `write_verilog -noexpr` command to dump the finalized verilog module or `write_json` to dump the netlist for use in the rest of the tools.

## License

Discretize is licensed under the [BSD-3-Clause](https://spdx.org/licenses/BSD-3-Clause.html), the full text of which can be found in the [LICENSE](LICENSE) file.
