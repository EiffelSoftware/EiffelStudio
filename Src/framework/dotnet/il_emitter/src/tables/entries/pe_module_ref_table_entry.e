note
	description: "Object representing the ModuleRef table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=ModuleRef", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=265&zoom=100,116,945", "protocol=uri"

class
	PE_MODULE_REF_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_name_index: NATURAL_32)
		do
			create name_index.make_with_index(a_name_index)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| There should be no duplicate rows.

		do
			Result := Precursor (e)
				or else (
					e.name_index.is_equal (name_index)
				)
		end

feature -- Access

	name_index: PE_STRING
			-- an index into the String heap.

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tModuleref
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		do
			Result := name_index.render (a_sizes, a_dest, 0)
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		do
			Result := name_index.get (a_sizes, a_src, 0)
		end

end
