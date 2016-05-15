note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PROPERTY_SPECIFIER

inherit
	NS_SCRIPT_OBJECT_SPECIFIER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_container_specifier__key_,
	make_with_container_class_description__container_specifier__key_,
	make

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPropertySpecifier"
		end

end
