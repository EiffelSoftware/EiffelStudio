indexing
	description:
		"Action sequences for EV_TREE_NODE."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TREE_NODE_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_TREE_NODE_ACTION_SEQUENCES_I

feature -- Event handling


	select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when selected.
		do
			Result := implementation.select_actions
		ensure
			not_void: Result /= Void
		end


	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when deselected.
		do
			Result := implementation.deselect_actions
		ensure
			not_void: Result /= Void
		end


	expand_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when expanded.
		do
			Result := implementation.expand_actions
		ensure
			not_void: Result /= Void
		end


	collapse_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when collapsed.
		do
			Result := implementation.collapse_actions
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

