```{toctree}
:hidden:

build
tutorial
yosys_passes/index
scripts

Source Code <https://github.com/lethalbit/discretize/>

```
# discretize

discretize is a set of two [Yosys] plugins; [`synth_discretize`], and [`write_kicad`], and a set of [utility scripts](./scripts.md) for synthesizing an HDL design into a netlist of discrete [MOSFET]s and generating a [KiCad] netlist and schematic for the design.




## License

Discretize is licensed under the [BSD-3-Clause](https://spdx.org/licenses/BSD-3-Clause.html), the full text of which can be found in the [LICENSE](LICENSE) file.


[yosys]: https://github.com/YosysHQ/yosys
[kicad]: https://www.kicad.org/

[`synth_discretize`]: ./synth_discretize.md
[`write_kicad`]: ./write_kicad.md
[MOSFET]: https://en.wikipedia.org/wiki/MOSFET
