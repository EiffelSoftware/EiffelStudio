note
	description: "File URL."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "[
			name=The "file" URI Scheme
		]", "protocol=URI", "src=https://tools.ietf.org/html/rfc8089"

class FILE_URL inherit

	URL
		redefine
			is_hashable
		end

create

	make

feature -- Access

	path: PATH
			-- Path to the file.

	name: FILE_NAME
			-- Name of the file.
		obsolete "Use `path` instead. [2020-05-31]"
		do
			create Result.make_from_string (path.utf_8_name)
		end

	Service: STRING_8 = "file"
			-- Name of the service.

	hash_code: INTEGER = 0
			-- Hash function
			-- (Objects of the current type cannot be hashed, therefore the
			-- hash function is a constant.)

	location: STRING_8
			-- Full URL of resource.
		do
			Result := service.twin
			Result.append (":///")
			Result.append (path.utf_8_name)
		end

feature -- Status report

	is_correct: BOOLEAN
			-- Is URL correct?
		do
			Result := True
		end

	Default_port: INTEGER = 0
			-- Default port number for service (Answer: 0)
			-- (The 'file' service does not use a port.)

	Is_proxy_supported: BOOLEAN = False
			-- Are proxy connections supported? (Answer: no)

	proxy_host_ok (host: STRING_8): BOOLEAN
	 		-- Is host name of proxy correct?
		do
			Result := False
		end

	Is_password_accepted: BOOLEAN = False
			-- Can a password be set? (Answer: no)

	Is_hashable: BOOLEAN = False
			-- Are objects of this type hashable? (Answer: no)

	Has_username: BOOLEAN = False
			-- Can address contain a username? (Answer: no)

feature -- Status setting

	set_username (un: STRING_8)
			-- Set username.
		do
		end

	set_password (pw: STRING_8)
			-- Set password.
		do
		end

feature {NONE} -- Basic operations

	analyze
			-- Analyze URL.
		do
			if address.substring_index ("localhost", 1) = 1 then
				address.keep_head (9) -- The string "localhost" is 9 characters long.
			end
			create path.make_from_string (address)
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
