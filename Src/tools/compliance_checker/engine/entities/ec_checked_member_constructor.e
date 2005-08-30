indexing
	description: "[
		Checked entity that describes and examines an assembly constructor.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_MEMBER_CONSTRUCTOR

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
		
	member: CONSTRUCTOR_INFO
			-- Member that was examined.
			
feature {NONE} -- Basic Operations {EC_CHECKED_MEMBER}

	check_extended_compliance is
			-- Checks entity's CLS-compliance.
		local
			l_member: like member
		do
			l_member := member
			if l_member.is_public or l_member.is_family or l_member.is_family_or_assembly then
				Precursor {EC_CHECKED_MEMBER_METHOD_BASE}
				if internal_is_compliant and not internal_is_marked then
					internal_is_compliant := are_parameters_compliant (False)
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
			if (not internal_is_compliant or not internal_is_marked) and then (l_member.is_public or l_member.is_family or l_member.is_family_or_assembly) then
				internal_is_eiffel_compliant := are_parameters_compliant (True)
			else
				internal_is_eiffel_compliant := True
			end
		end
			
end -- class EC_CHECKED_MEMBER_CONSTRUCTOR
