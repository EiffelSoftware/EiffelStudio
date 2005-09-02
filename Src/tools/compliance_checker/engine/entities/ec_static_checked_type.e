indexing
	description: "[
		A static version of EC_CHECKED_TYPE, that is to say a version whos compliance is know or
		is common knowledge to .NET framework.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_STATIC_CHECKED_TYPE

inherit		
	EC_CHECKED_TYPE
		rename
			make as make_checked_type
		end
		
create
	make
	
feature {NONE} -- Initialization

	make (a_type: like type; a_is_compliant: like is_compliant; a_is_eiffel_compliant: like is_eiffel_compliant) is
			-- Create an initialize CLS-compliant checked type.
		do
			make_checked_type (a_type)
			has_been_checked := True
			internal_is_marked := True
			internal_is_compliant := a_is_compliant
			if not a_is_compliant then
				non_compliant_reason := non_compliant_reasons.reason_type_marked_non_cls_compliant
			end
			internal_is_eiffel_compliant := a_is_eiffel_compliant
			if not a_is_compliant then
				non_eiffel_compliant_reason := non_compliant_reasons.reason_type_marked_non_cls_compliant
			end
		end
			
end -- class EC_STATIC_CHECKED_TYPE
