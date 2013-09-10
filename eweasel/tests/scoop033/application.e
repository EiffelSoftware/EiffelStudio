class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_generator: GENERATOR
		do
			create l_generator.make
			l_generator.generate
		end

end
