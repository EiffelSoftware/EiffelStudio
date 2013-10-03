class
	PROCESS_WORKER

create
	make

feature {NONE} -- Init

	make (a_input_handler: like input_handler)
			-- Make with `a_output_handler'.
		do
			input_handler := a_input_handler
		end

feature -- Action

	run
		do
			execute (input_handler)
		end

feature {NONE} -- Implemenetation

	execute (a_input_handler: separate ROOT_CLASS)
			-- Logs dir
		local
			l_str: STRING
		do
			create l_str.make_from_separate (a_input_handler.t_any.item.out)
			io.put_string (l_str)
			io.put_new_line
			io.put_integer (a_input_handler.t_integer.item)
			io.put_new_line
		end

feature {NONE} -- Implementation

	input_handler: separate ROOT_CLASS;
			-- Input handler

end
