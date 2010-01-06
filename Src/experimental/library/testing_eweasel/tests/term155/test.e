class TEST
inherit
	TEST1
		redefine
			create_element
		end

create
	make

feature {NONE} -- Creation

	make
		do
			create_element
		end

	create_element is
		do
		end

end
