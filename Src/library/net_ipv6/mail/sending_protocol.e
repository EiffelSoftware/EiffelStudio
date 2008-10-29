indexing
	description: "Objects that handle the sending of data"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			valid_headers: memory_resource.headers.has (H_from)
				and then memory_resource.headers.has (H_to)
		deferred
		end

feature -- Implemantation (EMAIL_RESOURCE)

	can_send: BOOLEAN is True
		--Can a sending protocol send?

feature -- Access

	memory_resource: MEMORY_RESOURCE;
		-- Memory resource to be send

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SENDING_PROTOCOL

