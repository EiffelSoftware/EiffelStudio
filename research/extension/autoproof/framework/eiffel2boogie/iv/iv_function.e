note
	date: "$Date$"
	revision: "$Revision$"

class
	IV_FUNCTION

inherit

	IV_DECLARATION

inherit {NONE}

	IV_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_type: IV_TYPE)
			-- Initialize function with name `a_name' and type `a_type'.
		require
			a_name_attached: attached a_name
			a_name_valid: is_valid_name (a_name)
			a_type_attached: attached a_type
		do
			name := a_name.twin
			type := a_type
			create arguments.make
		ensure
			name_set: name ~ a_name
			type_set: type = a_type
		end

feature -- Access

	name: STRING
			-- Function name.

	arguments: LINKED_LIST [IV_ENTITY_DECLARATION]
			-- Function arguments.

	type: IV_TYPE
			-- Result type of function.

	body: detachable IV_EXPRESSION
			-- Function body, if any.

	is_inline: BOOLEAN
			-- Should this function be inlined?

feature -- Element change

	add_argument (a_name: READABLE_STRING_32; a_type: IV_TYPE)
			-- Add argument with name `a_name' and type `a_type'.
		require
			a_name_valid: is_valid_name_32 (a_name)
			a_type_attached: attached a_type
		do
			arguments.extend (create {IV_ENTITY_DECLARATION}.make (a_name, a_type))
		ensure
			argument_added: arguments.last.name ~ a_name
			argument_added: arguments.last.type = a_type
		end

	set_body (a_expression: like body)
			-- Set `body' to `a_expression'.
		require
			valid_expression: attached a_expression implies (a_expression.type ~ type)
		do
			body := a_expression
		ensure
			body_set: body = a_expression
		end

	set_inline
			-- Set this function to be inlined.
		do
			is_inline := True
		end

feature -- Visitor

	process (a_visitor: IV_UNIVERSE_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_function (Current)
		end

invariant
	name_attached: attached name
	name_valid: is_valid_name (name)
	arguments_attached: attached arguments
	arguments_valid: across arguments as i all i.item.property = Void end
	type_attached: attached type
	valid_body: attached body implies body.type ~ type

end
