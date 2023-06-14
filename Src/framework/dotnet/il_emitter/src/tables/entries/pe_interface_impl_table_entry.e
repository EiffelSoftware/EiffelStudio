note
	description: "Object representing The InterfaceImpl table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Interface Impl", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=257&zoom=100,116,256", "protocol=uri"

class
	PE_INTERFACE_IMPL_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Intialization	

	make_with_data (a_cls: NATURAL_32; a_interface: PE_TYPEDEF_OR_REF)
		do
			create class_.make_with_index (a_cls)
			interface := a_interface
		end

feature -- Status

	token_searching_supported: BOOLEAN = True

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--
			--| There should be no duplicates in the InterfaceImpl table, based upon non-null Class
			--|	and Interface values.
			--| There can be many rows with the same value for Class (since a class can implement
			--| many interfaces)
			--| There can be many rows with the same value for Interface (since many classes can
			--| implement the same interface)
		do
				-- TODO review the implementation.
				-- Double check if we need to check for
				-- class_ index is not valid (ie. index -> 0)
			Result := Precursor (e)
				or else (
					e.class_.is_equal (class_) and then
					e.interface.is_equal (interface)
				)
		end

feature -- Access

	class_: PE_TYPE_DEF
			-- an index into the TypeDef table
			-- Class shall be non-null.

	interface: PE_TYPEDEF_OR_REF
			-- an index into the TypeDef, TypeRef, or TypeSpec table

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tinterfaceimpl
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write the class_ to the buffer and update the number
				-- of bytes.
			l_bytes := class_.render (a_sizes, a_dest, 0)

				-- Write the interface to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes +  interface.render (a_sizes, a_dest, l_bytes)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Get the class_ from the buffer and update the number
				-- of bytes.
			l_bytes := class_.get (a_sizes, a_Src, 0)

				-- Read the interface to the buffer and update the number
				-- of bytes.
			l_bytes := l_bytes + interface.get (a_sizes, a_src, l_bytes)

				-- Return the number of bytes readed
			Result := l_bytes
		end


end
