class A [G -> X create default_create end]

feature

	f
			-- Call `g` whose result depends on the actual generic parameter.
		do
			g.h
			{like g}.h
		ensure
			is_instance_free: class
		end

	g: G
			-- An instance-free function depending on the formal generic.
		do
			create Result
		ensure
			is_instance_free: class
		end

end