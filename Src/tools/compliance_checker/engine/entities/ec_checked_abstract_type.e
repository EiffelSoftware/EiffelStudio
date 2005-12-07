indexing
	description: "[
		Checked entity that describes a checked .NET type's member, require implementation by decendents.
	]"
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
			l_property: PROPERTY_INFO
			l_ctor: CONSTRUCTOR_INFO
			l_event: EVENT_INFO
			l_field: FIELD_INFO
			l_type: SYSTEM_TYPE
		do
			l_method ?= a_member
			if l_method /= Void then
				Result := l_method.is_abstract and (l_method.is_public or l_method.is_family or l_method.is_family_or_assembly)
			else
				l_property ?= a_member
				if l_property /= Void then
						-- No need to check properties as associated methods will be checked later.
					Result := False
				else
					l_ctor ?= a_member
					if l_ctor /= Void then
						Result := l_ctor.is_public or l_ctor.is_family or l_ctor.is_family_or_assembly
					else
						l_event ?= a_member
						if l_event /= Void then
								-- No need to check events as associated methods will be checked later.
							Result := False
						else
							l_field ?= a_member
							if l_field /= Void then
								Result := True
							else
								l_type ?= a_member
								if l_type /= Void then
									Result := False
								else
									check
										False
									end
								end
							end
						end
					end
				end
			end
		end

	internal_is_compliant_interface: BOOLEAN
	internal_is_eiffel_compliant_interface: BOOLEAN

invariant
	type_need_implementing: type.is_abstract or type.is_interface

end -- class EC_CHECKED_ABSTRACT_TYPE
