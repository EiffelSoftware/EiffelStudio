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
