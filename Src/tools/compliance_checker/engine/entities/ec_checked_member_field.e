indexing
	description: "[
		Checked entity that describes and examines an assembly type field.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_MEMBER_FIELD

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
		
	member: FIELD_INFO
			-- Member that was examined.
			
feature -- Access 

	checked_field_type: EC_CHECKED_TYPE is
			-- `member' field type checked type.
		do
			Result := checked_type (member.field_type)
		end
		
feature {NONE} -- Basic Operations {EC_CHECKED_MEMBER}

	check_extended_compliance is
			-- Checks entity's CLS-compliance.
		local
			l_member: like member
			l_compliant: BOOLEAN
		do
			l_member := member
			if l_member.is_public or l_member.is_family or l_member.is_family_or_assembly then
				Precursor {EC_CHECKED_MEMBER}
				if internal_is_compliant and not internal_is_marked then
					l_compliant := is_cls_member_name (l_member)
					if l_compliant then
						l_compliant := checked_field_type.is_compliant
						if not l_compliant then
							non_compliant_reason := non_compliant_reasons.reason_field_uses_non_complaint_type
						end
					else	
						non_compliant_reason := non_compliant_reasons.reason_field_name_is_non_compliant
					end
					internal_is_compliant := l_compliant
				end
			else
				internal_is_compliant := True
				internal_is_marked := True
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
				if not internal_is_compliant and then (l_member.is_public or l_member.is_family or l_member.is_family_or_assembly) then
					l_compliant := checked_field_type.is_eiffel_compliant
					if l_compliant then
						internal_is_eiffel_compliant := True
					else
						non_eiffel_compliant_reason := non_compliant_reasons.reason_field_uses_non_complaint_type
					end
				end
			end
		end		

end -- class EC_CHECKED_MEMBER_FIELD
