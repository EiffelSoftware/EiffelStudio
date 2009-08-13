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
			a: TEST_UPLOADER
			l: TEST_REQUEST_PARSER
			c: TEST_UTILITIES
			b: TEST_WEBAPPS
		do

		end

end
