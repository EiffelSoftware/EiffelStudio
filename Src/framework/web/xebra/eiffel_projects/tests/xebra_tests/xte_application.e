indexing
	description : "xebra_tests application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	XTE_APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l: TEST_REQUEST_PARSER
		--	ll: XU_REQUEST_ARG_TABLE_PARSER
		do
--			create ll.make

--			if attached ll.argument_table ("&name=fabio&admin=123&27=eine zahl") as l_res then
--				print (l_res)
--			end

			create l
			l.test_get_cookies

		end

end
