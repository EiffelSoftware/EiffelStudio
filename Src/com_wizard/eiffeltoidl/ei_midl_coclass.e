indexing
	description: "Objects that ..."
	author: ""
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
			create interfaces.make
		end

feature -- Access

	interfaces: LINKED_LIST[EI_MIDL_INTERFACE]
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

			guid_str := clone (guid.to_string)
			guid_str.remove (1)
			guid_str.remove (guid_str.count)

			Result.append (guid_str)
			Result.append ("),%N%T%T")

			-- helpstring ('description')
			Result.append ("helpstring (%"")
			Result.append (description)
			Result.append ("%"),%N%T%T")

			-- version ('version')
			Result.append ("version (")
			Result.append_real (version)
			Result.append ("),%N%T%)%N%T")

			-- coclass 'name
			l_name := clone (name)
			l_name.to_lower
			Result.append ("coclass ")
			Result.append (l_name)

			-- interface I'name';
			Result.append ("%N%T{%N%T%T")
			Result.append ("interface I")
			Result.append (name)
			Result.append (";%N%T}%N")
		ensure
			output_generated: code /= Void
		end

end -- class EI_MIDL_COCLASS
