indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_AGGREGATE_BOX_IMP

inherit
	EV_AGGREGATE_BOX_I
		--rename
		--	interface as ev_a_box_interface
		redefine
			interface
		--select
			--ev_a_box_interface
			--interface
		end

	EV_HORIZONTAL_BOX_IMP
		--rename
		--	interface as ev_h_box_interface
		undefine
			parent,
			screen_x,
			screen_y
		redefine
			interface
		end
create
	make


feature --

	real_parent: EV_AGGREGATE_WIDGET_IMP --is
			-- Contains `Current'.
--		do
--			Result ?= parent_imp.cell
--		end

	set_real_parent (par: EV_AGGREGATE_WIDGET_IMP) is
		do
			real_parent := par
		end

	interface: EV_AGGREGATE_BOX

end -- class EV_AGGREGATE_BOX_IMP
