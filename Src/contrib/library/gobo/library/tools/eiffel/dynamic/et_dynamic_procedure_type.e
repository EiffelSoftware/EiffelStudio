indexing

	description:

		"Eiffel dynamic PROCEDURE types at run-time"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2004-2005, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_DYNAMIC_PROCEDURE_TYPE

inherit

	ET_DYNAMIC_ROUTINE_TYPE
		rename
			make as make_type
		redefine
			new_dynamic_procedure
		end

	ET_SHARED_TOKEN_CONSTANTS
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_type: like base_type; a_class: like base_class; an_open_operand_type_sets: like open_operand_type_sets) is
			-- Create a new PROCEDURE type.
		require
			a_type_not_void: a_type /= Void
			a_type_base_type: a_type.is_base_type
			a_class_not_void: a_class /= Void
			an_open_operand_type_sets_not_void: an_open_operand_type_sets /= Void
		do
			open_operand_type_sets := an_open_operand_type_sets
			make_type (a_type, a_class)
		ensure
			base_type_set: base_type = a_type
			base_class_set: base_class = a_class
			open_operand_type_sets_set: open_operand_type_sets = an_open_operand_type_sets
		end

feature -- Access

	result_type_set: ET_DYNAMIC_TYPE_SET is
			-- Type set of result, if any
		do
			-- Result := Void
		end

feature {NONE} -- Implementation

	new_dynamic_procedure (a_procedure: ET_PROCEDURE; a_system: ET_DYNAMIC_SYSTEM): ET_DYNAMIC_FEATURE is
			-- Run-time procedure associated with `a_procedure';
			-- Create a new object at each call.
		do
			Result := precursor (a_procedure, a_system)
			if Result.builtin_code = tokens.builtin_procedure_feature (tokens.builtin_procedure_call) then
				a_system.dynamic_type_set_builder.build_agent_call (Current, Result)
			end
		end

invariant

	is_procedure: result_type_set = Void

end
