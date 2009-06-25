note
	description: "Eiffel Vision separator. Cocoa implementation"
	author:	"Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SEPARATOR_IMP

inherit
	EV_SEPARATOR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			make,
			interface,
			set_default_minimum_size
		end

feature {NONE} -- Initialization

	make
			-- Create the separator control.
		local
			box: NS_BOX
		do
			create box.make
			cocoa_item := box
			Precursor {EV_PRIMITIVE_IMP}
			disable_tabable_from
			box.set_box_type ({NS_BOX}.box_separator)
			set_is_initialized (True)
		end

feature -- Layout handling

	set_default_minimum_size
			-- Minimum height/width that the widget may occupy.
		do
			internal_set_minimum_size (1, 1) -- Hardcoded value
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SEPARATOR note option: stable attribute end;

end -- class EV_SEPARATOR_IMP
