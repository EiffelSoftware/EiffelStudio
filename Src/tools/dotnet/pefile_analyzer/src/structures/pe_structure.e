note
	description: "Summary description for {PE_STRUCTURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_STRUCTURE

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER; lab: like label)
		do
			label := lab
			create structure_items.make (nb)
			create items.make (structure_items.count)
		end

feature -- Access

	label: READABLE_STRING_8

	structure_items: ARRAYED_LIST [PE_STRUCTURE_ITEM]

	items: ARRAYED_LIST [PE_ITEM]

feature -- Access

	index_item (lab: READABLE_STRING_GENERAL): detachable PE_INDEX_ITEM
		require
			is_index_item (lab)
		do
			if attached {PE_INDEX_ITEM} item (lab) as i then
				Result := i
			end
		end

	string_item (lab: READABLE_STRING_GENERAL): detachable PE_STRING_ITEM
		require
			is_string_item (lab)
		do
			if attached {PE_STRING_ITEM} item (lab) as i then
				Result := i
			end
		end

	natural_16_item (lab: READABLE_STRING_GENERAL): detachable PE_NATURAL_16_ITEM
		require
			is_natural_16_item (lab)
		do
			if attached {PE_NATURAL_16_ITEM} item (lab) as i then
				Result := i
			end
		end

	natural_32_item (lab: READABLE_STRING_GENERAL): detachable PE_NATURAL_32_ITEM
		require
			is_natural_32_item (lab)
		do
			if attached {PE_NATURAL_32_ITEM} item (lab) as i then
				Result := i
			end
		end

	item (lab: READABLE_STRING_GENERAL): detachable PE_ITEM
		do
			across
				items as ic
			until
				Result /= Void
			loop
				if lab.is_case_insensitive_equal (ic.item.label) then
					Result := ic.item
				end
			end
		end

feature -- Status report

	is_string_item (lab: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := attached {PE_STRING_ITEM} item (lab)
		end

	is_natural_16_item (lab: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := attached {PE_NATURAL_16_ITEM} item (lab)
		end

	is_natural_32_item (lab: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := attached {PE_NATURAL_32_ITEM} item (lab)
		end

	is_index_item (lab: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := attached {PE_INDEX_ITEM} item (lab)
		end

feature -- Constants

--	column_separator: STRING = " | "
	column_separator: STRING = "%T|"
	first_column_separator: STRING = "%T"
	last_column_separator: STRING = "" -- %T|"

	empty_string: STRING_32 = ""

feature -- Read

	read (pe: PE_FILE)
		local
			l_pe_item: PE_ITEM
			sti: PE_STRUCTURE_ITEM
		do
			across
				structure_items as ic
			loop
				sti := ic.item
				l_pe_item := sti.read (pe)
				l_pe_item.set_associated_structure (sti)

				items.force (l_pe_item)
			end
			check structure_items.count = items.count end
		end

	has_error: BOOLEAN
		do
			across
				items as ic
			until
				Result
			loop
				Result := ic.item.has_error
			end
		end

	errors: ARRAYED_LIST [PE_ERROR]
		require
			has_error
		do
			create Result.make (1)
			across
				items as ic
			loop
				if attached ic.item.error as err then
					Result.force (err)
				end
			end
		end

feature -- Conversion

	to_string: STRING_32
		local
			l_is_first: BOOLEAN
		do
			Result := {STRING_32} "{"+ label +"}:"
			l_is_first := True
			across
				items as ic
			loop
				if l_is_first then
					Result.append (first_column_separator)
					l_is_first := False
				else
					Result.append (column_separator)
				end
				Result.append (item_to_string (ic.item))
			end
			Result.append (last_column_separator)
		end

	to_string_array: ARRAY [like to_string]
		local
			i,n: INTEGER
		do
			create Result.make_filled (empty_string, 0, structure_items.count)
			Result [0] := {STRING_32} "{"+ label +"}"
			i := 1
			across
				items as ic
			loop
				Result [i] := item_to_string (ic.item)
				i := i + 1
			end
		end

	item_to_string (i: PE_ITEM): STRING_32
		do
			Result := i.to_string
			if attached i.info as inf then
				if inf.is_link then
					Result := Result + {STRING_32} " @" + inf.text
				else
					Result := Result + {STRING_32} " %"" + inf.text + "%""
				end
			end
		end

	dump: STRING_8
		do
			create Result.make (items.count * 3)
			across
				items as ic
			loop
				if Result.is_empty then
					Result.append (first_column_separator)
				else
					Result.append (column_separator)
				end
				Result.append (ic.item.dump)
			end
			Result.append (last_column_separator)
		end

	description_as_array: ARRAY [READABLE_STRING_GENERAL]
		local
			i,n: INTEGER
		do
			create Result.make (0, structure_items.count)
			Result [0] := "Columns"
			i := 1
			across
				structure_items as ic
			loop
				Result [i] := ic.item.label
			end
		end

	description: STRING_8
		do
			create Result.make (structure_items.count * 5)
			across
				structure_items as ic
			loop
				if Result.is_empty then
					Result.append (first_column_separator)
				else
					Result.append (column_separator)
				end
				Result.append (ic.item.label)
			end
			Result.append (last_column_separator)
		end

feature -- Element change

	add (i: PE_STRUCTURE_ITEM)
		do
			structure_items.force (i)
		end

	add_rva (lab: STRING)
		do
			add (create {PE_RVA}.make (lab))
		end

	add_flags_16 (lab: STRING)
		do
			add (create {PE_FLAGS_16}.make (lab))
		end

	add_flags_32 (lab: STRING)
		do
			add (create {PE_FLAGS_32}.make (lab))
		end

	add_type_attributes (lab: STRING)
		do
			add (create {PE_TYPE_ATTRIBUTES}.make (lab))
		end

	add_field_attributes (lab: STRING)
		do
			add (create {PE_FIELD_ATTRIBUTES}.make (lab))
		end

	add_method_attributes (lab: STRING)
		do
			add (create {PE_METHOD_ATTRIBUTES}.make (lab))
		end

	add_method_semantics_attributes (lab: STRING)
		do
			add (create {PE_METHOD_SEMANTICS_ATTRIBUTES}.make (lab))
		end

	add_method_impl_attributes (lab: STRING)
		do
			add (create {PE_METHOD_IMPL_ATTRIBUTES}.make (lab))
		end

	add_param_attributes (lab: STRING)
		do
			add (create {PE_PARAM_ATTRIBUTES}.make (lab))
		end

	add_property_attributes (lab: STRING)
		do
			add (create {PE_PROPERTY_ATTRIBUTES}.make (lab))
		end

	add_string_index (lab: STRING)
		do
			add (create {PE_STRING_INDEX}.make (lab))
		end

	add_index (lab: STRING)
		do
			add (create {PE_INDEX}.make (lab))
		end

	add_blob_index (lab: STRING)
		do
			add (create {PE_BLOB_INDEX}.make (lab))
		end

	add_type_specification_signature_blob_index (lab: STRING)
		do
			add (create {PE_SIGNATURE_BLOB_INDEX}.make_type_specification (lab))
		end
	add_method_signature_blob_index (lab: STRING)
		do
			add (create {PE_SIGNATURE_BLOB_INDEX}.make_method (lab))
		end
	add_method_or_locals_signature_blob_index (lab: STRING)
		do
			add (create {PE_SIGNATURE_BLOB_INDEX}.make_method_or_locals (lab))
		end
	add_field_or_method_signature_blob_index (lab: STRING)
		do
			add (create {PE_SIGNATURE_BLOB_INDEX}.make_field_or_method (lab))
		end
	add_field_signature_blob_index (lab: STRING)
		do
			add (create {PE_SIGNATURE_BLOB_INDEX}.make_field (lab))
		end
	add_locals_signature_blob_index (lab: STRING)
		do
			add (create {PE_SIGNATURE_BLOB_INDEX}.make_locals (lab))
		end
	add_property_signature_blob_index (lab: STRING)
		do
			add (create {PE_SIGNATURE_BLOB_INDEX}.make_property (lab))
		end

	add_guid_index (lab: STRING)
		do
			add (create {PE_GUID_INDEX}.make (lab))
		end

	add_type_def_index (lab: STRING)
		do
			add (create {PE_TYPE_DEF_INDEX}.make (lab))
		end

	add_type_def_or_ref_or_spec (lab: STRING)
		do
			add (create {PE_TYPE_DEF_OR_REF_OR_SPEC_INDEX}.make (lab))
		end

	add_has_constant (lab: STRING)
		do
			add (create {PE_HAS_CONSTANT_INDEX}.make (lab))
		end

	add_resolution_scope (lab: STRING)
		do
			add (create {PE_RESOLUTION_SCOPE_INDEX}.make (lab))
		end

	add_custom_attribute_type_index (lab: STRING)
		do
			add (create {PE_CUSTOM_ATTRIBUTE_TYPE_INDEX}.make (lab))
		end

	add_has_custom_attribute_index (lab: STRING)
		do
			add (create {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.make (lab))
		end

	add_has_semantic (lab: STRING)
		do
			add (create {PE_HAS_SEMANTIC_INDEX}.make (lab))
		end

	add_event_list_index (lab: STRING)
		do
			add (create {PE_EVENT_LIST_INDEX}.make (lab))
		end

	add_field_list_index (lab: STRING)
		do
			add (create {PE_FIELD_LIST_INDEX}.make (lab))
		end

	add_field_index (lab: STRING)
		do
			add (create {PE_FIELD_INDEX}.make (lab))
		end

	add_method_def_index (lab: STRING)
		do
			add (create {PE_METHOD_DEF_INDEX}.make (lab))
		end

	add_method_def_list_index (lab: STRING)
		do
			add (create {PE_METHOD_DEF_LIST_INDEX}.make (lab))
		end

	add_method_def_or_member_ref_index (lab: STRING)
		do
			add (create {PE_METHOD_DEF_OR_MEMBER_REF_INDEX}.make (lab))
		end

--	add_param_index (lab: STRING)
--		do
--			add (create {PE_PARAM_INDEX}.make (lab))
--		end

	add_param_list_index (lab: STRING)
		do
			add (create {PE_PARAM_LIST_INDEX}.make (lab))
		end

	add_property_index (lab: STRING)
		do
			add (create {PE_PROPERTY_INDEX}.make (lab))
		end

	add_property_list_index (lab: STRING)
		do
			add (create {PE_PROPERTY_LIST_INDEX}.make (lab))
		end

	add_natural_32 (lab: STRING)
		do
			add (create {PE_NATURAL_32}.make (lab))
		end

	add_natural_16 (lab: STRING)
		do
			add (create {PE_NATURAL_16}.make (lab))
		end

	add_natural_8 (lab: STRING)
		do
			add (create {PE_NATURAL_8}.make (lab))
		end

end
