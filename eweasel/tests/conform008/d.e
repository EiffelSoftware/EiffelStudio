class
	D [G -> ANY]

inherit
	ANY
		redefine
			default_create
		end

feature

	default_create
		do
			item := ({G}).name_32
			item_det := ({detachable G}).name_32
			item_att := ({attached G}).name_32
		end

	item: STRING_32
	item_det: STRING_32
	item_att: STRING_32

end
