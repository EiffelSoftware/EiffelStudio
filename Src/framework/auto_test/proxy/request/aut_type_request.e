indexing
	description:

		"Instruction that requests the type of a variable"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_TYPE_REQUEST

inherit

	AUT_REQUEST
		rename
			make as make_request
		redefine
			is_type_request
		end

create

	make

feature {NONE} -- Initialization

	make (a_system: like system; a_variable: like variable) is
			-- Create new request.
		require
			a_system_not_void: a_system /= Void
			a_variable_not_void: a_variable /= Void
		do
			make_request (a_system)
			variable := a_variable
		ensure
			system_set: system = a_system
			variable_set: variable = a_variable
		end

feature -- Status report

	is_type_request: BOOLEAN is True
			-- Is Current a type request?

feature -- Access

	variable: ITP_VARIABLE
			-- Variable that the type is aksed of

feature -- Processing

	process (a_processor: AUT_REQUEST_PROCESSOR) is
			-- Process current request.
		do
			a_processor.process_type_request (Current)
		end

invariant

	variable_not_void: variable /= Void

end
