indexing
	description:
		"Action sequences for EV_TREE_NODE_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TREE_NODE_ACTION_SEQUENCES_I


feature -- Event handling

	select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when selected.
		do
			if select_actions_internal = Void then
				select_actions_internal :=
					 create_select_actions
			end
			Result := select_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
		deferred
		end

	select_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `select_actions'.


feature -- Event handling

	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when deselected.
		do
			if deselect_actions_internal = Void then
				deselect_actions_internal :=
					 create_deselect_actions
			end
			Result := deselect_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_deselect_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a deselect action sequence.
		deferred
		end

	deselect_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `deselect_actions'.


feature -- Event handling

	expand_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when expanded.
		do
			if expand_actions_internal = Void then
				expand_actions_internal :=
					 create_expand_actions
			end
			Result := expand_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_expand_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a expand action sequence.
		deferred
		end

	expand_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `expand_actions'.


feature -- Event handling

	collapse_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when collapsed.
		do
			if collapse_actions_internal = Void then
				collapse_actions_internal :=
					 create_collapse_actions
			end
			Result := collapse_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_collapse_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a collapse action sequence.
		deferred
		end

	collapse_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `collapse_actions'.

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

