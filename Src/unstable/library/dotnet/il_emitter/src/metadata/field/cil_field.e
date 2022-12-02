note
	description: "A field, could be either static or non-static"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_FIELD

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_type: CIL_TYPE; a_flags: CIL_QUALIFIERS)
		do
			name := a_name
			type := a_type
			flags := a_flags
			mode := {CIL_VALUE_MODE}.None
			size := {CIL_VALUE_SIZE}.i8
			create byte_value.make_empty
		ensure
			parent_void: parent = Void
			name_set: name = a_name
			flags_set: flags = a_flags
			type_set: type = a_type
			mode_set: mode = {CIL_VALUE_MODE}.None
			size_set: size = {CIL_VALUE_SIZE}.i8
			ref_set: not ref
			pe_index_set: pe_index = 0
			explicit_offset_set: explicit_offset = 0
			is_external_set: not is_external
			definitions_set: definitions = 0
			byte_value_empty: byte_value.is_empty
		end

feature -- Access

	definitions: NATURAL_64
			-- `definitions' count.

	is_external: BOOLEAN assign set_is_external
			-- Not locally defined.

	explicit_offset: NATURAL_64 assign set_explicit_offset
			-- Field offset for explicit structures

	pe_index: NATURAL_64 assign set_pe_index
			-- Index in the `fielddef` table

	ref: BOOLEAN assign set_ref
			-- Is field referenced?

	type: CIL_TYPE assign set_type
			-- The `type' of field.

	size: CIL_VALUE_SIZE assign set_size
			-- `size'

	parent: detachable CIL_DATA_CONTAINER
			-- `parent'

	flags: CIL_QUALIFIERS assign set_flags
			-- The field Qualifiers.

	name: STRING_32 assign set_name
			-- Field `name'

	mode: CIL_VALUE_MODE assign set_mode
			-- `mode'

	-- The following two attributes are represented as a Union
	byte_value: ARRAY [NATURAL_8]
		-- TO be checked but it could be an ARRAY[NATURAL_8]

	enum_value: INTEGER_64

	byte_length: INTEGER


feature -- Element change

	add_enum_value (a_value: INTEGER_64; a_size: CIL_VALUE_SIZE)
			-- Add an enumeration constant.
			--|Note that the field does need to be part of an enumeration.
		do
			if mode = {CIL_VALUE_MODE}.none then
				mode := {CIL_VALUE_MODE}.enum
				enum_value := a_value
				size := a_size
			end
		end

	add_initializer (a_bytes: ARRAY [NATURAL_8])
			--  Add an SDATA initializer
			--| this will be readonly in ILONLY assemblies.
		do
			if mode = {CIL_VALUE_MODE}.None then
				create byte_value.make_from_array (a_bytes)
				mode :={CIL_VALUE_MODE}.Bytes
			end
		ensure
			initiliazed: (old mode = {CIL_VALUE_MODE}.None) implies byte_value.same_items (a_bytes) and then mode = {CIL_VALUE_MODE}.Bytes
		end

	increment_definitions
			-- Increment `definitions` count.
		do
			definitions := definitions + 1
		ensure
			definitions_assigned: old definitions + 1 = definitions
		end

	set_is_external (an_is_external: like is_external)
			-- Assign `is_external' with `an_is_external'.
		do
			is_external := an_is_external
		ensure
			is_external_assigned: is_external = an_is_external
		end

	set_explicit_offset (an_explicit_offset: like explicit_offset)
			-- Assign `explicit_offset' with `an_explicit_offset'.
		do
			explicit_offset := an_explicit_offset
		ensure
			explicit_offset_assigned: explicit_offset = an_explicit_offset
		end

	set_pe_index (a_pe_index: like pe_index)
			-- Assign `pe_index' with `a_pe_index'.
		do
			pe_index := a_pe_index
		ensure
			pe_index_assigned: pe_index = a_pe_index
		end

	set_ref (a_ref: like ref)
			-- Assign `ref' with `a_ref'.
		do
			ref := a_ref
		ensure
			ref_assigned: ref = a_ref
		end

	set_type (a_type: like type)
			-- Assign `type' with `a_type'.
		do
			type := a_type
		ensure
			type_assigned: type = a_type
		end

	set_size (a_size: like size)
			-- Assign `size' with `a_size'.
		do
			size := a_size
		ensure
			size_assigned: size = a_size
		end

	set_parent, set_container (a_parent: like parent)
			-- Assign `parent' with `a_parent'.
			--|Set the field's container
		do
			parent := a_parent
		ensure
			parent_assigned: parent = a_parent
		end

	set_flags (a_flags: like flags)
			-- Assign `flags' with `a_flags'.
		do
			flags := a_flags
		ensure
			flags_assigned: flags = a_flags
		end

	set_name (a_name: like name)
			-- Assign `name' with `a_name'.
		do
			name := a_name
		ensure
			name_assigned: name = a_name
		end

	set_mode (a_mode: like mode)
			-- Assign `mode' with `a_mode'.
		do
			mode := a_mode
		ensure
			mode_assigned: mode = a_mode
		end

feature -- Status Report

	in_assembly_ref: BOOLEAN
		do
			Result := if attached parent as l_parent then l_parent.in_assembly_ref else False end
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			a_file.put_string (".field")
			if attached parent as l_parent and then
				l_parent.flags.flags & {CIL_QUALIFIERS_ENUM}.explicit /= 0 or else
				attached parent as l_parent and then
				l_parent.flags.flags & {CIL_QUALIFIERS_ENUM}.sequential /= 0 and then explicit_offset /= 0
			then
				a_file.put_string (" [")
				a_file.put_natural_64 (explicit_offset)
				a_file.put_string ("]")
			end
			flags.il_src_dump_before_flags(a_file)
			flags.il_src_dump_after_flags(a_file)

			if type.basic_type = {CIL_BASIC_TYPE}.class_ref then
				if attached {CIL_DATA_CONTAINER} type.type_ref as l_type_ref and then
					l_type_ref.flags.flags & {CIL_QUALIFIERS_ENUM}.value /= 0
				then
					a_file.put_string (" valuetype ")
					Result := type.il_src_dump (a_file)
				else
					a_file.put_string (" class ")
					Result :=type.il_src_dump (a_file)
				end
			else
				a_file.put_string (" ")
				Result := type.il_src_dump (a_file)
			end
			a_file.put_string (" '")
			a_file.put_string (name)
			a_file.put_string ("'")

			inspect mode
			when {CIL_VALUE_MODE}.None then
				-- do nothing
			when {CIL_VALUE_MODE}.Enum then
				a_file.put_string (" = ")
				il_src_dump_type_name (a_file, size)
				a_file.put_string ("(")
				a_file.put_integer_64 (enum_value)
				a_file.put_string (")")
			when {CIL_VALUE_MODE}.Bytes then
				if not byte_value.is_empty then
					a_file.put_string(" at $")
					a_file.put_string(name)
					a_file.put_new_line
					a_file.put_string(".data cil $")
					a_file.put_string(name)
					a_file.put_string(" = bytearray (")
					a_file.put_new_line

					across byte_value as ic loop
						a_file.put_string (ic.to_hex_string)
						a_file.put_string (" ")
						if @ ic.target_index \\ 8 = 0 and then @ ic.target_index /= @ ic.last_index then
							a_file.put_new_line
							a_file.put_string ("%T")
						end
					end
					a_file.put_string (")")
				end
			else
				-- do nothing.
			end
			a_file.put_new_line
			Result := true
		end


	il_src_dump_type_name (a_file: FILE_STREAM; a_size: CIL_VALUE_SIZE)
		do
			inspect a_size
			when {CIL_VALUE_SIZE}.i8 then
				a_file.put_string (" int8")
			when {CIL_VALUE_SIZE}.i16 then
				a_file.put_string (" int16")
			when {CIL_VALUE_SIZE}.i32 then
				a_file.put_string (" int32")
			when {CIL_VALUE_SIZE}.i64 then
				a_file.put_string (" int64")
			else
				a_file.put_string (" int32")
			end
		ensure
			instance_free: class
		end

	pe_dump (a_stream: FILE_STREAM): BOOLEAN
		local
			l_sz: CELL [NATURAL_64]
			l_sig: ARRAY [NATURAL_8]
			l_sig_index: NATURAL_64
			l_name_index: NATURAL_64
			l_ref_parent: PE_MEMBER_REF_PARENT
			l_table: PE_TABLE_ENTRY_BASE
			l_pe_flags: INTEGER
			l_buf: SPECIAL [NATURAL_8]
			l_type: INTEGER
			l_value_index: NATURAL_64
			l_constant: PE_CONSTANT
			l_dis: NATURAL_64
		do
			if type.basic_type = {CIL_BASIC_TYPE}.class_ref then
				if attached {CIL_DATA_CONTAINER} type.type_ref as l_class and then
					l_class.in_assembly_ref
				then
					Result := l_class.pe_dump (a_stream)
				end
			end
			create l_sz.put (0)
			l_sig := {PE_SIGNATURE_GENERATOR_HELPER}.field_sig (Current, l_sz)
			if attached {PE_WRITER} a_stream.pe_writer as l_writer then
				l_sig_index := l_writer.hash_blob (l_sig, l_sz.item)
				pe_index := l_writer.hash_string (name)
				l_name_index := pe_index
				if in_assembly_ref then
					if attached parent as l_parent then
						Result := l_parent.pe_dump (a_stream)
					end
					create l_ref_parent.make_with_tag_and_index ({PE_MEMBER_REF_PARENT}.typeref, if attached parent as l_parent then l_parent.pe_index else {NATURAL_64}0 end)
					create {PE_MEMBER_REF_TABLE_ENTRY} l_table.make_with_data (l_ref_parent, l_name_index, l_sig_index)
					pe_index := l_writer.add_table_entry (l_table)
				else
					l_pe_flags := 0
					if flags.flags & {CIL_QUALIFIERS_ENUM}.public /= 0 then
						l_pe_flags := l_pe_flags | {PE_FIELD_TABLE_ENTRY}.public
					elseif flags.flags & {CIL_QUALIFIERS_ENUM}.private /= 0  then
						l_pe_flags := l_pe_flags | {PE_FIELD_TABLE_ENTRY}.private
					end

					if flags.flags & {CIL_QUALIFIERS_ENUM}.static /= 0  then
						l_pe_flags := l_pe_flags | {PE_FIELD_TABLE_ENTRY}.static
					end
					if flags.flags & {CIL_QUALIFIERS_ENUM}.literal /= 0  then
						l_pe_flags := l_pe_flags | {PE_FIELD_TABLE_ENTRY}.literal
					end

					inspect mode
					when {CIL_VALUE_MODE}.enum  then
						l_pe_flags := l_pe_flags | {PE_FIELD_TABLE_ENTRY}.hasdefault
							-- in the blob
					when {CIL_VALUE_MODE}.bytes  then
						if byte_length /= 0 and then not byte_value.is_empty then
							l_pe_flags := l_pe_flags | {PE_FIELD_TABLE_ENTRY}.hasfieldrva
						end
					when {CIL_VALUE_MODE}.none  then
							-- Should never get here.
					end

					create {PE_FIELD_TABLE_ENTRY} l_table.make_with_data (l_pe_flags, l_name_index, l_sig_index)
					pe_index := l_writer.add_table_entry (l_table)
					if attached parent as l_parent and then
						((l_parent.flags.flags & {CIL_QUALIFIERS_ENUM}.explicit /= 0) or else
						 (l_parent.flags.flags & {CIL_QUALIFIERS_ENUM}.sequential /= 0) and then
						 explicit_offset /= 0)
					then
						create {PE_FIELD_LAYOUT_TABLE_ENTRY} l_table.make_with_data (explicit_offset, pe_index)
						l_dis := l_writer.add_table_entry (l_table)
							-- l_dis  helper variable that will not be used.
					end

					create l_buf.make_filled (0, 8)
					{BYTE_ARRAY_HELPER}.put_array_integer_64 (l_buf, enum_value, 0)

					inspect mode
					when {CIL_VALUE_MODE}.none then
						-- Should never get here.
					when {CIL_VALUE_MODE}.enum then
						inspect size
						when {CIL_VALUE_SIZE}.i8 then
							l_sz.put (1)
							l_type :=  {PE_TYPES_ENUM}.element_type_i1
						when {CIL_VALUE_SIZE}.i16 then
							l_sz.put (2)
							l_type :=  {PE_TYPES_ENUM}.element_type_i2
						when {CIL_VALUE_SIZE}.i32 then
							l_sz.put (4)
							l_type :=  {PE_TYPES_ENUM}.element_type_i4
						when {CIL_VALUE_SIZE}.i64 then
							l_sz.put (8)
							l_type :=  {PE_TYPES_ENUM}.element_type_i8
						else
								-- default case
							l_sz.put (4)
							l_type :=  {PE_TYPES_ENUM}.element_type_i4
						end
						-- this is NOT compressed like the sigs are...
						l_value_index := l_writer.hash_blob (l_buf.to_array, l_sz.item)
						create l_constant.make_with_tag_and_index ({PE_CONSTANT}.fielddef, pe_index)
						create {PE_CONSTANT_TABLE_ENTRY} l_table.make_with_data (l_type, l_constant, l_value_index)
						l_dis := l_writer.add_table_entry (l_table)
						if not byte_value.is_empty and then
						   byte_length /= 0 then
						   	l_value_index := l_writer.rva_bytes (byte_value, byte_length.to_natural_64)
						   	create {PE_FIELD_RVA_TABLE_ENTRY} l_table.make_with_data (l_value_index, pe_index)
						   	l_dis := l_writer.add_table_entry (l_table)
						end
					when {CIL_VALUE_MODE}.bytes then
						if not byte_value.is_empty and then
						   byte_length /= 0 then
						   	l_value_index := l_writer.rva_bytes (byte_value, byte_length.to_natural_64)
						   	create {PE_FIELD_RVA_TABLE_ENTRY} l_table.make_with_data (l_value_index, pe_index)
						   	l_dis := l_writer.add_table_entry (l_table)
						end
					end
				end
			end
			Result := True
		end

feature {NONE} -- Utils

	format_integer (w: INTEGER; a_char: CHARACTER): FORMAT_INTEGER
		do
			create Result.make(w)
			Result.set_fill(a_char)
		ensure
			is_class: class
		end

end
