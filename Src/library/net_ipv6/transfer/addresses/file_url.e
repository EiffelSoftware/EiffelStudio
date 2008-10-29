indexing
	description:
		"File URL"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FILE_URL inherit

	URL
		redefine
			is_hashable
		end

create

	make

feature -- Access

	name: FILE_NAME

	Service: STRING is "file"
			-- Name of service

	hash_code: INTEGER is 0
			-- Hash function
			-- (Objects of the current type cannot be hashed, therefore the
			-- hash function is a constant.)

	location: STRING is
			-- Full URL of resource
		do
			Result := service.twin
			Result.append ("://")
			Result.append (name)
		end
			
feature -- Status report

	is_correct: BOOLEAN is
			-- Is URL correct?
		do
			Result := name.is_valid
		end
	 
	Default_port: INTEGER is 0
			-- Default port number for service (Answer: 0)
			-- (The 'file' service does not use a port.)

	Is_proxy_supported: BOOLEAN is False
			-- Are proxy connections supported? (Answer: no)
	 
	proxy_host_ok (host: STRING): BOOLEAN is
	 		-- Is host name of proxy correct?
		do
			Result := False
		end
	
	Is_password_accepted: BOOLEAN is False
			-- Can a password be set? (Answer: no)
	
	Is_hashable: BOOLEAN is False
			-- Are objects of this type hashable? (Answer: no)

	Has_username: BOOLEAN is False
			-- Can address contain a username? (Answer: no)
	 
feature -- Status setting

	set_username (un: STRING) is
			-- Set username.
		do
		end
	 
	set_password (pw: STRING) is
			-- Set password.
		do
		end
	 
feature {NONE} -- Basic operations

	analyze is
			-- Analyze URL.
		do
			if address.substring_index ("localhost", 1) = 1 then
				address.keep_head (9) -- The string "localhost" is 9 characters long.
			end
			create name.make_from_string (address)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class FILE_URL

