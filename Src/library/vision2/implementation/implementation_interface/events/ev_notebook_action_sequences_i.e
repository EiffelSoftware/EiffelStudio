indexing
	description:
		"Action sequences for EV_NOTEBOOK_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_NOTEBOOK_ACTION_SEQUENCES_I


feature -- Event handling

	selection_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `selected_item' changes.
		do
			if selection_actions_internal = Void then
				selection_actions_internal :=
					 create_selection_actions
			end
			Result := selection_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_selection_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a selection action sequence.
		deferred
		end

	selection_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `selection_actions'.

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

