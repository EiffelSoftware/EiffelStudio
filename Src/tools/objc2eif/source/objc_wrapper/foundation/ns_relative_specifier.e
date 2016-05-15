note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RELATIVE_SPECIFIER

inherit
	NS_SCRIPT_OBJECT_SPECIFIER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_container_class_description__container_specifier__key__relative_position__base_specifier_,
	make_with_container_specifier__key_,
	make_with_container_class_description__container_specifier__key_,
	make

feature {NONE} -- Initialization

	make_with_container_class_description__container_specifier__key__relative_position__base_specifier_ (a_class_desc: detachable NS_SCRIPT_CLASS_DESCRIPTION; a_container: detachable NS_SCRIPT_OBJECT_SPECIFIER; a_property: detachable NS_STRING; a_rel_pos: NATURAL_64; a_base_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER)
			-- Initialize `Current'.
		local
			a_class_desc__item: POINTER
			a_container__item: POINTER
			a_property__item: POINTER
			a_base_specifier__item: POINTER
		do
			if attached a_class_desc as a_class_desc_attached then
				a_class_desc__item := a_class_desc_attached.item
			end
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			if attached a_property as a_property_attached then
				a_property__item := a_property_attached.item
			end
			if attached a_base_specifier as a_base_specifier_attached then
				a_base_specifier__item := a_base_specifier_attached.item
			end
			make_with_pointer (objc_init_with_container_class_description__container_specifier__key__relative_position__base_specifier_(allocate_object, a_class_desc__item, a_container__item, a_property__item, a_rel_pos, a_base_specifier__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSRelativeSpecifier Externals

	objc_init_with_container_class_description__container_specifier__key__relative_position__base_specifier_ (an_item: POINTER; a_class_desc: POINTER; a_container: POINTER; a_property: POINTER; a_rel_pos: NATURAL_64; a_base_specifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRelativeSpecifier *)$an_item initWithContainerClassDescription:$a_class_desc containerSpecifier:$a_container key:$a_property relativePosition:$a_rel_pos baseSpecifier:$a_base_specifier];
			 ]"
		end

	objc_relative_position (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSRelativeSpecifier *)$an_item relativePosition];
			 ]"
		end

	objc_set_relative_position_ (an_item: POINTER; a_rel_pos: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSRelativeSpecifier *)$an_item setRelativePosition:$a_rel_pos];
			 ]"
		end

	objc_base_specifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRelativeSpecifier *)$an_item baseSpecifier];
			 ]"
		end

	objc_set_base_specifier_ (an_item: POINTER; a_base_specifier: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSRelativeSpecifier *)$an_item setBaseSpecifier:$a_base_specifier];
			 ]"
		end

feature -- NSRelativeSpecifier

	relative_position: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_relative_position (item)
		end

	set_relative_position_ (a_rel_pos: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_relative_position_ (item, a_rel_pos)
		end

	base_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_base_specifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like base_specifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like base_specifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_base_specifier_ (a_base_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER)
			-- Auto generated Objective-C wrapper.
		local
			a_base_specifier__item: POINTER
		do
			if attached a_base_specifier as a_base_specifier_attached then
				a_base_specifier__item := a_base_specifier_attached.item
			end
			objc_set_base_specifier_ (item, a_base_specifier__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSRelativeSpecifier"
		end

end
