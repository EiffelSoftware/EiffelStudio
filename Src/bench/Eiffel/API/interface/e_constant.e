indexing
	description: "Representation of an eiffel constant."
	date: "$Date$"
	revision: "$Revision$"

class E_CONSTANT

inherit

	E_FEATURE
		redefine
			is_constant, type
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

feature -- Setting

	set_type (t: like type) is
			-- Set `type' to `t'.
		require
			valid_t: t /= Void
		do
			type := t
		ensure
			set: type = t
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
