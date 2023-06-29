note
	description: "Object representing the MethodImpl table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=MethodImpl", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=262&zoom=100,116,838", "protocol=uri"

class
	PE_METHOD_IMPL_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_cls: NATURAL_32; a_method_body: PE_METHOD_DEF_OR_REF; a_method_dec: PE_METHOD_DEF_OR_REF)
		do
			create class_.make_with_index (a_cls)
			method_body := a_method_body
			method_declaration := a_method_dec
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| There shall be no duplicate rows, based upon Class + MethodDeclaration
		do
			Result := Precursor (e)
				or else (
					e.class_.is_equal (class_) and then
					e.method_declaration.is_equal (method_declaration)
				)
		end

	less_than (other: like Current): BOOLEAN
			-- Is Current less than `other` in associated table?
		do
			Result := class_.less_than_index (other.class_)
		end

feature -- Access

	class_: PE_TYPE_DEF
			-- an index into the TypeDef table.

	method_body: PE_METHOD_DEF_OR_REF
			-- an index into the MethodDef or MemberRef table;
			-- more precisely a MethodDefOrRef

	method_declaration: PE_METHOD_DEF_OR_REF
			-- an index into the MethodDef or MemberRef table
			-- more precisely, a MethodDefOrRef

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tMethodimpl
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write class, method_body and method_declaration to the buffer and update the number of bytes.
			l_bytes := class_.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + method_body.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + method_declaration.render (a_sizes, a_dest, l_bytes)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Read class, method_body and method_declaration from the buffer and update the number of bytes.
			l_bytes := class_.get (a_sizes, a_src, 0)
			l_bytes := l_bytes + method_body.get (a_sizes, a_src, l_bytes)
			l_bytes := l_bytes + method_declaration.get (a_sizes, a_src, l_bytes)

				-- Return the number of bytes written
			Result := l_bytes
		end

end

