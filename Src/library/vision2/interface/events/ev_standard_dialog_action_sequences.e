indexing
	description:
		"Action sequences for EV_STANDARD_DIALOG."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_STANDARD_DIALOG_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_STANDARD_DIALOG_ACTION_SEQUENCES_I

feature -- Event handling


	ok_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when user clicks OK.
			-- Note: This is renamed in some descendents
			-- i.e. in EV_PRINT_DIALOG it is renamed to print_actions
			-- and is performed when the user clicks "print".
		do
			Result := implementation.ok_actions
		ensure
			not_void: Result /= Void
		end


	cancel_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when user cancels.
		do
			Result := implementation.cancel_actions
		ensure
			not_void: Result /= Void
		end

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

