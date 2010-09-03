
expanded class TEST2 [G -> ANY create default_create end]
inherit
	ANY
		redefine
			default_create
		end
feature
	default_create
		do
			create a
		end

	a: G
end
