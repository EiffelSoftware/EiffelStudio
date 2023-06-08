note
	description: "Summary description for {PE_TYPEDEF_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=TypeDef", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=269&zoom=100,116,985", "protocol=uri"

class
	PE_TYPE_DEF_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

	PE_TYPE_DEF_FLAGS

	DEBUG_OUTPUT

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: INTEGER; a_type_name_index: NATURAL_64; a_type_name_space_index: NATURAL_64;
			a_extends: detachable PE_TYPEDEF_OR_REF; a_field_index: NATURAL_64; a_method_index: NATURAL_64)
		do
			flags := a_flags
			create type_name_index.make_with_index (a_type_name_index)
			create type_name_space_index.make_with_index (a_type_name_space_index)
			extends := a_extends
			create fields.make_with_index (a_field_index)
			create methods.make_with_index (a_method_index)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.flags = flags and then
					e.type_name_index.is_equal (type_name_index) and then
					e.type_name_space_index.is_equal (type_name_space_index) and then
					e.fields.is_equal (fields) and then
					e.methods.is_equal (methods) and then
					((e.extends = Void and extends = Void) or else
					(attached e.extends as e_extends and then
					 attached extends as l_extends and then
					 e_extends.is_equal(l_extends)))
				)
		end

feature -- Access

	flags: INTEGER
			-- a 4-byte bitmask of type TypeAttributes

	type_name_index: PE_STRING
			-- an index into the String heap

	type_name_space_index: PE_STRING
			-- (an index into the String heap

	extends: detachable PE_TYPEDEF_OR_REF
			-- an index into the TypeDef, TypeRef, or TypeSpec table; more precisely, a
			-- TypeDefOrRef

	fields: PE_FIELD_LIST
			-- an index into the Field table; it marks the first of a contiguous run of
			-- Fields owned by this Type

	methods: PE_METHOD_LIST
			-- an index into the MethodDef table; it marks the first of a continguous
			-- run of Methods owned by this Type

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{TypeDef} "
						+ " methods:" + methods.index.out
						+ " fields:" + fields.index.out
		end

	is_field_list_index_set: BOOLEAN
		do
			Result := fields.is_list_index_set
		end

	is_method_list_index_set: BOOLEAN
		do
			Result := methods.is_list_index_set
		end

feature -- Element change

	set_field_list_index (idx: NATURAL_64)
		require
			not is_field_list_index_set
		do
			fields.update_index (idx)
		ensure
			is_field_list_index_set
		end

	set_method_list_index (idx: NATURAL_64)
		require
			not is_method_list_index_set
		do
			methods.update_index (idx)
		ensure
			is_method_list_index_set
		end

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.ttypedef.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
			-- <Precursor>
		local
			l_bytes: NATURAL_64
		do
				-- Write the flags to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_32_with_integer_32 (a_dest, flags, 0)

				-- Initialize the number of bytes written
			l_bytes := 4

				-- Write the type_name_index, type_name_space_index, extends, fields and methods
				-- to the buffer and update the number of bytes.

			l_bytes := l_bytes + type_name_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + type_name_space_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			if attached extends as l_extends then
				l_bytes := l_bytes + l_extends.render (a_sizes, a_dest, l_bytes.to_integer_32)
			else
					-- TODO: check if correct
				{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest, 0, l_bytes.to_integer_32)
				l_bytes := l_bytes + 2
			end
			l_bytes := l_bytes + fields.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + methods.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set the flags (from a_src)  to the flags.
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_integer_32 (a_src, 0)

				-- Initialize the number of bytes readed.
			l_bytes := 4

				-- Get the type_name_index, type_namespace_index, extends, fields, and methods and
				-- update the number of bytes.

			l_bytes := l_bytes + type_name_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + type_name_space_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			if attached extends as l_extends then
				l_bytes := l_bytes + l_extends.get (a_sizes, a_src, l_bytes.to_integer_32)
			else
				check has_extends: False end
				l_bytes := l_bytes + 2 ;
			end
			l_bytes := l_bytes + fields.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + methods.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
