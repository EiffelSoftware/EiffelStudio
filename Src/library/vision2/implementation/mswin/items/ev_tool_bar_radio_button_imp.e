indexing
	description: "EiffelVision tool-bar radio button, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			initialize
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

creation
	make

feature {NONE} -- Initialization

	initialize is
			-- Post creation initialization.
		do
			Precursor
			enable_select
		end

feature -- Status report

	is_selected: BOOLEAN

	enable_select is
			-- Select `Current'.
		do
			update_radio_states
			if parent_imp /= Void then
					parent_imp.check_button (id)
			end
		end

	disable_select is
			-- Deselect `Current'
		do
			is_selected := False
			if parent_imp /= Void then
				parent_imp.uncheck_button (id)
			end
		end

feature -- Implementation

	update_radio_states is
			-- Unselect all members of `radio_group' except `Current',
			-- and assign True to `is_selected'.
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					if radio_group.item /= Current then
						radio_group.item.disable_select
					end
					radio_group.forth
				end
				radio_group.go_to (cur)
			end
			is_selected := True
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_RADIO_BUTTON

end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

