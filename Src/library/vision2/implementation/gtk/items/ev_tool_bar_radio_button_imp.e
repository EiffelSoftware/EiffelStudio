indexing
	description:
		" EiffelVision tool-bar radio button. implementation%
		% interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			parent_imp
		end

	EV_TOOL_BAR_TOGGLE_BUTTON_IMP
		redefine
			parent_imp,
			make
		end

create
	make

feature -- Initialization

	make is
		-- Create the tool-bar radio button
		local
			null: POINTER
		do
			widget := gtk_radio_button_new (null)
			gtk_object_ref (widget)
			initialize
		end

feature -- Status report

	is_peer (peer: EV_TOOL_BAR_RADIO_BUTTON): BOOLEAN is
			-- Is this item in same group as peer.
		local
			peer_imp: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			peer_imp ?= peer.implementation

			Result := (group_pointer = peer_imp.group_pointer)
		end

	parent_imp: EV_TOOL_BAR_IMP

feature -- Status Setting

	set_peer (peer_a: EV_TOOL_BAR_RADIO_BUTTON) is
			-- Put in same group as peer.
		local
			peer_a_imp: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			peer_a_imp ?= peer_a.implementation
			if peer_a_imp.group_pointer /= default_pointer then
				group_pointer := peer_a_imp.group_pointer
				gtk_radio_button_set_group (widget, group_pointer)
			else
				if group_pointer = default_pointer then
					group_pointer := gtk_radio_button_group (widget)
					peer_a_imp.set_pointer(group_pointer)
					gtk_radio_button_set_group (widget, group_pointer)
					gtk_radio_button_set_group (peer_a_imp.widget, peer_a_imp.group_pointer)
				else
					peer_a_imp.set_pointer(group_pointer)
					gtk_radio_button_set_group (peer_a_imp.widget, peer_a_imp.group_pointer)
				end
			end
		end

feature -- Implementation

	set_pointer (pointer: POINTER) is
		do
			group_pointer := pointer
		end

	group_pointer: POINTER
		-- pointer used to denote which group
		-- radio button is in.

end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
