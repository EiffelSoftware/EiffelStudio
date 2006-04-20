indexing
	description: "Create MIDL coclass"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_COCLASS_CREATOR

inherit
	EI_MIDL_COMPONENT_CREATOR

create
	make

feature -- Access

	midl_coclass: EI_MIDL_COCLASS
			-- MIDL coclass

feature -- Basic operations

	create_from_eiffel_class (eiffel_class: EI_CLASS) is
			-- Generate MIDL coclass from 'eiffel_class'.
		local
			interface_creator: EI_MIDL_INTERFACE_CREATOR
		do
			create midl_coclass.make (eiffel_class.name)
			midl_coclass.set_description (eiffel_class.description)

			create interface_creator.make
			interface_creator.create_from_eiffel_class (eiffel_class)
			if interface_creator.succeed then
				midl_coclass.add_interface (interface_creator.midl_interface)
				succeed := True
			end
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
end -- class EI_MIDL_COCLASS_CREATOR

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

