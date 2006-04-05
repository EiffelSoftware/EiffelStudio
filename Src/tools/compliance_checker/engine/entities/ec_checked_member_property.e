indexing
	description: "[
		Checked entity that describes and examines an assembly type.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_MEMBER_PROPERTY

inherit
	EC_CHECKED_MEMBER
		redefine
			member,
			check_extended_compliance,
			check_eiffel_compliance
		end

create
	make

feature -- Access {EC_CHECKED_MEMBER}
		
	member: PROPERTY_INFO
			-- Member that was examined.
			
feature -- Access
			
	checked_property_type: EC_CHECKED_TYPE is
			-- `member' property type checked type.
		do
			Result := checked_type (member.property_type)
		ensure
			result_not_void: Result /= Void
		end
			
feature {NONE} -- Basic Operations {EC_CHECKED_MEMBER}

	check_extended_compliance is
			-- Checks entity's CLS-compliance.
		local
			l_member: like member
			l_compliant: BOOLEAN
		do
			l_member := member
			Precursor {EC_CHECKED_MEMBER}
			if internal_is_compliant and not internal_is_marked then
				l_compliant := is_cls_member_name (l_member)
				if l_compliant then
					l_compliant := checked_property_type.is_compliant
					if not l_compliant then
						non_compliant_reason := non_compliant_reasons.reason_property_uses_non_complaint_type
					end
				else	
					non_compliant_reason := non_compliant_reasons.reason_property_name_is_non_compliant
				end
				internal_is_compliant := l_compliant
			end
		end

	check_eiffel_compliance is
			-- Checks entity to see if it is Eiffel-compliant.
		local
			l_member: like member
			l_compliant: BOOLEAN
		do
			Precursor {EC_CHECKED_MEMBER}
			if internal_is_eiffel_compliant then
				l_member := member
				if not internal_is_compliant then
					l_compliant := checked_property_type.is_eiffel_compliant
					if not l_compliant then
						non_eiffel_compliant_reason := non_compliant_reasons.reason_property_uses_non_complaint_type				
					end
					internal_is_eiffel_compliant := l_compliant
				end		
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
end -- class EC_CHECKED_MEMBER_PROPERTY
