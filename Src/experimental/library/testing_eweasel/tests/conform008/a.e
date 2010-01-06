class
	A [G -> ANY create default_create end]

inherit
	ANY
		redefine
			default_create
		end

feature

	default_create
		do
			create item
			create item_det
			create item_att
		end

	item: G
	item_det: detachable G
	item_att: attached G

end
