note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_POSITIONAL_SPECIFIER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_position__object_specifier_,
	make

feature {NONE} -- Initialization

	make_with_position__object_specifier_ (a_position: NATURAL_64; a_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER)
			-- Initialize `Current'.
		local
			a_specifier__item: POINTER
		do
			if attached a_specifier as a_specifier_attached then
				a_specifier__item := a_specifier_attached.item
			end
			make_with_pointer (objc_init_with_position__object_specifier_(allocate_object, a_position, a_specifier__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSPositionalSpecifier Externals

	objc_init_with_position__object_specifier_ (an_item: POINTER; a_position: NATURAL_64; a_specifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPositionalSpecifier *)$an_item initWithPosition:$a_position objectSpecifier:$a_specifier];
			 ]"
		end

	objc_position (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPositionalSpecifier *)$an_item position];
			 ]"
		end

	objc_set_insertion_class_description_ (an_item: POINTER; a_class_description: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSPositionalSpecifier *)$an_item setInsertionClassDescription:$a_class_description];
			 ]"
		end

	objc_evaluate (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSPositionalSpecifier *)$an_item evaluate];
			 ]"
		end

	objc_insertion_container (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPositionalSpecifier *)$an_item insertionContainer];
			 ]"
		end

	objc_insertion_key (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPositionalSpecifier *)$an_item insertionKey];
			 ]"
		end

	objc_insertion_index (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPositionalSpecifier *)$an_item insertionIndex];
			 ]"
		end

	objc_insertion_replaces (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPositionalSpecifier *)$an_item insertionReplaces];
			 ]"
		end

feature -- NSPositionalSpecifier

	position: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_position (item)
		end

	set_insertion_class_description_ (a_class_description: detachable NS_SCRIPT_CLASS_DESCRIPTION)
			-- Auto generated Objective-C wrapper.
		local
			a_class_description__item: POINTER
		do
			if attached a_class_description as a_class_description_attached then
				a_class_description__item := a_class_description_attached.item
			end
			objc_set_insertion_class_description_ (item, a_class_description__item)
		end

	evaluate
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_evaluate (item)
		end

	insertion_container: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_insertion_container (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like insertion_container} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like insertion_container} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	insertion_key: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_insertion_key (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like insertion_key} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like insertion_key} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	insertion_index: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_insertion_index (item)
		end

	insertion_replaces: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_insertion_replaces (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPositionalSpecifier"
		end

end
