indexing
	description: "Objects that handle the sending of data"
	author: "david"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SENDING_PROTOCOL

inherit
	EMAIL_PROTOCOL

feature -- Basic operations

	send_mail is
		-- Send resource.
		require
			connection_exists: is_connected
			connection_initiated: is_initiated
			valid_headers: memory_resource.headers.has (H_from) and then memory_resource.headers.has (H_To)
		deferred
		end

feature -- Implemantation (EMAIL_RESOURCE)

	can_send: BOOLEAN is True
		--Can a sending protocol send?

feature -- Access

	memory_resource: MEMORY_RESOURCE
		-- Memory resource to be send

end -- class SENDING_PROTOCOL


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

