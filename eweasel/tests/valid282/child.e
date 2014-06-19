class CHILD
inherit
	PARENT
		redefine
			item
		end

feature

	item: CHILD
		do
			check False then end
		end

end
