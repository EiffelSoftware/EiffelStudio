indexing
	description: "[
		A static version of EC_CHECKED_TYPE, that is to say a version whos compliance is know or
		is common knowledge to .NET framework.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_STATIC_CHECKED_TYPE

inherit		
	EC_CHECKED_TYPE
		rename
			make as make_checked_type
		end
		
create
	make
	
feature {NONE} -- Initialization

	make (a_type: like type; a_is_compliant: like is_compliant; a_is_eiffel_compliant: like is_eiffel_compliant) is
			-- Create an initialize CLS-compliant checked type.
		do
			make_checked_type (a_type)
			has_been_checked := True
			internal_is_marked := True
			internal_is_compliant := a_is_compliant
			if not a_is_compliant then
				non_compliant_reason := non_compliant_reasons.reason_type_marked_non_cls_compliant
			end
			internal_is_eiffel_compliant := a_is_eiffel_compliant
			if not a_is_compliant then
				non_eiffel_compliant_reason := non_compliant_reasons.reason_type_marked_non_cls_compliant
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
end -- class EC_STATIC_CHECKED_TYPE
