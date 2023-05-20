# discretize

> **Warning** This is still in the early alpha stages, the output logic, netlist, and
> KiCad files may be sub-optimal, or require an obscene number of devices.

This is a toolkit for taking HDL designs and converting them to discrete transistor based designs. It implements a [yosys](https://github.com/YosysHQ/yosys) script to synthesize the design as well as some templates for [KiCad](https://www.kicad.org/) of common components.

## How It Works

TODO


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


## Configuring and Building

The following steps describe how to build discretize, it should be consistent for Linux, macOS, and Windows, but macOS and Windows remain untested.

**NOTE:** The minimum C++ standard to build discretize is C++17.

### Prerequisites

To build discretize, ensure you have the following build time dependencies:
 * git
 * meson
 * ninja
 * g++ >= 11 or clang++ >= 11
 * python >= 3.9
 * yosys >= 0.28


### Configuring

You can build discretize with the default options, all of which can be found in [`meson_options.txt`](meson_options.txt). You can change these by specifying `-D<OPTION_NAME>=<VALUE>` at initial meson invocation time, or with `meson configure` in the build directory post initial configure.

To change the install prefix, which is `/usr/local` by default ensure to pass `--prefix <PREFIX>` when running meson for the first time.

In either case, simply running `meson build` from the root of the repository will be sufficient and place all of the build files in the `build` subdirectory.

### Building

Once you have configured discretize appropriately, to simply build and install simply run the following:

```
$ ninja -C build
$ ninja -C build test # Optional: Run Tests
$ ninja -C build install
```

This will build and install discretize into the default prefix which is `/usr/local`, to change that see the configuration steps above.

### Notes to Package Maintainers

If you are building discretize for inclusion in a distributions package system then ensure to set `DESTDIR` prior to running meson install.

There is also a `bugreport_url` configuration option that is set to this repositories issues tracker by default, it is recommended to change it to your distributions bug tracking page.

## License

Discretize is licensed under the [BSD-3-Clause](https://spdx.org/licenses/BSD-3-Clause.html), the full text of which can be found in the [LICENSE](LICENSE) file.
