class
	TEST

create
	default_create,
	make

feature {NONE} -- Initialization

	make
			-- Run application
		local
			a: VALUE
		do
			a.do_nothing
		end

feature -- Testing

	f
			-- A feature that cannot be inlined and accesses Current.
		do
			check generating_type.out.same_string ("TEST") then end
		rescue
		end

end
