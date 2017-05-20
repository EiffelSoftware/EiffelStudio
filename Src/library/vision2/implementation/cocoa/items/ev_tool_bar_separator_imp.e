note
	description: "Eiffel Vision tool bar separator. Cocoa implementation."
	author: "Daniel Furrer"
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
			interface,
			cocoa_view
		end

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

	EV_NS_VIEW
		redefine
			interface,
			cocoa_view
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
			cocoa_view := box
			set_is_initialized (True)
		end


feature -- Measurement

	minimum_height: INTEGER = 10

	minimum_width: INTEGER = 10

feature -- Statur Report

	is_vertical: BOOLEAN
			-- Are the buttons in parent toolbar arranged vertically?
		do
			if attached {EV_TOOL_BAR_IMP} parent as tool_bar_imp then
				Result := tool_bar_imp.is_vertical
			end
		end

feature -- Implementation

	box: NS_BOX;

	cocoa_view: NS_VIEW;

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_SEPARATOR note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_TOOL_BAR_SEPARATOR_I
