indexing
	description:
		"Action sequences for EV_COMBO_BOX_I."
	keywords: "event, action, sequence"
	date: "$Date"
	revision: "$Revision"

deferred class
	 EV_COMBO_BOX_ACTION_SEQUENCES_I


feature -- Event handling

	drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when drop down list is displayed.
		do
			if drop_down_actions_internal = Void then
				drop_down_actions_internal :=
					 create_drop_down_actions
			end
			Result := drop_down_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		deferred
		end

	drop_down_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `drop_down_actions'.

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

