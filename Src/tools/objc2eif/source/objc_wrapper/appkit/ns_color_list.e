note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR_LIST

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_name_,
	make_with_name__from_file_,
	make

feature {NONE} -- Initialization

	make_with_name_ (a_name: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			make_with_pointer (objc_init_with_name_(allocate_object, a_name__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_name__from_file_ (a_name: detachable NS_STRING; a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_name__item: POINTER
			a_path__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_with_name__from_file_(allocate_object, a_name__item, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSColorList Externals

	objc_init_with_name_ (an_item: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColorList *)$an_item initWithName:$a_name];
			 ]"
		end

	objc_init_with_name__from_file_ (an_item: POINTER; a_name: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColorList *)$an_item initWithName:$a_name fromFile:$a_path];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColorList *)$an_item name];
			 ]"
		end

	objc_set_color__for_key_ (an_item: POINTER; a_color: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorList *)$an_item setColor:$a_color forKey:$a_key];
			 ]"
		end

	objc_insert_color__key__at_index_ (an_item: POINTER; a_color: POINTER; a_key: POINTER; a_loc: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorList *)$an_item insertColor:$a_color key:$a_key atIndex:$a_loc];
			 ]"
		end

	objc_remove_color_with_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorList *)$an_item removeColorWithKey:$a_key];
			 ]"
		end

	objc_color_with_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColorList *)$an_item colorWithKey:$a_key];
			 ]"
		end

	objc_all_keys (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColorList *)$an_item allKeys];
			 ]"
		end

	objc_is_editable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColorList *)$an_item isEditable];
			 ]"
		end

	objc_write_to_file_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColorList *)$an_item writeToFile:$a_path];
			 ]"
		end

	objc_remove_file (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorList *)$an_item removeFile];
			 ]"
		end

feature -- NSColorList

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_color__for_key_ (a_color: detachable NS_COLOR; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
			a_key__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_set_color__for_key_ (item, a_color__item, a_key__item)
		end

	insert_color__key__at_index_ (a_color: detachable NS_COLOR; a_key: detachable NS_STRING; a_loc: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
			a_key__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_insert_color__key__at_index_ (item, a_color__item, a_key__item, a_loc)
		end

	remove_color_with_key_ (a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_remove_color_with_key_ (item, a_key__item)
		end

	color_with_key_ (a_key: detachable NS_STRING): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_color_with_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	all_keys: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_all_keys (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_keys} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_keys} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_editable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_editable (item)
		end

	write_to_file_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_write_to_file_ (item, a_path__item)
		end

	remove_file
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_file (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSColorList"
		end

end
