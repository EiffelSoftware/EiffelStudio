expanded class A

inherit ANY
	redefine
		default_create
	end

create
	default_create,
	make_self1,
	make_self2,
	make_self3,
	make_other

feature {NONE} -- Initialization

	default_create
			-- Make sure all the attributes are initialized.
		do
			a := "foo"
		end

	make_self1
			-- Access Current before initializing all the attributes.
		do
			default_create
			access_current1
		end

	make_self2
			-- Access Current before initializing all the attributes.
		do
			default_create
			access_current2
		end

	make_self3
			-- Access Current before initializing all the attributes.
		do
			default_create
			access_current3
		end

	make_other (t: TEST)
			-- Pass Current before initializing all the attributes.
		do
			default_create
			t.access (Current) -- VEVI
		end

feature -- Access

	access_current1
			-- Access `Current' without making it explicitly targeted.
		local
			x: ANY
		do
			x := Current -- VEVI
		end

	access_current2
			-- Access `Current' without making it explicitly targeted.
		do
			if Current = Void then end -- VEVI
		end

	access_current3
			-- Access `Current' without making it explicitly targeted.
		do
			if attached Current then end -- VEVI
		end

feature {NONE} -- Access

	a: ANY
			-- Storage.

end