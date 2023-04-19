# SPDX-License-Identifier: BSD-3-Clause
# This file is only used if being used as part of an integrated Yosys Build

OBJS += techlibs/discretize/synth_discretize.o

$(eval $(call add_share_file,share/discretize,techlibs/discretize/cells_dffe.v))
$(eval $(call add_share_file,share/discretize,techlibs/discretize/cells_map.v))
$(eval $(call add_share_file,share/discretize,techlibs/discretize/cells_mod.v))
$(eval $(call add_share_file,share/discretize,techlibs/discretize/cells_mux.v))
$(eval $(call add_share_file,share/discretize,techlibs/discretize/discretize.lib))
