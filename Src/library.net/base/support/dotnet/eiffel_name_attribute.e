indexing
	description: "Custom attributes used by compiler to preserve original Eiffel class name."
	external_name: "EiffelSoftware.Runtime.CA.EIFFEL_NAME_ATTRIBUTE"
	assembly: "EiffelSoftware.Runtime", "5.5.0.0", "neutral", "def26f296efef469"
	date: "$Date$"
	revision: "$Revision$"

external class
	EIFFEL_NAME_ATTRIBUTE
	
inherit
	ATTRIBUTE
		rename
			make as old_make
		end

create {INTERNAL}
	make
	
feature {NONE} -- Initialization

	make (a_name: SYSTEM_STRING) is
			-- Create a new delegate object
		external
			"IL creator signature (System.String) use EiffelSoftware.Runtime.CA.EIFFEL_NAME_ATTRIBUTE"
		end

feature {INTERNAL} -- Access

	name: SYSTEM_STRING is
		external
			"IL field signature :System.String use EiffelSoftware.Runtime.CA.EIFFEL_NAME_ATTRIBUTE"
		alias
			"name"
		end
		
end -- class EIFFEL_NAME_ATTRIBUTE
