indexing
	description: "This class is ancestor of RADIO_BOX_WINDOWS and CHECK_BOX_WINDOWS"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	BOX_WINDOWS

inherit

	ROW_COLUMN_WINDOWS

feature {TOGGLE_B_WINDOWS} -- Element change

	add_toggle (a_toggle: TOGGLE_B_WINDOWS) is
			-- Add a toggle
		local
			c: CURSOR
		do
			c := toggle_list.cursor
			toggle_list.extend (a_toggle)
			toggle_list.go_to (c)
		end

	remove_toggle (a_toggle: TOGGLE_B_WINDOWS) is
			-- Remove a toggle from the list
		require
			toggle_present: toggle_list.has (a_toggle)
		do
			from
				toggle_list.start
			variant
				toggle_list.count - toggle_list.index
			until
				toggle_list.after
			loop
				if toggle_list.item = a_toggle then
					toggle_list.remove
				else
					toggle_list.forth
				end
			end
		ensure
			removed: toggle_list.count = old toggle_list.count - 1
		end

feature {TOGGLE_B_WINDOWS} -- Status setting

	set_index_on_checked_toggle (a_toggle: TOGGLE_B_WINDOWS) is
		require
			toggle_present: toggle_list.has (a_toggle)
		do
			if not toggle_list.off then
				release_actions.execute (toggle_list.item, Void)
			end
			toggle_list.start
			toggle_list.search (a_toggle)
		ensure
			found: not toggle_list.off
		end

	number_of_toggles: INTEGER is
			-- Number of toggles in the box
		do
			Result := toggle_list.count
		end

	toggle_list: LINKED_LIST [TOGGLE_B_WINDOWS]
			-- List of the toggles in the box

end -- class BOX_WINDOWS



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
