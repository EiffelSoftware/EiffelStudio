note

	description:

		"Gobo Eiffel Ant Example Class"

	library: "Gobo Eiffel Ant"
	copyright: "Copyright (c) 2001, Sven Ehrke and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"


class HELLO

create

	make

feature {NONE} -- Initialization

	make
			-- Execute 'hello world'.
		do
			print ("Hello World%N")
		end

end
