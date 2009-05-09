note
	description:
		"Eiffel Vision tool bar separator. Cocoa implementation."
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

	EV_PND_DEFERRED_ITEM
		undefine
			create_drop_actions
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	is_dockable: BOOLEAN = False

	make (an_interface: like interface)
			-- Create a separator .
		do
			base_make (an_interface)
			create box.new
			box.set_box_type ({NS_BOX}.box_separator)
			cocoa_item := box
		end

	initialize
			--
		do

		end


feature -- Measurement

	minimum_height: INTEGER = 10

	minimum_width: INTEGER = 10

feature -- Statur Report

	is_vertical: BOOLEAN
			-- Are the buttons in parent toolbar arranged vertically?
		local
			tool_bar_imp: EV_TOOL_BAR_IMP
		do
			tool_bar_imp ?= parent
			if tool_bar_imp /= Void then
				Result := tool_bar_imp.is_vertical
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_SEPARATOR;

	box: NS_BOX;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TOOL_BAR_SEPARATOR_I

