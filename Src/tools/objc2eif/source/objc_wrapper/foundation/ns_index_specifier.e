note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_INDEX_SPECIFIER

inherit
	NS_SCRIPT_OBJECT_SPECIFIER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_container_class_description__container_specifier__key__index_,
	make_with_container_specifier__key_,
	make_with_container_class_description__container_specifier__key_,
	make

feature {NONE} -- Initialization

	make_with_container_class_description__container_specifier__key__index_ (a_class_desc: detachable NS_SCRIPT_CLASS_DESCRIPTION; a_container: detachable NS_SCRIPT_OBJECT_SPECIFIER; a_property: detachable NS_STRING; a_index: INTEGER_64)
			-- Initialize `Current'.
		local
			a_class_desc__item: POINTER
			a_container__item: POINTER
			a_property__item: POINTER
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
			make_with_pointer (objc_init_with_container_class_description__container_specifier__key__index_(allocate_object, a_class_desc__item, a_container__item, a_property__item, a_index))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSIndexSpecifier Externals

	objc_init_with_container_class_description__container_specifier__key__index_ (an_item: POINTER; a_class_desc: POINTER; a_container: POINTER; a_property: POINTER; a_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSIndexSpecifier *)$an_item initWithContainerClassDescription:$a_class_desc containerSpecifier:$a_container key:$a_property index:$a_index];
			 ]"
		end

	objc_index (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSpecifier *)$an_item index];
			 ]"
		end

	objc_set_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSIndexSpecifier *)$an_item setIndex:$a_index];
			 ]"
		end

feature -- NSIndexSpecifier

	index: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index (item)
		end

	set_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_index_ (item, a_index)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSIndexSpecifier"
		end

end
