note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_INDEX_SET_UTILS

inherit
	NS_INDEX_SET_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMutableIndexSet"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
