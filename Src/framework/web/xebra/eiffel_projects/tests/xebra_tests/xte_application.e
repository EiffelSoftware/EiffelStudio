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
		do
			--| Add your code here
			print ("hello")
		end

end
