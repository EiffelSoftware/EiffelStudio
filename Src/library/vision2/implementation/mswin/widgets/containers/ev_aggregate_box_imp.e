indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_AGGREGATE_BOX_IMP

inherit
	EV_AGGREGATE_BOX_I
		redefine
			interface
		end

	EV_HORIZONTAL_BOX_IMP
		undefine
			parent,
			screen_x,
			screen_y
		redefine
			interface
		end
create
	make

feature {EV_ANY_I} -- Implementation

	real_parent: EV_AGGREGATE_WIDGET_IMP
			-- Contains `Current'.

	set_real_parent (par: EV_AGGREGATE_WIDGET_IMP) is
		do
			real_parent := par	
		end

	interface: EV_AGGREGATE_BOX

end -- class EV_AGGREGATE_BOX_IMP
