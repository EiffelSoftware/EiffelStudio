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
