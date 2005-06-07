indexing
	description: "Representation of an eiffel constant."
	date: "$Date$"
	revision: "$Revision$"

class E_CONSTANT

inherit

	E_FEATURE
		redefine
			assigner_name, is_constant, type
		end

create

	make

feature -- Properties

	is_constant: BOOLEAN is True
			-- Is current a function

	value: STRING
			-- String representation of the constant

	type: TYPE_A
			-- Return type

	assigner_name: STRING
			-- Name of the assigner procedure (if any)

feature -- Setting

	set_type (t: like type; a: like assigner_name) is
			-- Set `type' to `t' and `assigner_name' to `a'.
		require
			valid_t: t /= Void
		do
			type := t
			assigner_name := a
		ensure
			type_set: type = t
			assigner_name_set: assigner_name = a
		end

	set_value (v: like value) is
			-- Set `value' to `v'.
		require
			valid_v: v /= Void
		do
			value := v
		ensure
			set: value = v
		end

end -- class E_CONSTANT
