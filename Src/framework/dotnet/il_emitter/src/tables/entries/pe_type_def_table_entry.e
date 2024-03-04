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
	make_with_data,
	make_with_uninitialized_field_and_method

feature {NONE} -- Initialization

	make_with_data (a_flags: INTEGER; a_type_name_index: NATURAL_32; a_type_name_space_index: NATURAL_32;
			a_extends: detachable PE_TYPEDEF_OR_REF; a_field_index: NATURAL_32; a_method_index: NATURAL_32)
		do
			flags := a_flags
			create type_name_index.make_with_index (a_type_name_index)
			create type_name_space_index.make_with_index (a_type_name_space_index)
			extends := a_extends
			create fields.make_with_index (a_field_index)
			create methods.make_with_index (a_method_index)
		end

	make_with_uninitialized_field_and_method (a_flags: INTEGER; a_type_name_index: NATURAL_32; a_type_name_space_index: NATURAL_32;
			a_extends: detachable PE_TYPEDEF_OR_REF)
		do
			flags := a_flags
			create type_name_index.make_with_index (a_type_name_index)
			create type_name_space_index.make_with_index (a_type_name_space_index)
			extends := a_extends
			create fields.make_default
			create methods.make_default
		ensure
			not is_field_list_index_set
			not is_method_list_index_set
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| There shall be no duplicate rows in the TypeDef table, based on TypeNamespace + TypeName
		do
			Result := Precursor (e)
				or else (
					e.type_name_index.is_equal (type_name_index) and then
					e.type_name_space_index.is_equal (type_name_space_index)
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
			Result := Result + " methods[" + methods.debug_output+ "]"
			Result := Result + " fields[" + fields.debug_output + "]"
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

	set_field_list_index (idx: NATURAL_32)
		require
			not is_field_list_index_set
		do
			debug ("il_emitter_table")
				print ("  -> TypeDef: Update FieldList (" + fields.index.to_hex_string + " -> " + idx.to_hex_string + ")%N")
			end
			fields.update_index (idx)
		ensure
			is_field_list_index_set
		end

	set_method_list_index (idx: NATURAL_32)
		require
			not is_method_list_index_set
		do
			debug ("il_emitter_table")
				print ("  -> TypeDef: Update MethodList (" + methods.index.to_hex_string + " -> " + idx.to_hex_string + ")%N")
			end
			methods.update_index (idx)
		ensure
			is_method_list_index_set
		end

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.ttypedef
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
			-- <Precursor>
		local
			l_bytes: NATURAL_32
			fake_extends: PE_TYPEDEF_OR_REF
		do
				-- Write the flags to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_integer_32 (a_dest, flags, 0)

				-- Initialize the number of bytes written
			l_bytes := 4

				-- Write the type_name_index, type_name_space_index, extends, fields and methods
				-- to the buffer and update the number of bytes.

			l_bytes := l_bytes + type_name_index.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + type_name_space_index.render (a_sizes, a_dest, l_bytes)
			if attached extends as l_extends then
				l_bytes := l_bytes + l_extends.render (a_sizes, a_dest, l_bytes)
			else
				create fake_extends.make_with_tag_and_index ({PE_TYPEDEF_OR_REF}.typedef, 0)
				l_bytes := l_bytes + fake_extends.render (a_sizes, a_dest, l_bytes)
			end
			l_bytes := l_bytes + fields.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + methods.render (a_sizes, a_dest, l_bytes)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
			fake_extends: PE_TYPEDEF_OR_REF
		do
				-- Set the flags (from a_src)  to the flags.
			flags := {BYTE_ARRAY_HELPER}.integer_32_at (a_src, 0)

				-- Initialize the number of bytes readed.
			l_bytes := 4

				-- Get the type_name_index, type_namespace_index, extends, fields, and methods and
				-- update the number of bytes.

			l_bytes := l_bytes + type_name_index.get (a_sizes, a_src, l_bytes)
			l_bytes := l_bytes + type_name_space_index.get (a_sizes, a_src, l_bytes)
			if attached extends as l_extends then
				l_bytes := l_bytes + l_extends.get (a_sizes, a_src, l_bytes)
			else
				create fake_extends.make_with_tag_and_index ({PE_TYPEDEF_OR_REF}.typedef, 0)
				l_bytes := l_bytes + fake_extends.get (a_sizes, a_src, l_bytes)
			end
			l_bytes := l_bytes + fields.get (a_sizes, a_src, l_bytes)
			l_bytes := l_bytes + methods.get (a_sizes, a_src, l_bytes)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
