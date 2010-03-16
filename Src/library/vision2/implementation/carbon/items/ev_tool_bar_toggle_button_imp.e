note
	description:
		"EiffelVision toggle tool bar, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			make
		end

create
	make

feature -- Initialization

	make (an_interface: like interface)
			-- Create a Carbon toggle button.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_bottom (100)
			rect.set_right (100)
			ret := create_bevel_button_control_external ( null, rect.item,
				null, -- text
				{CONTROLDEFINITIONS_ANON_ENUMS}.kControlBevelButtonLargeBevel, -- size/thickness
				{CONTROLDEFINITIONS_ANON_ENUMS}.kControlBehaviorToggles, -- the behaviour: we want a toggle-button
				null, 0, 0, 0, $ptr )
			set_c_object ( ptr )

			set_vertical_button_style

		end

feature -- Status setting

	disable_select
			-- Unselect `Current'.
		do
			if is_selected then

			end
		end

	enable_select
			-- Select `Current'.
		do
			if not is_selected then

			end
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected.
		do

		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_TOGGLE_BUTTON;

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




end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

