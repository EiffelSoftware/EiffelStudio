indexing
	description: "[
		Checked entity that describes a checked .NET type's member, require implementation by decendents.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_ABSTRACT_TYPE

inherit
	EC_CHECKED_TYPE
		rename
			make as make_type
		end

create
	make

feature {NONE} -- Initialization

	make (a_type: like type) is
			-- Create an initialize CLS-compliant checked type.
		require
			a_type_not_void: a_type /= Void
			a_type_is_abstract_or_is_interface: a_type.is_abstract or a_type.is_interface
		do
			make_type (a_type)
		ensure
			type_set: type = a_type
		end

feature -- Access

	non_compliant_interface_reason: STRING
			-- Reason why entity is non-CLS-compliant interface

	non_eiffel_compliant_interface_reason: STRING
			-- Reason why entity is non-Eiffel-compliant interface

	has_interface_been_checked: BOOLEAN
			-- Has type's interface been checked?

feature -- Query

	is_compliant_interface: BOOLEAN is
			-- Is type fully CLS-complaint interface?
			-- This means that all accessible members are CLS-compliant.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			not_is_being_checked: has_been_checked or not is_being_checked
		do
			if not has_been_checked then
				check_compliance
			end
			if not has_interface_been_checked then
				check_interface_compliance
			end
			Result := internal_is_compliant_interface
		ensure
			not_is_being_checked: has_been_checked or not is_being_checked
		end

	is_eiffel_compliant_interface: BOOLEAN is
			-- Is type fully Eiffel-complaint interface?
			-- This means that all accessible members are Eiffel-compliant.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			not_is_being_checked: has_been_checked or not is_being_checked
		do
			if not has_been_checked then
				check_compliance
			end
			if not has_interface_been_checked then
				check_interface_compliance
			end
			Result := internal_is_eiffel_compliant_interface
		ensure
			not_is_being_checked: has_been_checked or not is_being_checked
		end

feature {NONE} -- Basic Operations

	frozen check_interface_compliance is
			-- Checks type's abstract/interface members for full compliance.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			has_been_checked: has_been_checked
			not_has_interface_been_checked: not has_interface_been_checked
			not_is_being_checked: not is_being_checked
		do
			is_being_checked := True
			check_extended_interface_compliance
			has_interface_been_checked := True
			is_being_checked := False
		ensure
			has_interface_been_checked: has_interface_been_checked
			not_is_being_checked: not is_being_checked
		end

	check_extended_interface_compliance is
			-- Checks type's abstract/interface members for full compliance.
		require
			has_been_checked: has_been_checked
			not_has_interface_been_checked: not has_interface_been_checked
		local
			l_members: NATIVE_ARRAY [MEMBER_INFO]
			l_member: MEMBER_INFO
			l_checked_member: EC_CHECKED_MEMBER
			l_compliant: BOOLEAN
			l_eiffel_compliant: BOOLEAN
			i: INTEGER
		do
			l_compliant := True
			l_eiffel_compliant := True
			l_members := type.get_members
			i := l_members.count - 1
			if i > 0 then
				from
				until
					i < 0 or
					(not l_compliant and not l_eiffel_compliant)
				loop
					l_member := l_members.item (i)
					if is_applicable_member (l_member) then
						l_checked_member := checked_member (l_member)
						if l_checked_member /= Void then
							if l_compliant then
								l_compliant := l_checked_member.is_compliant
								if not l_compliant then
									l_compliant := l_checked_member.is_marked
								end
							end
							if l_eiffel_compliant then
								l_eiffel_compliant := l_checked_member.is_eiffel_compliant
							end
						end
					end

					i := i - 1
				end
			end
			internal_is_compliant_interface := l_compliant
			internal_is_eiffel_compliant_interface := l_eiffel_compliant

			if not l_compliant then
				non_compliant_interface_reason := non_compliant_reasons.reason_interface_contains_non_cls_compliant_members
			end
			if not l_eiffel_compliant then
				non_eiffel_compliant_interface_reason := non_compliant_reasons.reason_interface_contains_non_eiffel_compliant_members
			end
		end

feature {NONE} -- Implementation

	is_applicable_member (a_member: MEMBER_INFO): BOOLEAN is
			-- Is `a_member' an applicable member to check?
		require
			a_member_not_void: a_member /= Void
		local
			l_method: METHOD_INFO
		do
			l_method ?= a_member
			if l_method /= Void and not l_method.is_constructor then
				Result := l_method.is_abstract and (l_method.is_public or l_method.is_family or l_method.is_family_or_assembly)
			end
		end

	internal_is_compliant_interface: BOOLEAN
	internal_is_eiffel_compliant_interface: BOOLEAN

invariant
	type_need_implementing: type.is_abstract or type.is_interface

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
end -- class EC_CHECKED_ABSTRACT_TYPE
