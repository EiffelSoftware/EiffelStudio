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
			internal_is_eiffel_compliant := a_is_eiffel_compliant
		end
			
end -- class EC_STATIC_CHECKED_TYPE
