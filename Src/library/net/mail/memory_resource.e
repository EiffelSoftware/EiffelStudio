indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MEMORY_RESOURCE

inherit
	EMAIL_RESOURCE

feature -- Access

	header (h: STRING): STRING is
			-- Retrieve the content of the header 'h'.
		do
			Result:= headers.item (h)
		end


feature -- Basic operations

	send is
		-- Send the resource
		deferred
		end

	receive is
		-- Receive the resource
		deferred
		end

	has_header: BOOLEAN is
		-- Is the memory resource's header valid.
		do
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_send: BOOLEAN is False
		-- Memory resource can not send.

	can_receive: BOOLEAN is False
		-- Memory resource can not receive.

feature -- Access

	headers: HASH_TABLE [STRING, STRING]
		-- All information concerning each headers.

	mail_message: STRING
		-- Email message.

	mail_signature: STRING
		-- Email signature.

end -- class MEMORY_RESOURCE
