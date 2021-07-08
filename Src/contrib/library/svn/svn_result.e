note
	description: "Summary description for {SVN_RESULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_RESULT

create
	make_success,
	make_failure

feature {NONE} -- Initialization

	make_success (cmd: READABLE_STRING_GENERAL)
		do
			command := cmd
			failed := False
			message := Void
		end

	make_failure (cmd: READABLE_STRING_GENERAL)
		do
			command := cmd
			failed := True
			message := Void
		end

feature -- Status report

	succeed: BOOLEAN
			-- Svn command succeed?
		do
			Result := not failed
		end

	failed: BOOLEAN
			-- Svn command failed?

	command: READABLE_STRING_32
			-- Optional command information.

	message: detachable IMMUTABLE_STRING_32
			-- Potential message.

feature -- Element change

	set_message (msg: detachable READABLE_STRING_GENERAL)
			-- Set `message' to `msg'.
		local
			utf: UTF_CONVERTER
		do
			if msg = Void then
				message := Void
			elseif attached {READABLE_STRING_8} msg as s then
				message := utf.utf_8_string_8_to_string_32 (s)
			else
				create message.make_from_string_general (msg)
			end
		end

	set_unicode_message (msg: detachable READABLE_STRING_32)
		do
			if msg = Void then
				message := Void
			else
				create message.make_from_string (msg)
			end
		end

	set_command (cmd: detachable READABLE_STRING_GENERAL)
			-- Set `command' to `cmd'.
		do
			if cmd = Void then
				command := Void
			else
				create {IMMUTABLE_STRING_32} command.make_from_string_general (cmd)
			end
		end

;note
	copyright: "Copyright (c) 2003-2015, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
