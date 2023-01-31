note
	description: "[
		Checked entity that describes and examines an assembly type member.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_CHECKED_MEMBER

inherit
	EC_CHECKED_ENTITY


create
	make

feature {NONE} -- Initialization

	make (a_member: like member)
			-- Create an initialize CLS-compliant checked member.
		require
			a_member_not_void: a_member /= Void
		do
			init_reasons
			member := a_member
		ensure
			member_set: member = a_member
		end

feature -- Access

	member: MEMBER_INFO
			-- Member that was examined.

feature {NONE} -- Basic Operations {EC_CHECKED_ENTITY}

	check_extended_compliance
			-- Checks entity's CLS-compliance.
		local
			l_checked_type: EC_CHECKED_TYPE
		do
			if internal_is_compliant and then not internal_is_marked then
					-- No CLS-compliant attribute was set on member so we need to check parent
					-- container type.
				if attached member.declaring_type as l_type then
					l_checked_type := checked_type (l_type)
					internal_is_compliant := l_checked_type.is_compliant
					internal_is_marked := l_checked_type.is_marked
					non_compliant_reason := l_checked_type.non_compliant_reason
				else
					check
						from_documentation_declaring_type_attached: False
					then
					end
				end
			elseif not internal_is_compliant then
				non_compliant_reason := non_compliant_reasons.reason_member_marked_non_cls_compliant
			end
		end

	check_eiffel_compliance
			-- Checks entity to see if it is Eiffel-compliant.
		local
			l_checked_type: EC_CHECKED_TYPE
			l_member_name: SYSTEM_STRING
			l_compliant: BOOLEAN
		do
			l_member_name := member.name
			l_compliant := l_member_name /= Void and then (l_member_name.index_of_character ('`') < 0)
			if l_compliant then
				if attached member.declaring_type as l_type then
					l_checked_type := checked_type (l_type)
					l_compliant := l_checked_type.is_eiffel_compliant
					if not l_compliant then
						if l_checked_type.non_eiffel_compliant_reason ~  non_compliant_reasons.reason_type_is_generic then
							non_eiffel_compliant_reason := non_compliant_reasons.reason_member_is_generic
						else
							non_eiffel_compliant_reason := l_checked_type.non_eiffel_compliant_reason
						end
					end
					internal_is_eiffel_compliant := l_compliant
				else
					check
						from_documentation__declaring_type_attached: False
					then
					end
				end
			else
				internal_is_eiffel_compliant := False
				non_eiffel_compliant_reason := non_compliant_reasons.reason_member_is_generic
			end
		end

feature {NONE} -- Query {EC_CHECKED_ENTITY}

	custom_attribute_provider: ICUSTOM_ATTRIBUTE_PROVIDER
			-- Retrieve custom attribute provider for entity.
		do
			Result := member
		end

invariant
	member_not_void: member /= Void

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
