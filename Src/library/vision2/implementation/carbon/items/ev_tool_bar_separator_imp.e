indexing
	description:
		"Eiffel Vision tool bar separator. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False

	is_dockable: BOOLEAN is False

	make (an_interface: like interface) is
			-- Create the tool bar button.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_SEPARATOR;

indexing
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end -- class EV_TOOL_BAR_SEPARATOR_I

