indexing
	description: "Memory resource object."
	author: "David s"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MEMORY_RESOURCE

inherit
	EMAIL_RESOURCE

feature -- Basic operations

	send is
		-- Send the resource.
		deferred
		end

	receive is
		-- Receive the resource.
		deferred
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_send: BOOLEAN is False
		-- Can memory resource send?

	can_receive: BOOLEAN is False
		-- Can memory resource receive?

feature -- Access

	mail_message: STRING
		-- Email message

	mail_signature: STRING
		-- Email signature

feature -- Settings

	set_message (s: STRING) is
			-- Set mail_message to 's'.
		do
			mail_message:= s
		end

	set_signature (s: STRING) is
			-- Set mail_signature to 's'.
		do
			mail_signature:= s
		end

end -- class MEMORY_RESOURCE

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

