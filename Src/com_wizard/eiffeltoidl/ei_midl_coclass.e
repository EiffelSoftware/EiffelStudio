indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_COCLASS

inherit
	EI_MIDL_COMPONENT
		redefine
			make
		end

	WIZARD_SPECIAL_SYMBOLS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Implementation

	make (c_name: STRING) is
			-- Initialize object.  Set 'name' to 'c_name'.
		do
			Precursor (c_name)
			create {ARRAYED_LIST [EI_MIDL_INTERFACE]} interfaces.make (20)
		end

feature -- Access

	interfaces: LIST [EI_MIDL_INTERFACE]
			-- Interfaces

feature -- Element change

	add_interface (idl_interface: EI_MIDL_INTERFACE) is
			-- Add 'idl_interface' to interfaces.
		require
			non_void_interface: idl_interface /= Void
		do
			interfaces.extend (idl_interface)
		ensure
			interface_added: interfaces.has (idl_interface)
		end

feature -- Output

	code: STRING is
			-- Code.
		local
			l_name, guid_str: STRING
		do
			-- [ uuid ('guid'),
			Result := "%T%(uuid ("

			guid_str := guid.to_string.twin
			guid_str.remove (1)
			guid_str.remove (guid_str.count)

			Result.append (guid_str)
			Result.append ("),%R%N%T%T")

			-- helpstring ('description')
			Result.append ("helpstring (%"")
			Result.append (description)
			Result.append ("%"),%R%N%T%T")

			-- version ('version')
			Result.append ("version (")
			Result.append_real (version)
			Result.append ("),%R%N%T%)%R%N%T")

			-- coclass 'name
			l_name := name.twin
			l_name.to_lower
			Result.append ("coclass ")
			Result.append (l_name)

			-- interface I'name';
			Result.append ("%R%N%T{%R%N%T%T")
			Result.append ("interface I")
			Result.append (l_name)
			Result.append (";%R%N%T}%R%N")
		ensure
			output_generated: code /= Void
		end

end -- class EI_MIDL_COCLASS
