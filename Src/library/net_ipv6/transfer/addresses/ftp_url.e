indexing
	description:
		"URLs for FTP resources"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FTP_URL inherit

	NETWORK_RESOURCE_URL
		redefine
			make, is_path_correct
		end

create

	make

feature {NONE} -- Initialization

	make (a: STRING) is
	 		-- Create address.
		do
			Precursor (a)
			if username.is_empty then
				username.append ("anonymous")
				password.append ("ftp@")
			end
		end

feature -- Access

	Service: STRING is "ftp"
			-- Name of service (Answer: "ftp")

feature -- Status report

	Default_port: INTEGER is 21
			-- Number of default port for service (Answer: 21)
			
	Is_proxy_supported: BOOLEAN is True
			-- Are proxy connections supported? (Answer: yes)

	Has_username: BOOLEAN is True
			-- Can address contain a username? (Answer: yes)

	is_path_correct (p: STRING): BOOLEAN is
			-- Is path name correct?
		do
			Result := not p.is_empty and then path_charset.contains_string (p)
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




end -- class FTP_URL

