indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROTOCOL_RESOURCE

inherit
	EMAIL_RESOURCE

feature -- Basic operations

	initiate_protocol is
			-- initiate the protocol with the server.
		deferred
		ensure
			protocol_initiated: is_initiated
		end

	close_protocol is
			-- Close the protocol.
		require
			is_initiated: is_initiated
		deferred
		ensure
			protocol_not_initiated: not is_initiated
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_be_sent: BOOLEAN is False
		-- Can a protocol resource be send?

	can_be_received: BOOLEAN is False
		-- Can a protocol be received?

end -- class PROTOCOL_RESOURCE

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
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

