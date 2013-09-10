class
	GENERATOR_BOXER

create
	make

feature {NONE} -- Init

	make (a_generator: like boxed_generator)
		do
			boxed_generator := a_generator
		end

feature -- Access

	boxed_generator: separate GENERATOR

end
