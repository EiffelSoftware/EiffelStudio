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

	header (h: STRING): HEADER is
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

	is_header_valid: BOOLEAN is
		-- Is the memory resource's header valid.
		do
		end

	add_header (head: HEADER; value: STRING) is
		require
			header_exists: valid_header (value)
		do
			headers.put (head, value)
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_send: BOOLEAN is False
		-- Memory resource can not send.

	can_receive: BOOLEAN is False
		-- Memory resource can not receive.

	valid_header (head: STRING): BOOLEAN is
		do
			Result:= (head.is_equal (H_to) or else head.is_equal (H_from) or else
						head.is_equal (H_cc) or else head.is_equal (H_bcc))
		end

feature -- Access

	headers: HASH_TABLE [HEADER, STRING]
		-- All information concerning each headers.

	mail_subject: STRING
		-- Email subject.

	mail_message: STRING
		-- Email message.

	mail_signature: STRING
		-- Email signature.

feature -- Settings

	set_message (s: STRING) is
		do
			mail_message:= s
		end

	set_subject (s: STRING) is
		do
			mail_subject:= s
		end

	set_signature (s: STRING) is
		do
			mail_signature:= s
		end

end -- class MEMORY_RESOURCE
