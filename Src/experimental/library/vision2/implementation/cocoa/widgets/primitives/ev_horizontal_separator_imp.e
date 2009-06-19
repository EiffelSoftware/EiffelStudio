note
	description: "EiffelVision horizontal separator, Cocoa implementation"
	author:	"Daniel Furrer"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_HORIZONTAL_SEPARATOR_IMP

inherit
	EV_HORIZONTAL_SEPARATOR_I
		redefine
			interface
		end

	EV_SEPARATOR_IMP
		redefine
			interface
		end

create
	make

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_HORIZONTAL_SEPARATOR note option: stable attribute end;

end -- class EV_HORIZONTAL_SEPARATOR_IMP
