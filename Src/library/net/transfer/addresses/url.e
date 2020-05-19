note
	description:
		"Unified resource locators"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class URL inherit

	HASHABLE

feature {NONE} -- Initialization

	make (a: STRING_8)
			-- Create URL with address `a'.
		require
			address_specified: a /= Void and then not a.is_empty
		do
			create address.make_from_string (a)
			port := Default_port
			proxy_information := Void
			analyze
		ensure
			address_set: address ~ a
			port_set: port > 0
			no_proxy_set: proxy_information = Void
		end

feature -- Access

	service: STRING_8
			-- Name of service
		deferred
		end

	port: INTEGER
			-- Port used by service

	default_port: INTEGER
			-- Default port number for service
		deferred
		end

	proxy_host: STRING_8
			-- Name or address of proxy host
		require
			proxy_supported: is_proxy_supported
			has_proxy: is_proxy_used
		do
			check is_proxy_used: attached proxy_information as l_proxy_information then
				Result := l_proxy_information.host
			end
		ensure
			result_not_empty: Result /= Void and then not Result.is_empty
		end

	proxy_port: INTEGER
			-- Port of proxy
		require
			proxy_supported: is_proxy_supported
			has_proxy: is_proxy_used
		do
			check is_proxy_used: attached proxy_information as l_proxy_information then
				Result := l_proxy_information.port
			end
		ensure
			result_non_negative: Result >= 0
		end

	location: STRING_8
			-- Full URL of resource
		deferred
		end

feature -- Status report

	is_correct: BOOLEAN
			-- Is URL correct?
		deferred
		end

	 is_proxy_supported: BOOLEAN
			-- Are proxy connections supported?
		deferred
		end

	 proxy_host_ok (host: STRING_8): BOOLEAN
	 		-- Is host name of proxy correct?
		require
			proxy_supported: is_proxy_supported
		deferred
		end

	 is_proxy_used: BOOLEAN
	 		-- Is a proxy used?
		do
			Result := (proxy_information /= Void)
		end

	is_password_accepted: BOOLEAN
			-- Can a password be set?
		deferred
		end

	has_username: BOOLEAN
			-- Can address contain a username?
		deferred
		end

feature -- Status setting

	set_port (port_no: INTEGER)
			-- Set port to `port_no'.
		require
			port_non_negative: port_no >= 0
		do
			port := port_no
		ensure
			port_set: port = port_no
		end

	set_proxy (host: STRING_8; port_no: INTEGER)
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

	set_proxy_information (pi: PROXY_INFORMATION)
			-- Set proxy information to `pi'.
		require
			proxy_supported: is_proxy_supported
		do
			proxy_information := pi
		ensure
			proxy_information_set: proxy_information = pi
		end

	set_username (un: STRING_8)
			-- Set username.
		require
			username_ok: has_username
			non_empty_username: un /= Void and then not un.is_empty
		deferred
		end

	set_password (pw: STRING_8)
			-- Set password.
		require
			password_accepted: is_password_accepted
			non_empty_password: pw /= Void and then not pw.is_empty
		deferred
		end

	reset_proxy
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

	analyze
			-- Analyze URL.
		require
			address_specified: address /= Void and then not address.is_empty
		deferred
		end

feature {NONE} -- Implementation

	address: STRING_8
			-- Address string

	proxy_information: detachable PROXY_INFORMATION
			-- Information about the proxy to be used

invariant

	proxy_used_definition: is_proxy_used = (proxy_information /= Void)
	proxy_usage_constraint: is_proxy_used implies is_proxy_supported

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




end -- class URL

