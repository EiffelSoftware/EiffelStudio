
class TEST
inherit
	PARENT
		redefine
			make
		end

create
	make
feature
	make
		do
			create s.make
			create t.make
			precursor
		end
	
	s: GRAND_PARENT

	t: PARENT
end
