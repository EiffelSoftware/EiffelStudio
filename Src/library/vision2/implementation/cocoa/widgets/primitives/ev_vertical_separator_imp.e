indexing
	description:
		"EiffelVision vertical separator, Cooca implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_VERTICAL_SEPARATOR_IMP

inherit
	EV_VERTICAL_SEPARATOR_I
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

	interface: EV_VERTICAL_SEPARATOR;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"

end -- class EV_VERTICAL_SEPARATOR_IMP

