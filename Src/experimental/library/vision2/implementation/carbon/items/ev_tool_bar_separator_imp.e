note
	description:
		"Eiffel Vision tool bar separator. Implementation interface."
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

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN = False

	is_dockable: BOOLEAN = False

	make (an_interface: like interface)
			-- Create a Carbon Separator .
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_bottom (1)
			rect.set_right (1)

			-- one could try to use create_icon_control_external. just a thought...
			ret := create_separator_control_external (null, rect.item, $ptr)
			set_c_object ( ptr )


		end

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

	layout
			-- Adjust the control to the size of the parent toolbar
		local
			rect: RECT_STRUCT
			ret: INTEGER
		do
			rect := get_bounds
			size_control_external (c_object, rect.right, rect.bottom)
		end

	get_bounds: RECT_STRUCT
			-- Get the bounds for current button
		local
			tool_bar_imp: EV_TOOL_BAR_IMP
			r_width, r_height: INTEGER
		do
			tool_bar_imp ?= item_parent_imp
			if
				tool_bar_imp /= Void
			then

				-- First the bounds get stretched to the size of its parent in one direction
				if is_vertical then
					r_width := tool_bar_imp.get_embedded_width
					r_height := sep_padding
				else
					r_width := sep_padding
					r_height := tool_bar_imp.get_embedded_height
				end
			end

		create Result.make_new_unshared
		Result.set_right (r_width)
		Result.set_bottom (r_height)
	end

	sep_padding: INTEGER = 5;


	interface: EV_TOOL_BAR_SEPARATOR;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TOOL_BAR_SEPARATOR_I

