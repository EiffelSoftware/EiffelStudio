class
	PE_MD_TABLE_INTERFACEIMPL_ENTRY

inherit
	PE_MD_TABLE_COMPARABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (2, "InterfaceImpl")
			structure := struct
			struct.add_type_def_index ("Class")
			struct.add_type_def_or_ref_or_spec ("Interface")
		end

feature -- Access

	class_index: detachable PE_TYPE_DEF_INDEX_ITEM
		local
			i: PE_ITEM
		do
			i := structure.index_item ("Class")
			if attached {PE_TYPE_DEF_INDEX_ITEM} i as t then
				Result := t
			else
				check is_typedef_or_void: i = Void end
			end
		end

	interface_index: detachable PE_INDEX_ITEM
		do
			if attached {like interface_index} structure.item ("Interface") as i then
				Result := i
			end
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			-- Primary key: Class, then Interface
			if attached class_index as i1 then
				if attached other.class_index as i2 then
					if i1.sorting_index = i2.sorting_index then
						Result := index_is_less_than (interface_index, other.interface_index)
					else
						Result := index_is_less_than (i1, i2)
					end
				end
			elseif attached other.class_index as i2 then
				Result := True
			else
				Result := index_is_less_than (interface_index, other.interface_index)
			end
--			Result := index_is_less_than (class_index, other.class_index)
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tinterfaceimpl
		end

end
