
class TEST
inherit
	PARENT
		redefine
			make
		end
create
	make, default_create
feature
	make
		local
			x: PARENT
		do
			precursor
			create x.make
		end
end
