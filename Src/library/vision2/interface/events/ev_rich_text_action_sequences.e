indexing
	description:
		"Action sequences for EV_RICH_TEXT."
	keywords: "event, action, sequence"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	 EV_RICH_TEXT_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_RICH_TEXT_ACTION_SEQUENCES_I

feature -- Event handling


	caret_move_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Actions to be performed when caret position changes.
		do
			Result := implementation.caret_move_actions
		ensure
			not_void: Result /= Void
		end
		
	selection_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when selection changes.
		do
			Result := implementation.selection_change_actions
		ensure
			not_void: Result /= Void
		end
		
	file_access_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Actions to be performed while loading or saving.
			-- Event data is percentage of file written (0-100).
		do
			Result := implementation.file_access_actions
		ensure
			not_void: Result /= Void
		end

end

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

