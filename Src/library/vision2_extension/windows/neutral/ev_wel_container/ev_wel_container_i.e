indexing
	description: "Implementation interface of EV_WEL_CONTAINER."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WEL_CONTAINER_I
	
inherit
	EV_CELL_I
		rename
			replace as cell_replace,
			item as cell_item
		end

feature -- Access

	implementation_window: WEL_WINDOW is
			-- Window containing `item'.
		deferred
		end
		
	item: WEL_WINDOW is
			-- `Result' is WEL_WINDOW contained in `Current'.
		deferred
		end

feature -- Status setting
		
	replace (a_window: WEL_WINDOW) is
			-- Replace `item' with `a_window'.
		deferred
		end

feature -- Event handling

	wel_message_actions: EV_WEL_MESSAGE_ACTION_SEQUENCE is
			-- Actions to be performed when a message is sent
			-- by Windows, to implementation of `Current'.
		do
			if wel_message_actions_internal = Void then
				create wel_message_actions_internal
			end
			Result := wel_message_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	wel_message_actions_internal: EV_WEL_MESSAGE_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_motion_actions'.
		

end -- class EV_WEL_CONTAINER_I

--|----------------------------------------------------------------
--| EiffelVision2 Extension: library of reusable components for ISE Eiffel.
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

