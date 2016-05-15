note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DIRECTORY_ENUMERATOR

inherit
	NS_ENUMERATOR
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSDirectoryEnumerator

	file_attributes: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	directory_attributes: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_directory_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like directory_attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like directory_attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	skip_descendents
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_skip_descendents (item)
		end

	level: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_level (item)
		end

	skip_descendants
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_skip_descendants (item)
		end

feature {NONE} -- NSDirectoryEnumerator Externals

	objc_file_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDirectoryEnumerator *)$an_item fileAttributes];
			 ]"
		end

	objc_directory_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDirectoryEnumerator *)$an_item directoryAttributes];
			 ]"
		end

	objc_skip_descendents (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDirectoryEnumerator *)$an_item skipDescendents];
			 ]"
		end

	objc_level (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDirectoryEnumerator *)$an_item level];
			 ]"
		end

	objc_skip_descendants (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDirectoryEnumerator *)$an_item skipDescendants];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDirectoryEnumerator"
		end

end
