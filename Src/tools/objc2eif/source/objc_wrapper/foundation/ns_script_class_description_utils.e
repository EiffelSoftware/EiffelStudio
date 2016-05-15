note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCRIPT_CLASS_DESCRIPTION_UTILS

inherit
	NS_CLASS_DESCRIPTION_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScriptClassDescription"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
