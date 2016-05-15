note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PURGEABLE_DATA

inherit
	NS_MUTABLE_DATA
		redefine
			wrapper_objc_class_name
		end

	NS_DISCARDABLE_CONTENT_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_capacity_,
	make_with_length_,
	make_with_contents_of_file_,
	make_with_contents_of_ur_l_,
	make_with_contents_of_mapped_file_,
	make_with_data_,
	make

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPurgeableData"
		end

end
