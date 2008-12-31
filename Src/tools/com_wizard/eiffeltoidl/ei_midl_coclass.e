note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make (c_name: STRING)
			-- Initialize object.  Set 'name' to 'c_name'.
		do
			Precursor (c_name)
			create {ARRAYED_LIST [EI_MIDL_INTERFACE]} interfaces.make (20)
		end

feature -- Access

	interfaces: LIST [EI_MIDL_INTERFACE]
			-- Interfaces

feature -- Element change

	add_interface (idl_interface: EI_MIDL_INTERFACE)
			-- Add 'idl_interface' to interfaces.
		require
			non_void_interface: idl_interface /= Void
		do
			interfaces.extend (idl_interface)
		ensure
			interface_added: interfaces.has (idl_interface)
		end

feature -- Output

	code: STRING
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
			l_name := name.twin
			l_name.to_lower
			Result.append ("coclass ")
			Result.append (l_name)

			-- interface I'name';
			Result.append ("%N%T{%N%T%T")
			Result.append ("interface I")
			Result.append (l_name)
			Result.append (";%N%T}%N")
		ensure
			output_generated: code /= Void
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class EI_MIDL_COCLASS


