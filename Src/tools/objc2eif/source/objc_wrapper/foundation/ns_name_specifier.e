note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NAME_SPECIFIER

inherit
	NS_SCRIPT_OBJECT_SPECIFIER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_container_class_description__container_specifier__key__name_,
	make_with_container_specifier__key_,
	make_with_container_class_description__container_specifier__key_,
	make

feature {NONE} -- Initialization

	make_with_container_class_description__container_specifier__key__name_ (a_class_desc: detachable NS_SCRIPT_CLASS_DESCRIPTION; a_container: detachable NS_SCRIPT_OBJECT_SPECIFIER; a_property: detachable NS_STRING; a_name: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_class_desc__item: POINTER
			a_container__item: POINTER
			a_property__item: POINTER
			a_name__item: POINTER
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
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			make_with_pointer (objc_init_with_container_class_description__container_specifier__key__name_(allocate_object, a_class_desc__item, a_container__item, a_property__item, a_name__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSNameSpecifier Externals

	objc_init_with_container_class_description__container_specifier__key__name_ (an_item: POINTER; a_class_desc: POINTER; a_container: POINTER; a_property: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNameSpecifier *)$an_item initWithContainerClassDescription:$a_class_desc containerSpecifier:$a_container key:$a_property name:$a_name];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNameSpecifier *)$an_item name];
			 ]"
		end

	objc_set_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNameSpecifier *)$an_item setName:$a_name];
			 ]"
		end

feature -- NSNameSpecifier

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

	set_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_name_ (item, a_name__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSNameSpecifier"
		end

end
