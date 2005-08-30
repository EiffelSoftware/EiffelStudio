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
		do
			l_member := member
			if not l_member.is_private and not l_member.is_assembly then
				Precursor {EC_CHECKED_MEMBER}
				if internal_is_compliant and not internal_is_marked then
					internal_is_compliant := checked_field_type.is_compliant
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
		do
			l_member := member
			if not internal_is_compliant and then (not l_member.is_private and not l_member.is_assembly) then
				internal_is_eiffel_compliant := checked_field_type.is_eiffel_compliant
			else
				internal_is_eiffel_compliant := True
			end			
		end		

end -- class EC_CHECKED_MEMBER_FIELD
