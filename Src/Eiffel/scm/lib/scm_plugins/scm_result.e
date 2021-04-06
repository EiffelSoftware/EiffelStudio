note
	description: "Summary description for {SCM_RESULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_RESULT

create
	make_success,
	make_failure

feature {NONE} -- Initialization

	make_success
		do
			failed := False
			message := Void
		end

	make_failure
		do
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

	command: detachable READABLE_STRING_32
			-- Optional command information.

	message: detachable IMMUTABLE_STRING_32
			-- Potential message.

feature -- Element change

	set_message (msg: detachable READABLE_STRING_GENERAL)
			-- Set `message' to `msg'.
		do
			if msg = Void then
				message := Void
			else
				create message.make_from_string_general (msg)
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
