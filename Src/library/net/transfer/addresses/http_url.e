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
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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


