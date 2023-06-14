note
	description: "Object representing The NestedClass table "
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=NestedClass",  "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=266&zoom=100,116,320", "protocol=uri"

class
	PE_NESTED_CLASS_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_nested: NATURAL_32; a_enclosing: NATURAL_32)
		do
			create nested_index.make_with_index (a_nested)
			create enclosing_index.make_with_index (a_enclosing)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.nested_index.is_equal (nested_index) and then
					e.enclosing_index.is_equal (enclosing_index)
				)
		end

feature -- Access

	nested_index: PE_TYPE_DEF
			-- an index into the TypeDef table.

	enclosing_index: PE_TYPE_DEF
			-- an index into the TypeDef table

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tNestedClass
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
			l_bytes := nested_index.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + enclosing_index.render (a_sizes, a_dest, l_bytes)
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
			l_bytes := nested_index.get (a_sizes, a_src, 0)
			l_bytes := l_bytes + enclosing_index.get (a_sizes, a_src, l_bytes)
			Result := l_bytes
		end

end
