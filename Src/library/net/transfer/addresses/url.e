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
			address_specified: a /= Void and then not a.is_empty
		do
			address := a
			port := Default_port
			proxy_information := Void
			analyze
		ensure
			address_set: address = a
			default_port_set: port = Default_port
			no_proxy_set: proxy_information = Void
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
	
	proxy_host: STRING is
			-- Name or address of proxy host
		require
			proxy_supported: is_proxy_supported
			has_proxy: is_proxy_used
		do
			Result := proxy_information.host
		ensure
			result_not_empty: Result /= Void and then not Result.is_empty
		end

	proxy_port: INTEGER is
			-- Port of proxy
		require
			proxy_supported: is_proxy_supported
			has_proxy: is_proxy_used
		do
			Result := proxy_information.port
		ensure
			result_non_negative: Result >= 0
		end
			
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
			Result := (proxy_information /= Void)
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
			-- Set port to `port_no'.
		require
			port_non_negative: port_no >= 0
		do
			port := port_no
		ensure
			port_set: port = port_no
		end

	set_proxy (host: STRING; port_no: INTEGER) is
			-- Set proxy host to `host' and proxy port to `port_no'.
		require
			proxy_supported: is_proxy_supported
			non_empty_host: host /= Void and then not host.is_empty
			host_valid: proxy_host_ok (host)
			non_negative_port: port_no >= 0
		do
			create proxy_information.make (host, port_no)
		ensure
			host_set: proxy_host = host
			port_set: proxy_port = port_no
		end

	set_proxy_information (pi: PROXY_INFORMATION) is
			-- Set proxy information to `pi'.
		require
			proxy_supported: is_proxy_supported
		do
			proxy_information := pi
		ensure
			proxy_information_set: proxy_information = pi
		end

	set_username (un: STRING) is
			-- Set username.
		require
			username_ok: has_username
			non_empty_username: un /= Void and then not un.is_empty
		deferred
		end
	 
	set_password (pw: STRING) is
			-- Set password.
		require
			password_accepted: is_password_accepted
			non_empty_password: pw /= Void and then not pw.is_empty
		deferred
		end
	 
	reset_proxy is
			-- Reset proxy information.
		require
			proxy_supported: is_proxy_supported
		do
			proxy_information := Void
		ensure
			no_proxy_set: not is_proxy_used
			port_reset: proxy_port = 0
		end

feature {NONE} -- Basic operations

	analyze is
			-- Analyze URL.
		require
			address_specified: address /= Void and then not address.is_empty
		deferred
		end

feature {NONE} -- Implementation

	address: STRING
			-- Address string

	proxy_information: PROXY_INFORMATION
			-- Information about the proxy to be used
			
invariant

	proxy_used_definition: is_proxy_used = (proxy_information /= Void)
	proxy_usage_constraint: is_proxy_used implies is_proxy_supported
	
end -- class URL


--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

