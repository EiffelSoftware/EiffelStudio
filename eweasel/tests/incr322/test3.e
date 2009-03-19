
class TEST3
inherit
	TEST2
		redefine
			value
		end

create
	make

feature

	value: INTEGER $BODY

end
