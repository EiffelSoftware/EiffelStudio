
expanded class TEST2 [G -> ANY create default_create end]
inherit
	ANY
		redefine
			default_create
		end

create
	default_create
feature
	default_create
		do
			create value
		end

	set_value (a: G)
		do
			value := a
		end

	value: G
end
