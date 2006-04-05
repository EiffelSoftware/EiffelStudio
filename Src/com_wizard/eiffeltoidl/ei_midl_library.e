indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_LIBRARY

inherit
	EI_MIDL_COMPONENT
		redefine
			make
		end

create
	make

feature {NONE} -- Intialization

	make (l_name: STRING) is
			-- Initialize object.  Set 'name' to 'l_name'.
		do
			Precursor (l_name)
			name.to_lower
		end

feature -- Access

	coclass: EI_MIDL_COCLASS
			-- Coclass

feature -- Element change

	set_coclass (c_class: EI_MIDL_COCLASS) is
			-- Set 'coclass' to 'c_class'.
		require
			non_void_coclass: c_class /= Void
		do
			coclass := c_class
		ensure
			coclass_set: coclass.is_equal (c_class)
		end

feature -- Output

	code: STRING is
			-- Library code
		local
			guid_str: STRING
		do
			Result := "//%N// File : "
			Result.append (name)
			Result.append (".idl")
			Result.append ("%N// Description : ")
			Result.append (coclass.description)
			Result.append ("%N//%N%Nimport %"oaidl.idl%";%N%N")
			

			if not coclass.interfaces.is_empty then
				from
					coclass.interfaces.start
				until
					coclass.interfaces.after
				loop
					Result.append (coclass.interfaces.item.code)
					Result.append ("%N%N")
					coclass.interfaces.forth
				end
			end

			Result.append ("%N%(%N%Tuuid (")

			guid_str := guid.to_string.twin
			guid_str.remove (1)
			guid_str.remove (guid_str.count)

			Result.append (guid_str)
			Result.append ("),%N%Thelpstring (%"")
			Result.append (description)
			Result.append ("%"),%N%Tversion (")
			Result.append_real (version)
			Result.append (")%N%)%N")

			Result.append ("library ")
			Result.append (name)
			Result.append ("%N{%N%Timportlib (%"stdole32.tlb%");%N")
			Result.append (coclass.code)
			Result.append ("%N}")
		ensure
			code_generated: Result /= Void
		end

indexing
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
end -- class EI_MIDL_LIBRARY

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

