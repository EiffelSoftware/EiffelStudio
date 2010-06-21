
class TEST
inherit
	PARENT
		rename
			make as parent_make
		end
create
	make, default_create
feature
	make
		local
			x: PARENT
		do
			create x.make
		end

end
