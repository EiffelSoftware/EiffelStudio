indexing

	description: "Byte code for once manifest string (pre-allocated)."
	date: "$Date$"
	revision: "$Revision$"

class
	ONCE_STRING_B

inherit
	EXPR_B
		redefine
			enlarged, make_byte_code, generate_il,
			is_simple_expr, allocates_memory, size
		end

create
	make

feature {NONE} -- Initialization

	make (v: STRING; n: INTEGER) is
			-- Create object for `n'-th once manifest string with value `v'.
		require
			v_not_void: v /= Void
			positive_n: n > 0
		do
			value := v
			number := n
		ensure
			value_set: value = v
			number_set: number = n
		end

feature -- Access

	value: STRING
			-- Character value

	number: INTEGER
			-- Ordinal number of once manifest string in routine

	is_dotnet_string: BOOLEAN
			-- Is current a manifest System.String constant?

feature -- Properties

	type: CL_TYPE_I is
			-- String type
		do
			if is_dotnet_string then
				Result := system_string_type
			else
				Result := string_type
			end
		end

	enlarged: ONCE_STRING_BL is
			-- Enlarge node
		do
			create Result.make (value, number)
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- Register `r' is not used for string value computation
		do
		end

	is_simple_expr: BOOLEAN is True
			-- A string is a simple expression

	allocates_memory: BOOLEAN is
			-- Does the expression allocates memory?
		do
				-- Current always allocates memory
			Result := True
		end

	size: INTEGER is
		do
				-- Inlining will not be done for once string as they need to
				-- be generated in the context of the feature were they are defined.
			Result := 101	-- equal to maximum size of inlining + 1 (Found in FREE_OPTION_SD)
		end

feature -- Settings

	set_is_dotnet_string (v: like is_dotnet_string) is
			-- Set `is_dotnet_string' with `v'.
		do
			is_dotnet_string := v
		ensure
			is_dotnet_string_set: is_dotnet_string = v
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for a once manifest string.
		do
			il_generator.generate_once_string (number - 1, value, is_dotnet_string)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a once manifest string.
		do
			ba.append (Bc_once_string)
			ba.append_integer (body_index - 1)
			ba.append_integer (number - 1)
			ba.append_integer (value.count)
			ba.append_raw_string (value)
		end

feature {NONE} -- Implementation: types

	string_type: CL_TYPE_I is
			-- Type of STRING
		once
			create Result.make (System.string_id)
		ensure
			string_type_not_void: Result /= Void
		end

	system_string_type: CL_TYPE_I is
			-- Type of SYSTEM_STRING
		require
			il_generation: System.il_generation
		once
			create Result.make (System.system_string_id)
		ensure
			system_string_type_not_void: Result /= Void
		end

feature {NONE} -- Implementation: numbering

	body_index: INTEGER is
			-- Original body index with this once manifest string
		do
			Result := context.original_body_index
		end

invariant

	value_not_void: value /= Void

end
