note
	description: "An Eiffel feature declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_FEATURE_DECL

inherit
	EIFFEL_ENTITY_DECL

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_arguments_list: ARRAY [TUPLE [name: STRING; type: STRING]]; a_body: detachable STRING)
			-- Initialize Current with `a_name', `a_arguments_list' and `a_body'.
		require
			a_valid_name: not a_name.is_empty
		do
			name := a_name
			arguments_list := a_arguments_list
			body := a_body
		ensure
			name_set: name = a_name
			arguments_list_set: arguments_list = a_arguments_list
			body_set: body = a_body
		end

feature -- Visitor Pattern

	accept (visitor: EIFFEL_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		do
			visitor.visit_feature_decl (Current)
		end

feature -- Setters

	set_return_type (a_return_type: like return_type)
			-- Set `return_type' with `a_return_type'
		require
			a_valid_return_type: a_return_type /= Void implies not a_return_type.is_empty
		do
			return_type := a_return_type
		ensure
			return_type_set: return_type = a_return_type
		end

	set_setter (a_setter: like setter)
			-- Set `setter' with `a_setter'
		do
			setter := a_setter
		ensure
			setter_set: setter = a_setter
		end

	set_commented (true_or_false: like is_commented)
			-- Set `is_commented' with `true_or_false'.
		do
			is_commented := true_or_false
		ensure
			is_commented_set: is_commented = true_or_false
		end

	set_body (a_body: attached like body)
			-- Set `body' with `a_body'.
		do
			body := a_body
		ensure
			body_set: body = a_body
		end

feature -- Access

	name: STRING
			-- The name of the feature declaration.

	setter: detachable STRING assign set_setter
			-- The setter to be used for this attribute declaration.
		require
			is_attribute: body = Void
		attribute
		end

	return_type: detachable STRING assign set_return_type
			-- The return type of this feature declaration.
			-- Void if the feature does not have a return type.

	arguments_list: ARRAY [TUPLE [name: STRING; type: STRING]]
			-- A list of the arguments of this feature declaration.

	body: detachable STRING
			-- The body of this feature declaration.
			-- If this feature is an attribute body is void.
		require
			is_procedure: setter = Void
		attribute
		end

	is_commented: BOOLEAN assign set_commented
			-- Is this feature declaration commented?

feature -- Debug Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		local
			visitor: EIFFEL_DEBUG_VISITOR
		do
			create visitor.make
			accept (visitor)
			Result := visitor.last_result
		end

end
