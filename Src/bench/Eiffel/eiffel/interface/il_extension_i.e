indexing
	description: "Encapsulation of an IL extension."
	date: "$Date$"
	revision: "$Revision$"

class IL_EXTENSION_I

inherit
	EXTERNAL_EXT_I

	SHARED_IL_CONSTANTS
		undefine
			is_equal
		end

	SHARED_IL_CODE_GENERATOR
		undefine
			is_equal
		end		

feature -- Access

	type: INTEGER
			-- Type of IL external.
			--| See SHARED_IL_CONSTANTS for all types constants.

	base_class: STRING
			-- Name of IL class where feature is defined

feature -- Settings

	set_type (v: INTEGER) is
			-- Assign `v' to `type'.
		require
			valid_type: valid_type (v)
		do
			type := v
		ensure
			type_set: type = v
		end

	set_base_class (name: STRING) is
			-- Assign `name' to `base_class'.
		require
			name_not_void: name /= Void
		do
			base_class := name
		ensure
			base_class_set: base_class = name
		end

feature -- Call generation

	generate_call (n: STRING; type_i: TYPE_I; feature_id: INTEGER; is_polymorphic: BOOLEAN) is
			-- Generate external feature call on feature name `n' using information
			-- of Current.
		do
			if type = enum_field_type then
				il_generator.put_integer_32_constant (Names_heap.item (alias_name_id).to_integer)
			else
				il_generator.generate_external_call (base_class, n, type,
					argument_types, return_type, is_polymorphic, type_i, feature_id)
			end
		end

	generate_creation_call (n: STRING; type_i: TYPE_I; feature_id: INTEGER) is
			-- Generate external feature call on constructor `n' using information
			-- of Current wihtout creating an object.
		do
				-- Generate a normal non-virtual call.
			il_generator.generate_external_call (base_class, n, creator_call_type,
					argument_types, return_type, False, type_i, feature_id)
		end

end -- class IL_EXTENSION_I
