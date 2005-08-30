indexing
	description: "[
		Checked entity that describes and examines an assembly type event.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_MEMBER_EVENT

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
		
	member: EVENT_INFO
			-- Member that was examined.
			
feature -- Access {EC_CHECKED_MEMBER}
			
	checked_event_type: EC_CHECKED_TYPE is
			-- `member' event handler type checked type.
		do
			Result := checked_type (member.event_handler_type)
		end
		
feature {NONE} -- Basic Operations {EC_CHECKED_MEMBER}

	check_extended_compliance is
			-- Checks entity's CLS-compliance.
		local
			l_member: like member
		do
			l_member := member
			Precursor {EC_CHECKED_MEMBER}
			if internal_is_compliant and not internal_is_marked then
				internal_is_compliant := checked_event_type.is_compliant
			end
		end

	check_eiffel_compliance is
			-- Checks entity to see if it is Eiffel-compliant.
		local
			l_member: like member
		do
			l_member := member
			if not internal_is_compliant then
				internal_is_eiffel_compliant := checked_event_type.is_eiffel_compliant
			else
				internal_is_eiffel_compliant := True
			end			
		end
			
end -- class EC_CHECKED_MEMBER_EVENT
