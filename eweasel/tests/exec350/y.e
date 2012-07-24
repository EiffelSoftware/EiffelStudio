class Y
inherit
	X
		redefine
			make, val
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create val.make (10)
		end

feature

	val: ARRAYED_LIST [ANY]

end
