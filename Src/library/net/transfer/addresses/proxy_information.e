indexing
	description:
		"Information about proxies"

	status:	"See notice at end of class"
	author: "Patrick Schoenbach"
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

	make (h: STRING; p: INTEGER) is
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

	host: STRING
			-- Name or address of proxy host

	port: INTEGER
			-- Port of proxy

feature -- Status setting

	set_host (h: STRING) is
			-- Set host name to `h'.
		require
			host_not_empty: h /= Void and then not h.is_empty
			host_valid: proxy_host_ok (h)
		do
			host := h
		ensure
			host_set: host = h
		end
			
	set_port (p: INTEGER) is
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

end -- class PROXY_INFORMATION

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

