indexing
	description:
		"URLs for FTP resources"

	status:	"See note at end of class"
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

end -- class FTP_URL

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

