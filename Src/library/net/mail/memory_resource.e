note
	description: "Memory resource object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "David s"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MEMORY_RESOURCE

inherit
	EMAIL_RESOURCE

feature -- Basic operations

	send
		-- Send the resource.
		deferred
		end

	receive
		-- Receive the resource.
		deferred
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_send: BOOLEAN = False
		-- Can memory resource send?

	can_receive: BOOLEAN = False
		-- Can memory resource receive?

feature -- Access

	mail_message: READABLE_STRING_8
		-- Email message

	mail_signature: READABLE_STRING_8
		-- Email signature

feature -- Settings

	set_message (s: READABLE_STRING_8)
			-- Set mail_message to 's'.
		do
			mail_message:= s
		end

	set_signature (s: READABLE_STRING_8)
			-- Set mail_signature to 's'.
		do
			mail_signature:= s
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
