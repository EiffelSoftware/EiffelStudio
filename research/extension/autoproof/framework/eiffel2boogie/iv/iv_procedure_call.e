note
	date: "$Date$"
	revision: "$Revision$"

class
	IV_PROCEDURE_CALL

inherit

	IV_STATEMENT

inherit {NONE}

	IV_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8)
			-- Initialize call to procedure `a_name'.
		do
			name := a_name.twin
			create arguments.make
		ensure
			name_set: name ~ a_name
		end

feature -- Access

	name: READABLE_STRING_8
			-- Name of called procedure.

	arguments: LINKED_LIST [IV_EXPRESSION]
			-- Arguments of procedure call.

	target: detachable IV_EXPRESSION
			-- Target that receives result of procedure call (if any).

feature -- Element change

	add_argument (a_argument: IV_EXPRESSION)
			-- Add argument `a_argument'.
		require
			a_argument_attached: attached a_argument
		do
			arguments.extend (a_argument)
		end

	set_target (a_target: like target)
			-- Set `target' to `a_target'.
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

feature -- Visitor

	process (a_visitor: IV_STATEMENT_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_procedure_call (Current)
		end

invariant
	name_attached: attached name
	name_valid: is_valid_name (name)
	arguments_attached: attached arguments

end
