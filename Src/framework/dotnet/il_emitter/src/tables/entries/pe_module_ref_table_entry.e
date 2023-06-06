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
			token_from_tables
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_name_index: NATURAL_64)
		do
			create name_index.make_with_index(a_name_index)
		end

feature -- Status

	token_from_tables (tables: MD_TABLES): NATURAL_64
			-- If Current was already defined in `tables` return the associated token.
		local
			lst: LIST [PE_TABLE_ENTRY_BASE]
			n: NATURAL_64
		do
			lst := tables.table
			n := 0
			across
				lst as i
			until
				Result /= {NATURAL_64} 0
			loop
				n := n + 1
				if
					attached {like Current} i as e and then
					e.name_index.is_equal (name_index)
				then
					Result := n
				end
			end
		end

feature -- Access

	name_index: PE_STRING
			-- an index into the String heap.

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tModuleref.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		do
			Result := name_index.render (a_sizes, a_dest, 0)
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		do
			Result := name_index.get (a_sizes, a_src, 0)
		end

end
