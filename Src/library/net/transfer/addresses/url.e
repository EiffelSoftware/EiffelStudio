indexing
	description:
		"Unified resource locators"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class URL inherit

	HASHABLE

feature {NONE} -- Initialization

	make (a: STRING) is
			-- Create URL with address `a'.
		require
			address_specified: a /= Void and then not a.empty
		do
			address := a
			port := default_port
			analyze
		ensure
			address_set: address = a
		end
	
feature -- Access

	service: STRING is
			-- Name of service
		deferred
		end

	port: INTEGER
			-- Port used by service
	
	default_port: INTEGER is
			-- Default port number for service
		deferred
		end
	
	proxy_host: STRING
			-- Host name of proxy

	proxy_port: INTEGER
			-- Port of proxy
			
	location: STRING is
			-- Full URL of resource
		deferred
		end
			
feature -- Status report

	is_correct: BOOLEAN is
			-- Is URL correct?
		deferred
		end
	 
	 is_proxy_supported: BOOLEAN is
			-- Are proxy connections supported?
		deferred
		end
	 
	 proxy_host_ok (host: STRING): BOOLEAN is
	 		-- Is host name of proxy correct?
		require
			proxy_supported: is_proxy_supported
		deferred
		end
	
	 is_proxy_used: BOOLEAN is
	 		-- Is a proxy used?
		do
			Result := is_proxy_supported and then proxy_port > 0 and then
				proxy_host_ok (proxy_host)
		end

	is_password_accepted: BOOLEAN is
			-- Can a password be set?
		deferred
		end
	 
	has_username: BOOLEAN is
			-- Can address contain a username?
		deferred
		end
	 
feature -- Status setting

	set_port (port_no: INTEGER) is
			-- Set port number.
		require
			positive_port_number: port_no > 0
		do
			port := port_no
		ensure
			port_set: port = port_no
		end

	set_proxy (host: STRING; port_no: INTEGER) is
			-- Set proxy information.
		require
			proxy_supported: is_proxy_supported
			non_empty_host: host /= Void and then not host.empty
			host_valid: proxy_host_ok (host)
			positive_port: port_no > 0
		do
			proxy_host := host
			proxy_port := port_no
		ensure
			host_set: proxy_host = host
			port_set: proxy_port = port_no
		end

	set_username (un: STRING) is
			-- Set username.
		require
			username_ok: has_username
			non_empty_username: un /= Void and then not un.empty
		deferred
		end
	 
	set_password (pw: STRING) is
			-- Set password.
		require
			password_accepted: is_password_accepted
			non_empty_password: pw /= Void and then not pw.empty
		deferred
		end
	 
	reset_proxy is
			-- Reset proxy information.
		require
			proxy_supported: is_proxy_supported
		do
			proxy_host := Void
			proxy_port := 0
		ensure
			host_reset: proxy_host = Void
			port_reset: proxy_port = 0
		end

feature {NONE} -- Basic operations

	analyze is
			-- Analyze URL.
		require
			address_specified: address /= Void and then not address.empty
		deferred
		end

feature {NONE} -- Implementation

	address: STRING

end -- class URL

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1086-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


