note
	description: "[
		Checked entity that describes and examines an assembly type method.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_MEMBER_METHOD

inherit
	EC_CHECKED_MEMBER_METHOD_BASE
		redefine
			member,
			check_extended_compliance,
			check_eiffel_compliance
		end

create
	make

feature -- Access {EC_CHECKED_MEMBER}
		
	member: METHOD_INFO
			-- Member that was examined.

feature -- Access	
			
	checked_return_type: EC_CHECKED_TYPE
			-- `member' field type checked type.
		local
			l_member: like member
		do
			l_member := member
			if l_member.return_type /= Void then
				Result := checked_type (l_member.return_type)
			end
		end
			
feature {NONE} -- Basic Operations {EC_CHECKED_MEMBER}

	check_extended_compliance
			-- Checks entity's CLS-compliance.
		local
			l_member: like member
			l_compliant: BOOLEAN
		do
			l_member := member
			if l_member.is_public or l_member.is_family or l_member.is_family_or_assembly then
				Precursor {EC_CHECKED_MEMBER_METHOD_BASE}
				if internal_is_compliant and not internal_is_marked then
					l_compliant := is_cls_member_name (l_member)
					if l_compliant then
						l_compliant := are_parameters_compliant (False)
						if l_compliant then
							if l_member.return_type /= Void then
								l_compliant := checked_return_type.is_compliant
								if not l_compliant then
									non_compliant_reason := non_compliant_reasons.reason_method_returns_non_complaint_type
								end
							end
						else
							non_compliant_reason := non_compliant_reasons.reason_parameters_uses_non_complaint_types
						end
					else
						non_compliant_reason := non_compliant_reasons.reason_method_name_is_non_compliant
					end
					internal_is_compliant := l_compliant
				end
			else
				internal_is_compliant := True
				internal_is_marked := True
			end
		end

	check_eiffel_compliance
			-- Checks entity to see if it is Eiffel-compliant.
		local
			l_member: like member
			l_compliant: BOOLEAN
		do
			l_member := member	
			if (l_member.is_public or l_member.is_family or l_member.is_family_or_assembly) then
				Precursor {EC_CHECKED_MEMBER_METHOD_BASE}
				if internal_is_eiffel_compliant then
					l_compliant := are_parameters_compliant (True)
					if l_compliant then
						if l_member.return_type /= Void then
							l_compliant := checked_return_type.is_eiffel_compliant
							if not l_compliant then
								non_eiffel_compliant_reason := non_compliant_reasons.reason_method_returns_non_complaint_type
							end
						end
					else
						non_eiffel_compliant_reason := non_compliant_reasons.reason_parameters_uses_non_complaint_types
					end
				end
				internal_is_eiffel_compliant := l_compliant
			end
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
end -- class EC_CHECKED_MEMBER_METHOD
