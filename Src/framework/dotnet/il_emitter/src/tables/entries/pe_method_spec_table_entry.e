note
	description: "Object representig the The MethodSpec table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=MethodSpec", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=264&zoom=100,116,876", "protocol=uri"

class
	PE_METHOD_SPEC_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			token_from_tables
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_method: PE_METHOD_DEF_OR_REF; a_instantiation: NATURAL_64)
		do
			method := a_method
			create instantiation.make_with_index (a_instantiation)
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
					e.method.is_equal (method) and then
					e.instantiation.is_equal (instantiation)
				then
					Result := n
				end
			end
		end

feature -- Access

	method: PE_METHOD_DEF_OR_REF
			-- an index into the MethodDef or MemberRef table, specifying to which
			-- generic method this row refers; that is, which generic method this row is an
			-- instantiation of; more precisely, a MethodDefOrRef

	instantiation: PE_BLOB
			-- an index into the Blob heap
			-- holding the signature of this instantiation.

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tMethodSpec.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			l_bytes := method.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + instantiation.render (a_sizes, a_dest, l_bytes.to_integer_32)

			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			l_bytes := method.get (a_sizes, a_src, 0)
			l_bytes := l_bytes + instantiation.get (a_sizes, a_src, l_bytes.to_integer_32)

			Result := l_bytes
		end

end

