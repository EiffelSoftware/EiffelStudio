class
	PROCESSOR

feature -- Action

	generate (a_boxer: separate GENERATOR_BOXER)
		do
			finish (a_boxer.boxed_generator)
		end

	create_boxer (a_generator: separate GENERATOR): GENERATOR_BOXER
		do
			create Result.make (a_generator)
		end

feature {NONE} -- Wrapper

	finish (a_generator: separate GENERATOR)
		do
			a_generator.generation_done (a_generator.finished_data)
		end

end
