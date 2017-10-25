class A [G -> X create default_create end]

feature

	f
			-- Call `g` whose result depends on the actual generic parameter.
		note
			option: instance_free
		do
			g.h
			{like g}.h
		end

	g: G
			-- An instance-free function depending on the formal generic.
		note
			option: instance_free
		do
			create Result
		end

end