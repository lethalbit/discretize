# discretize

> [!WARNING]
> This is still in the early alpha stages, the output logic, netlist, and
> KiCad files may be sub-optimal, or require an obscene number of devices.

discretize is a set of two [Yosys] plugins; [`synth_discretize`], and [`write_kicad`], and a set of [utility scripts](./contrib/) for synthesizing an HDL design into a netlist of discrete [MOSFET]s and generating a [KiCad] netlist and schematic for the design.


## How It Works

TODO


## Usage

To convert an HDL design into it's discrete representation [`synth_discretize`] is used like any other [Yosys] pass to apply technology mapping and optimization onto the design, converting it to an equivalent design made out of [MOSFET]s

For example, the following yosys script will synthesize the [`counter.v`](./tests/counter.v) file
into a discrete netlist, and then dump the statistics and generated module.

```
plugin -i ./build/src/techlib/synth_discretize.so
read_verilog ./tests/counter.v
synth_discretize -techlib ./src/techlib
tee -o counter.stat.json stat -json
write_verilog -noexpr counter.discrete.v
```

You can run that like `$ yosys -s counter.ys`, and you should two files `counter.stats.json` and `counter.discrete.v`.

The first file, `counter.stats.json` describes the design statistics, in the case of the example above it would be something like:

```json
"design": {
  "num_wires":         826,
  "num_wire_bits":     2066,
  "num_pub_wires":     5,
  "num_pub_wire_bits": 19,
  "num_memories":      0,
  "num_memory_bits":   0,
  "num_processes":     0,
  "num_cells":         478,
  "num_cells_by_type": {
      "$_SDFF_PN0_": 8,
      "GND": 1,
      "NFET": 246,
      "PFET": 222,
      "VCC": 1
  }
}
```

Notice two cells called `GND` and `VCC` those are added to ensure that constant highs and lows are tied properly, in a fully implemented design, those would be a ground pour and a power pour on the board.

The next file, `counter.discrete.v` contains the dumped verilog module with all of the logic broken into wires and instances of `PFET`'s or `NFET`s.


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


[yosys]: https://github.com/YosysHQ/yosys
[kicad]: https://www.kicad.org/

[`synth_discretize`]: ./src/techlib
[`write_kicad`]: ./src/backend
[MOSFET]: https://en.wikipedia.org/wiki/MOSFET
