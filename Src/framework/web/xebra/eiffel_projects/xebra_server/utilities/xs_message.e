note
	description: "[
			Represents a message that is sent from and to the http server plugin.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_MESSAGE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			length := 0
			flag := False
			string := ""
		ensure
			string_attached: string /= Void
		end

feature -- Access


	length: NATURAL assign set_length
		-- The retrieved length of the message

	flag: BOOLEAN assign set_flag
		-- Determines if there is another fragment coming

	string: STRING
		-- The message

feature -- Constants

	Message_upper_bound: NATURAL = 65536
			-- Upper bound for a message fragment

	Message_default_bound: NATURAL = 32768
			-- Default bound for a message fragment

feature -- Status report

	is_length_valid: BOOLEAN
			-- Checks if the length is between 0 and Message_upper_bound
		do
			Result := (length > 0) and (length <= Message_upper_bound)
		end
feature -- Status setting

	append_string (a_string: READABLE_STRING_8)
			-- Appends a string
		do
			string.append (a_string)
		ensure
			new_length_ok: string.count = old string.count + a_string.count
		end

	set_length (a_length: NATURAL)
			-- Sets length.
		do
			length := a_length
		ensure
			length_set: length ~ a_length
		end

	set_flag (a_flag: BOOLEAN)
			-- Sets flag.
		do
			flag := a_flag
		ensure
			flag_set: flag ~ a_flag
		end

invariant
	string_attached: string /= Void

end
