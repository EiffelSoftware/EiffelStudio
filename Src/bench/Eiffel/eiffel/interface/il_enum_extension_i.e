indexing
	description: "Encapsulation of an IL enum extension."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ENUM_EXTENSION_I

inherit
	IL_EXTENSION_I
		redefine
			generate_call, default_create
		end

create
	default_create
	
feature {NONE} -- Initialization

	default_create is
			-- 
		do
			type := Enum_field_type
		end

feature -- Access

	value: INTEGER
			-- Value for enum.

feature -- Settings

	set_value (v: like value) is
			-- Set `value' with `v'.
		do
			value := v
		ensure
			value_set: value = v
		end
		
feature -- IL code generation

	generate_call (is_polymorphic: BOOLEAN) is
			-- Generate external feature call on Current.
		do
			il_generator.put_integer_32_constant (value)
		end

invariant
	type_is_enum: type = Enum_field_type

end -- class IL_ENUM_EXTENSION_I
