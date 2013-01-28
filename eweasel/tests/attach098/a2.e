expanded class A

inherit ANY
	redefine
		default_create
	end

create
	default_create,
	make_self,
	make_other

feature {NONE} -- Initialization

	default_create
			-- Make sure all the attributes are initialized.
		do
			a := "foo"
		end

	make_self
			-- Call Current before initializing all the attributes.
		do
			default_create
			access_current
		end

	make_other (t: TEST)
			-- Pass Current before initializing all the attributes.
		do
			default_create
			t.access (Current) -- VEVI
		end

feature -- Access

	access_current
		do
			Current.do_nothing -- VEVI
		end

feature {NONE} -- Access

	a: ANY
			-- Storage.

end