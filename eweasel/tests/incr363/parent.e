
class PARENT
inherit
	GRAND_PARENT
		redefine
			make
		end
create
	make
feature
	
	make
		do
			precursor
		end

end
