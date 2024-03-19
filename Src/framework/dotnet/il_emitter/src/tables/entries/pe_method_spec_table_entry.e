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
			same_as
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_method: PE_METHOD_DEF_OR_REF; a_instantiation: NATURAL_32)
		do
			method := a_method
			create instantiation.make_with_index (a_instantiation)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| There shall be no duplicate rows based upon Method +I nstantiation.
		do
			Result := Precursor (e)
				or else (
					e.method.is_equal (method) and then
					e.instantiation.is_equal (instantiation)
				)
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

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tMethodSpec
		end

	render (a_sizes: SPECIAL [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
			l_bytes := method.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + instantiation.render (a_sizes, a_dest, l_bytes)

			Result := l_bytes
		end

	rendering_size (a_sizes: SPECIAL [NATURAL_32]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
			l_bytes := method.rendering_size (a_sizes)
			l_bytes := l_bytes + instantiation.rendering_size (a_sizes)

			Result := l_bytes
		end

end

