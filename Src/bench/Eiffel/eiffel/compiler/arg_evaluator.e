-- Evalauator of argument type

class
	ARG_EVALUATOR 

inherit
	TYPE_EVALUATOR

feature

	argument_name: STRING
			-- Argument name involved in error

	set_argument_name (s: STRING) is
			-- Assign `s' to `argument_name'.
		do
			argument_name := s
		end

	new_error: VTAT1A is
			-- New error message
		do
			create Result
		end

	update (error_msg: VTAT1A) is
			-- Update error message
		do
			error_msg.set_argument_name (argument_name)
		end

end
