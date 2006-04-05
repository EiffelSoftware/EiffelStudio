indexing
	description: "Special type libraries"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SPECIAL_TYPE_LIBRARIES

feature -- Access

	Non_generated_type_libraries: ARRAY [ECOM_GUID] is
			-- Non generated type libraries
		local
			a_guid: ECOM_GUID
		once
			create Result.make (1,3)

			create a_guid.make_from_string (stdole32)
			Result.put (a_guid, 1)

			Result.compare_objects
		end

	prefixed_libraries : ARRAY [ECOM_GUID] is
			-- Prefixed type libraries.
		local
			a_guid: ECOM_GUID
		once
			create Result.make (1,1)

			create a_guid.make_from_string (vba_tlb)
			Result.put (a_guid, 1)

			Result.compare_objects
		end

feature {NONE} -- Implementation

	stdole32: STRING is "{00020430-0000-0000-C000-000000000046}"
			-- Stdole32.tlb type library guid.

	vba_tlb: STRING is "{000204EF-0000-0000-C000-000000000046}";
			-- MSVBVM60.DLL type library guid.

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
end -- class WIZARD_SPECIAL_TYPE_LIBRARIES

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
