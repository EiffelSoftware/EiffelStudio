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
			item := {G}
			item_det := {detachable G}
			item_att := {attached G}
		end

	item: STRING
	item_det: STRING
	item_att: STRING

end
