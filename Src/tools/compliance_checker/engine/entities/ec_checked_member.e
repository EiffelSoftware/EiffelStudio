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
			check_extended_compliance,
			check_eiffel_compliance
		end
		
	EC_CHECKED_ENTITY_FACTORY
		export
			{NONE} all
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
		do
			Precursor {EC_CHECKED_ENTITY}
			if internal_is_compliant and then not internal_is_marked then
					-- No CLS-compliant attribute was set on member so we need to check parent
					-- container type.
				l_checked_type ?= checked_type (member.declaring_type)
				internal_is_compliant := l_checked_type.is_compliant
				internal_is_marked := l_checked_type.is_marked
				non_compliant_reason := l_checked_type.non_compliant_reason
			elseif not internal_is_compliant then
				non_compliant_reason := non_compliant_reasons.reason_member_marked_non_cls_compliant
			end
		end
		
	check_eiffel_compliance is
			-- Checks entity to see if it is Eiffel-compliant.
		local
			l_checked_type: EC_CHECKED_TYPE
			l_member_name: SYSTEM_STRING
			l_compliant: BOOLEAN
		do
			Precursor {EC_CHECKED_ENTITY}
			if internal_is_eiffel_compliant then
				l_member_name := member.name
				l_compliant := l_member_name /= Void and then (l_member_name.index_of_character ('`') < 0)
				if l_compliant then
					l_checked_type ?= checked_type (member.declaring_type)
					l_compliant := l_checked_type.is_eiffel_compliant
					if not l_compliant then
						if l_checked_type.non_eiffel_compliant_reason.is_equal (non_compliant_reasons.reason_type_is_generic) then
							non_eiffel_compliant_reason := non_compliant_reasons.reason_member_is_generic
						else
							non_eiffel_compliant_reason := l_checked_type.non_eiffel_compliant_reason
						end
					end
					internal_is_eiffel_compliant := l_compliant
				else
					internal_is_eiffel_compliant := False
					non_eiffel_compliant_reason := non_compliant_reasons.reason_member_is_generic
				end
			else
				non_eiffel_compliant_reason := non_compliant_reasons.reason_member_marked_non_eiffel_consumable
			end
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
