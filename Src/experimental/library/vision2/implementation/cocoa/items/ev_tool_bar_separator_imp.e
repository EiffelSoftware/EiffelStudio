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

	EV_NS_VIEW
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	is_dockable: BOOLEAN = False

	make
			--
		do
			create box.make
			box.set_box_type ({NS_BOX}.box_separator)
			cocoa_item := box
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

	interface: detachable EV_TOOL_BAR_SEPARATOR note option: stable attribute end;

	box: NS_BOX;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TOOL_BAR_SEPARATOR_I

