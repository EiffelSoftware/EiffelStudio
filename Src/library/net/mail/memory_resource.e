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

