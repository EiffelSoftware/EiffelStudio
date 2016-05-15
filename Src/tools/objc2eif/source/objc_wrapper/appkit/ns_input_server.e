note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_INPUT_SERVER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_INPUT_SERVICE_PROVIDER_PROTOCOL
	NS_INPUT_SERVER_MOUSE_TRACKER_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSInputServer"
		end

end
