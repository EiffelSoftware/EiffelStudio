indexing
	description:
		"EiffelVision horizontal separator, Cocoa implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
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

	interface: EV_HORIZONTAL_SEPARATOR;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"

end -- class EV_HORIZONTAL_SEPARATOR_IMP

