note
	description: "Information about proxies"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Patrick Schoenbach"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class PROXY_INFORMATION inherit

	HOST_VALIDITY_CHECKER
		rename
			host_ok as proxy_host_ok
		end

create

	make

feature {NONE} -- Initialization

	make (h: STRING_8; p: INTEGER)
			-- Create proxy information for host `h' and port `p'.
		require
			host_not_empty: h /= Void and then not h.is_empty
			host_valid: proxy_host_ok (h)
			port_number_non_negative: p >= 0
		do
			host := h
			port := p
		ensure
			host_set: host = h
			port_set: port = p
		end

feature -- Access

	host: STRING_8
			-- Name or address of proxy host

	port: INTEGER
			-- Port of proxy

feature -- Status setting

	set_host (h: STRING_8)
			-- Set host name to `h'.
		require
			host_not_empty: h /= Void and then not h.is_empty
			host_valid: proxy_host_ok (h)
		do
			host := h
		ensure
			host_set: host = h
		end

	set_port (p: INTEGER)
			-- Set port to `p'.
		require
			port_non_negative: p >= 0
		do
			port := p
		ensure
			port_set: port = p
		end

invariant

	host_not_empty: host /= Void and then not host.is_empty
	host_valid: proxy_host_ok (host)
	port_non_negative: port >= 0

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
