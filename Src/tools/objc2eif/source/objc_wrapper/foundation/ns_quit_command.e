note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_QUIT_COMMAND

inherit
	NS_SCRIPT_COMMAND
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_command_description_,
	make

feature -- NSQuitCommand

	save_options: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_save_options (item)
		end

feature {NONE} -- NSQuitCommand Externals

	objc_save_options (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSQuitCommand *)$an_item saveOptions];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSQuitCommand"
		end

end
