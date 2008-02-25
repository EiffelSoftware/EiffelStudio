class TEST
inherit
	TEST1
		redefine
			new_item
		end

create
	make

feature

	make is
		do
		end

	new_item: like item is
		do
		end

end
