indexing
	description:
		"URLs for HTTP resources"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class HTTP_URL inherit

	NETWORK_RESOURCE_URL

create

	make

feature -- Access

	Service: STRING is "http"
			-- Name of service (Answer: "http")

feature -- Status report

	Default_port: INTEGER is 80
			-- Number of default port for service (Answer: 80)
			
	Is_proxy_supported: BOOLEAN is True
			-- Are proxy connections supported? (Answer: yes)

	Has_username: BOOLEAN is False
			-- Can address contain a username? (Answer: no)

end -- class HTTP_URL

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

