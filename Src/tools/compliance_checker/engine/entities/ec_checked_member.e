indexing
	description: "[
		Checked entity that describes and examines an assembly type member.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_MEMBER

inherit		
	EC_CHECKED_ENTITY
		redefine
			check_extended_compliance
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_member: like member) is
			-- Create an initialize CLS-compliant checked member.
		require
			a_member_not_void: a_member /= Void
		do
			member := a_member
		ensure
			member_set: member = a_member
		end
		
feature -- Access
		
	member: MEMBER_INFO
			-- Member that was examined.
		
feature {NONE} -- Basic Operations {EC_CHECKED_ENTITY}

	check_extended_compliance is
			-- Checks entity's CLS-compliance.
		local
			l_checked_type: EC_CHECKED_TYPE
			l_type: SYSTEM_TYPE
		do
			Precursor {EC_CHECKED_ENTITY}
			if not internal_is_marked then
					-- No CLS-compliant attribute was set on member so we need to check parent
					-- container type.
				l_type := member.declaring_type
				l_checked_type ?= checked_entities.item (l_type)
				if l_checked_type = Void then
					create l_checked_type.make (l_type)
				end
				internal_is_compliant := l_checked_type.is_compliant
				internal_is_marked := l_checked_type.is_marked				
			end
		end

	check_eiffel_compliance is
			-- Checks entity to see if it is Eiffel-compliant.
		do
			internal_is_eiffel_compliant := internal_is_compliant
		end
		
feature {NONE} -- Query {EC_CHECKED_ENTITY}

	custom_attribute_provider: ICUSTOM_ATTRIBUTE_PROVIDER is
			-- Retrieve custom attribute provider for entity.
		do
			Result := member
		end
			
invariant
	member_not_void: member /= Void
			
end -- class EC_CHECKED_MEMBER
