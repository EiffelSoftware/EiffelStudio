
class TEST
inherit
	TEST1
		redefine
			make
		end
create
	make

feature {NONE}

	make is
		do
			precursor
		end

end
