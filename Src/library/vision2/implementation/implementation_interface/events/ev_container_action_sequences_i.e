indexing
	description:
		"Action sequences for EV_CONTAINER_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_CONTAINER_ACTION_SEQUENCES_I


feature -- Event handling

	new_item_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when a new item is added.
		do
			if new_item_actions_internal = Void then
				new_item_actions_internal :=
					 create_new_item_actions
			end
			Result := new_item_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_new_item_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- Create a new_item action sequence.
		deferred
		end

	new_item_actions_internal: EV_NEW_ITEM_ACTION_SEQUENCE
			-- Implementation of once per object `new_item_actions'.

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

