indexing
	description:

		"Instruction that requests the assignment of an expression to a variable"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_ASSIGN_EXPRESSION_REQUEST

inherit

	AUT_REQUEST
		rename
			make as make_request
		end

create

	make

feature {NONE} -- Initialization

	make (a_system: like system; a_receiver: like receiver; an_expression: like expression) is
			-- Create new request.
		require
			a_system_not_void: a_system /= Void
			a_receiver_not_void: a_receiver /= Void
			an_expression_not_void: an_expression /= Void
		do
			make_request (a_system)
			receiver := a_receiver
			expression := an_expression
		ensure
			system_set: system = a_system
			receiver_set: receiver = a_receiver
			expression_set: expression = an_expression
		end

feature -- Access

	receiver: ITP_VARIABLE
			-- Variable to receive evaluation of `expression'

	expression: ITP_EXPRESSION
			-- Expression to be assigned to `receiver'

feature -- Processing

	process (a_processor: AUT_REQUEST_PROCESSOR) is
			-- Process current request.
		do
			a_processor.process_assign_expression_request (Current)
		end

invariant

	receiver_not_void: receiver /= Void
	expression_not_void: expression /= Void

end
