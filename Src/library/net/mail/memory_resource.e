indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MEMORY_RESOURCE

inherit
	EMAIL_RESOURCE

feature -- Basic operations

	send is
		-- Send the resource
		deferred
		end

	receive is
		-- Receive the resource
		deferred
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_send: BOOLEAN is False
		-- Memory resource can not send.

	can_receive: BOOLEAN is False
		-- Memory resource can not receive.

feature -- Access

	mail_message: STRING
		-- Email message.

	mail_signature: STRING
		-- Email signature.

feature -- Settings

	set_message (s: STRING) is
		do
			mail_message:= s
		end

	set_signature (s: STRING) is
		do
			mail_signature:= s
		end

end -- class MEMORY_RESOURCE
