class
	GENERATOR

create
	make

feature

	make
		do
			finished_data := "Generation Done.%N"
		end

feature -- Generate

--	generate
--		local
--			l_processor: separate PROCESSOR
--		do
--			create l_processor
--			wrapped_generate (l_processor, new_boxer (l_processor))
--		end

	generate
		local
			l_processor: separate PROCESSOR
			l_boxer: separate GENERATOR_BOXER
		do
			create l_processor

			l_boxer := new_boxer (l_processor)
			wrapped_generate (l_processor, l_boxer)
		end

	generation_done (a_data: separate STRING)
		local
			l_s: STRING
		do
			create l_s.make_from_separate (a_data)
			print (l_s)
		end

	finished_data: STRING

feature {NONE} -- Wrapper

	wrapped_generate (a_processor: separate PROCESSOR; a_boxer: separate GENERATOR_BOXER)
		do
			a_processor.generate (a_boxer)
		end

	new_boxer (a_processor: separate PROCESSOR): separate GENERATOR_BOXER
		do
			Result := a_processor.create_boxer (Current)
		end

end
