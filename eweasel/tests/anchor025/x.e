class X [G -> {A rename foo as bar end} create default_create end]

create
	make

feature

	make
		do
			create baz
		end

	baz: like {G}.bar

end