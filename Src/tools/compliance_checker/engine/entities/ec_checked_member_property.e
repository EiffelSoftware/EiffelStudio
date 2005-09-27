indexing
	description: "[
		Checked entity that describes and examines an assembly type.
	]"
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
			
end -- class EC_CHECKED_MEMBER_PROPERTY
