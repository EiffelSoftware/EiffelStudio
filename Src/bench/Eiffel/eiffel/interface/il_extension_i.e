indexing
	description: "Encapsulation of an IL extension."
	date: "$Date$"
	revision: "$Revision$"

class IL_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_il
		end

	SHARED_IL_CONSTANTS
		export
			{NONE} all
			{ANY} valid_type, need_current
		undefine
			is_equal
		end

	SHARED_IL_CODE_GENERATOR
		export
			{NONE} all
		undefine
			is_equal
		end		

feature -- Access

	is_il: BOOLEAN is True
			-- Current external is an IL external.
			
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

feature -- Generation access

	token: INTEGER is
		do
			Result := il_generator.external_token (base_class, names_heap.item (alias_name_id),
				type, argument_types, return_type)
		end

feature -- Call generation

	generate_call (is_polymorphic: BOOLEAN) is
			-- Generate external feature call on Current.
		require
			valid_call: alias_name_id > 0 or else
				type = {SHARED_IL_CONSTANTS}.Creator_type
		do
			check
				type_not_enum: type /= Enum_field_type
			end
			il_generator.generate_external_call (base_class, Names_heap.item (alias_name_id),
				type, argument_types, return_type, is_polymorphic)
		end

	generate_creation_call is
			-- Generate external feature call on constructor `n' using information
			-- of Current wihtout creating an object.
		require
			valid_call: type = {SHARED_IL_CONSTANTS}.Creator_type
		do
				-- Generate a normal non-virtual call.
			il_generator.generate_external_call (base_class, Names_heap.item (alias_name_id),
				creator_call_type, argument_types, return_type, False)
		end

	generate_body (il_byte_code: EXT_BYTE_CODE; a_result: RESULT_B) is
			-- Generate C code.
		do
			-- Do nothing here since IL code does not generate into C code.
		end
		
end -- class IL_EXTENSION_I
