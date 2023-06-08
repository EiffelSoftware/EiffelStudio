note
	description: "[
					A class, note that it cannot contain namespaces which is enforced at compile time
			    	note that all classes have to eventually derive from one of the System base classes
			     	but that is handled internally 
			     	Enums derive from this
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_CLASS

inherit

	CIL_DATA_CONTAINER
		rename
			make as make_container
		redefine
			il_src_dump,
			pe_dump,
			traverse
		select
			il_src_dump,
			pe_dump,
			traverse
		end

	CIL_DATA_CONTAINER
		rename
			make as make_container,
			pe_dump as pe_dump_dc,
			il_src_dump as il_src_dump_dc,
			traverse as traverse_dc
		end


	REFACTORING_HELPER

create
	make,
	make_from_class

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_flags: CIL_QUALIFIERS; a_pack: INTEGER; a_size: INTEGER)
		do
			make_container (a_name, a_flags)
			create extends_name.make_empty
			create {ARRAYED_LIST [CIL_TYPE]} generics.make (0)
			create {ARRAYED_LIST [CIL_PROPERTY]} properties.make (0)
			pack := a_pack
			size := a_size
		ensure
			pack_set: pack = a_pack
			size_set: size = a_size
			flags_set: flags = a_flags
			name_set: name = a_name
			extend_from_void: extend_from = Void
			generic_parent_void: generic_parent = Void
			is_external_false: not is_external
			properties_empty: properties.is_empty
			generics_empty: generics.is_empty
		end

	make_from_class (a_class: CIL_CLASS)
		do
			make_container (a_class.name, a_class.flags)
			generic_parent := a_class.generic_parent
			is_external := a_class.is_external
			extend_from := a_class.extend_from
			size := a_class.size
			pack := a_class.pack
			generics := a_class.generics
			extends_name := a_class.extends_name
			properties := a_class.properties
		end

feature -- Access

	generic_parent: detachable CIL_CLASS assign set_generic_parent
			-- `generic_parent'

	is_external: BOOLEAN assign set_is_external
			-- `is_external'
			--| Correspond to external_

	extend_from: detachable CIL_CLASS assign set_extend_from
			-- `extend_from'

	size: INTEGER assign set_size
			-- the structure size.

	pack: INTEGER assign set_pack
			-- the structure packing.

	generics: LIST [CIL_TYPE]
			-- The list of generics.

	extends_name: STRING_32
			-- The name of a class which is being extended from

	properties: LIST [CIL_PROPERTY]
			-- The list of properties.

feature -- Element change

	set_generic_parent (a_generic_parent: like generic_parent)
			-- Assign `generic_parent' with `a_generic_parent'.
		do
			generic_parent := a_generic_parent
		ensure
			generic_parent_assigned: generic_parent = a_generic_parent
		end

	set_is_external (an_is_external: like is_external)
			-- Assign `is_external' with `an_is_external'.
		do
			is_external := an_is_external
		ensure
			is_external_assigned: is_external = an_is_external
		end

	set_extend_from (an_extend_from: like extend_from)
			-- Assign `extend_from' with `an_extend_from'.
			--| set the class we are extending from, if this is unset
			--| a system class will be chosen based on whether or not the class is a valuetype
			--| this may be unset when reading in an assembly, in that case ExtendsName
			--| may give the name of a class which is being extended from
		do
			extend_from := an_extend_from
		ensure
			extend_from_assigned: extend_from = an_extend_from
		end

	set_generics (a_generics: LIST [CIL_TYPE])
			-- Set `generics` with `a_generics`.
		do
			generics := a_generics
		ensure
			generics_set: generics = a_generics
		end

	set_extends_name (a_name: STRING_32)
			-- Set `extends_name' with `a_name`
		do
			extends_name := a_name
		ensure
			extends_name_set: extends_name = a_name
		end

	set_size (a_size: like size)
			-- Assign `size' with `a_size'.
		do
			size := a_size
		ensure
			size_assigned: size = a_size
		end

	set_pack (a_pack: like pack)
			-- Assign `pack' with `a_pack'.
		do
			pack := a_pack
		ensure
			pack_assigned: pack = a_pack
		end

	add_property (a_property: CIL_PROPERTY; a_add: BOOLEAN)
			-- Add a property `a_property` to this container.
		do
			a_property.set_container (Current, a_add)
			properties.force (a_property)
		end

feature -- Status Report

	matches_generic (a_generics: detachable LIST [CIL_TYPE]): BOOLEAN
		local
			exit: BOOLEAN
			i: INTEGER
		do
			if attached a_generics then

				if generics.count = a_generics.count then
					from
						i := 1
					until
						exit or else i > generics.count
					loop
						if not generics.at (i).matches (a_generics.at (i)) then
							exit := True
						end
						i := i + 1
					end
					if i > generics.count then
						Result := True
					end
				end

			end
		end

	transfer_flags: INTEGER
		local
			l_pe_flags: INTEGER
		do
			l_pe_flags := {PE_TYPE_DEF_TABLE_ENTRY}.class_
			if attached {CIL_CLASS} parent as l_parent then
				if flags.flags & {CIL_QUALIFIERS_ENUM}.public /= 0 then
					l_pe_flags := l_pe_flags | {PE_TYPE_DEF_TABLE_ENTRY}.nestedpublic
				else
					l_pe_flags := l_pe_flags | {PE_TYPE_DEF_TABLE_ENTRY}.nestedprivate
				end
			else
				if flags.flags & {CIL_QUALIFIERS_ENUM}.public /= 0 then
					l_pe_flags := l_pe_flags | {PE_TYPE_DEF_TABLE_ENTRY}.public
				end
			end

			if flags.flags & {CIL_QUALIFIERS_ENUM}.sequential /= 0 then
				l_pe_flags := l_pe_flags | {PE_TYPE_DEF_TABLE_ENTRY}.sequentiallayout
			end

			if flags.flags & {CIL_QUALIFIERS_ENUM}.explicit /= 0 then
				l_pe_flags := l_pe_flags | {PE_TYPE_DEF_TABLE_ENTRY}.explicitlayout
			end

			if flags.flags & {CIL_QUALIFIERS_ENUM}.sealed /= 0 then
				l_pe_flags := l_pe_flags | {PE_TYPE_DEF_TABLE_ENTRY}.sealed
			end
			if flags.flags & {CIL_QUALIFIERS_ENUM}.ansi /= 0 then
				l_pe_flags := l_pe_flags | {PE_TYPE_DEF_TABLE_ENTRY}.ansiclass
			end
			Result := l_pe_flags
		end

feature -- Operation

	traverse (a_callback: CIL_CALLBACK): BOOLEAN
			-- <Precursor>
		local
			exit: BOOLEAN
		do
			if not Precursor (a_callback) then
				Result := True
			else
				across properties as p until exit loop
					if not a_callback.enter_property (p) then
						Result := False
					end
				end
			end
			if not exit then
				Result := True
			end
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			il_src_dump_class_header (a_file)
			if attached extend_from as l_extend_form then
				a_file.put_string (" extends ")
				a_file.put_string ({CIL_QUALIFIERS}.name ("", l_extend_form, False))
				a_file.put_string (l_extend_form.adorn_generics (False))
			end
			a_file.put_string (" {")
			if pack > 0 or else size > 0 then
				a_file.put_new_line
				if pack > 0 then
					a_file.put_string (" .pack ")
					a_file.put_integer (pack)
				end
				if size >= 0 then
					a_file.put_string (" .size ")
					a_file.put_integer (size)
				end
			end
			a_file.put_new_line
			Result := Precursor (a_file)
			a_file.put_new_line
			across properties as p loop
				Result := p.il_src_dump (a_file)
			end
			a_file.put_string ("}")
			a_file.put_new_line
			Result := True
		end

	il_src_dump_class_header (a_file: FILE_STREAM)
		do
			a_file.put_string (".class")
			if attached {CIL_CLASS} parent as l_parent then
				a_file.put_string (" nested")
			end
			flags.il_src_dump_before_flags (a_file)
			flags.il_src_dump_after_flags (a_file)
			a_file.put_string (" '")
			a_file.put_string (name)
			a_file.put_string ("'")
			a_file.put_string (adorn_generics (True))
		end

	adorn_generics (a_names: BOOLEAN): STRING_32
		local
			l_type: CIL_TYPE
			l_file: FILE_STREAM
			bool: BOOLEAN
		do
			create l_file.make_temp
			create Result.make_empty
			if not generics.is_empty then
				Result.append ("<")
				across generics as it loop
					if a_names and then it.basic_type = {CIL_BASIC_TYPE}.type_var then
						Result.append_character ('A' + (it.var_num // 26))
						Result.append_character ('A' + (it.var_num \\ 26))
					else
						l_type := it
						l_type.show_type := True
						bool := l_type.il_src_dump (l_file)
					end
					if @ it.target_index + 1 /= @ it.last_index then
						l_file.put_string (",")
					else
						l_file.put_string (">")
					end
				end
			end
			Result := l_file.text
			l_file.close
		end

	pe_dump (a_stream: FILE_STREAM): BOOLEAN
		do
			if not generics.is_empty and then
				generics.first.basic_type /= {CIL_BASIC_TYPE}.type_var
			then
				pe_dump_generics (a_stream)
			elseif in_assembly_ref then
				pe_dump_assembly_ref (a_stream)
			else
				pe_dump_default (a_stream)
			end
			Result := True

		end

feature {NONE} -- Implementation

	pe_dump_generics (a_stream: FILE_STREAM)
		local
			l_val: SPECIAL [NATURAL_8]
			l_dis: INTEGER
			l_sz: CELL [NATURAL_32]
			l_type: CIL_TYPE
			l_sig: ARRAY [NATURAL_8]
			l_signature: NATURAL_32
			l_table: PE_TYPE_SPEC_TABLE_ENTRY
			l_result: BOOLEAN
		do
			if pe_index /= 0 then
				if attached {CIL_CLASS} generic_parent as l_generic_parent and then
					l_generic_parent.pe_index = 0 -- !genericParent_->PEIndex()
				then
					l_result := l_generic_parent.pe_dump (a_stream)
				end
				if not generics.is_empty then
					across generics as l_gen loop
						if l_gen.basic_type = {CIL_BASIC_TYPE}.class_ref and then l_gen.pe_index = 0 then
							create l_val.make_filled (0, 8)
								-- we create an special object with 8 slots
								-- since size_t could have 8 bytes.
							l_dis := l_gen.render (a_stream, l_val, 0)
							l_gen.set_pe_index ({BYTE_SPECIAL_HELPER}.byte_special_to_natural_32 (l_val, 0))
						end
					end
				end
				create l_sz.put (0)
				create l_type.make_with_container (Current)
				l_sig := {PE_SIGNATURE_GENERATOR_HELPER}.type_sig (l_type, l_sz)
				if attached {PE_WRITER} a_stream.pe_writer as l_writer then
					l_signature := l_writer.hash_blob (l_sig, l_sz.item)
					create l_table.make_with_data (l_signature)
					pe_index := l_writer.add_table_entry (l_table)
				end
			end
		end

	pe_dump_assembly_ref (a_stream: FILE_STREAM)
		local
			l_resolution: PE_RESOLUTION_SCOPE
			l_typename_index: NATURAL_32
			l_table: PE_TABLE_ENTRY_BASE
			l_namespace_index: NATURAL_32
			l_result: BOOLEAN
		do
			if pe_index = 0 then
				if attached {CIL_CLASS} parent as l_class then
						-- This is a nested class
					l_result := l_class.pe_dump (a_stream)
					create l_resolution.make_with_tag_and_index ({PE_RESOLUTION_SCOPE}.TypeRef, l_class.pe_index)
					if attached {PE_WRITER} a_stream.pe_writer as l_writer then
						l_typename_index := l_writer.hash_string (name)
						create {PE_TYPE_REF_TABLE_ENTRY} l_table.make_with_data (l_resolution, l_typename_index, 0)
						pe_index := l_writer.add_table_entry (l_table)
					end
				else
						-- This is a top level class in an assembly
					create l_resolution.make_with_tag_and_index ({PE_RESOLUTION_SCOPE}.assemblyref, parent_assembly (a_stream))
					if attached {PE_WRITER} a_stream.pe_writer as l_writer then
						l_typename_index := l_writer.hash_string (name)
						l_namespace_index := parent_namespace (a_stream)
						create {PE_TYPE_REF_TABLE_ENTRY} l_table.make_with_data (l_resolution, l_typename_index, l_namespace_index)
						pe_index := l_writer.add_table_entry (l_table)
					end
				end
			end
		end

	pe_dump_default (a_stream: FILE_STREAM)
		local
			l_pe_flags: INTEGER
			l_typename_index: NATURAL_32
			l_namespace_index: NATURAL_32
			l_extends: NATURAL_32
			l_field_index: NATURAL_32
			l_method_index: NATURAL_32
			l_parent: CIL_DATA_CONTAINER
			l_result: BOOLEAN
			l_type_type: INTEGER
			l_extends_class: PE_TYPEDEF_OR_REF
			l_table: PE_TABLE_ENTRY_BASE
			l_my_pack: INTEGER
			l_my_size: INTEGER
			l_dis: NATURAL_32
			l_enclosing: NATURAL_32
			l_property_index: NATURAL_32
			l_owner: PE_TYPE_OR_METHOD_DEF
			l_name: STRING_32
			l_char_A: CHARACTER_32
			l_name_str: NATURAL_32
		do
			l_pe_flags := transfer_flags
			if attached {PE_WRITER} a_stream.pe_writer as l_writer then
				l_typename_index := l_writer.hash_string (name)
				l_namespace_index := parent_namespace (a_stream)
				l_extends := if flags.flags & {CIL_QUALIFIERS_ENUM}.value /= 0 then l_writer.value_base else l_writer.object_base end
				l_field_index := l_writer.next_table_index ({PE_TABLES}.tfield)
				l_method_index := l_writer.next_table_index ({PE_TABLES}.tmethoddef)
				l_parent := parent
				if attached {CIL_CLASS} extend_from as l_extend_from then
					if l_extend_from.pe_index = 0 then
						l_result := l_extend_from.pe_dump (a_stream)
					end
					l_extends := l_extend_from.pe_index
				end
				if attached {CIL_CLASS} l_parent as ll_parent then
					l_namespace_index := 0
				end
				l_type_type := {PE_TYPEDEF_OR_REF}.typeref
				if attached {CIL_CLASS} extend_from as l_extend_from and then not l_extend_from.in_assembly_ref then
					l_type_type := {PE_TYPEDEF_OR_REF}.typedef
				end
				create l_extends_class.make_with_tag_and_index (l_type_type, l_extends)
				create {PE_TYPE_DEF_TABLE_ENTRY} l_table.make_with_data (l_pe_flags, l_typename_index, l_namespace_index, l_extends_class, l_field_index, l_method_index)
				pe_index := l_writer.add_table_entry (l_table)

				if pack > 0 or else size > 0 then
					l_my_pack := pack
					l_my_size := size

					if l_my_pack <= 0 then
						l_my_pack := 1
					end
					if l_my_size <= 0 then
						l_my_size := 1
					end
					create {PE_CLASS_LAYOUT_TABLE_ENTRY} l_table.make_with_data (l_my_pack.to_natural_16, l_my_size.to_natural_32, pe_index)
					l_dis := l_writer.add_table_entry (l_table)
				end
				if attached {CIL_CLASS} l_parent as ll_parent then
					l_enclosing := parent_class (a_stream)
					create {PE_NESTED_CLASS_TABLE_ENTRY} l_table.make_with_data (pe_index, l_enclosing)
					l_dis := l_writer.add_table_entry (l_table)
				end

					-- Call the {CIL_DATA_CONTAINER}.pe_dump version.
				l_result := pe_dump_dc (a_stream)
					-- properties
				if not properties.is_empty then
					l_property_index := l_writer.next_table_index ({PE_TABLES}.tproperty)
					create {PE_PROPERTY_MAP_TABLE_ENTRY} l_table.make_with_data (pe_index, l_property_index)
					l_dis := l_writer.add_table_entry (l_table)
					across properties as p loop
						l_result := p.pe_dump (a_stream)
					end
				end
					-- generics
				if not generics.is_empty then
					create l_owner.make_with_tag_and_index ({PE_TYPE_OR_METHOD_DEF}.typedef, pe_index)
					l_char_A := 'A'
					create l_name.make_empty

					across 0 |..| (generics.count - 1) as i loop
						l_name.append_character (((i // 26) + l_char_A.code).to_character_32)
						l_name.append_character (((i \\ 26) + l_char_A.code).to_character_32)
						l_name_str := l_writer.hash_string (l_name)
						create {PE_GENERIC_PARAM_TABLE_ENTRY} l_table.make_with_data (i.to_natural_16, 0, l_owner, l_name_str)
						fixme ("Doube check the index i when we create l_table. ")
						l_dis := l_writer.add_table_entry (l_table)
					end
				end
			end
		end

end
