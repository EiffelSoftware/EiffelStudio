class X [G -> {A rename foo as bar end} create default_create end]

create
	make_attribute, make_like_attribute, make_type

feature

	make_attribute
		do
			create baz
		end

	make_like_attribute
		do
			create {like baz} baz
		end

	make_type
		do
			create {like {G}.bar} baz
		end

	baz: like {G}.bar

end