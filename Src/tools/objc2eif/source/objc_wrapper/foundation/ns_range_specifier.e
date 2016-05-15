note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RANGE_SPECIFIER

inherit
	NS_SCRIPT_OBJECT_SPECIFIER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_container_class_description__container_specifier__key__start_specifier__end_specifier_,
	make_with_container_specifier__key_,
	make_with_container_class_description__container_specifier__key_,
	make

feature {NONE} -- Initialization

	make_with_container_class_description__container_specifier__key__start_specifier__end_specifier_ (a_class_desc: detachable NS_SCRIPT_CLASS_DESCRIPTION; a_container: detachable NS_SCRIPT_OBJECT_SPECIFIER; a_property: detachable NS_STRING; a_start_spec: detachable NS_SCRIPT_OBJECT_SPECIFIER; a_end_spec: detachable NS_SCRIPT_OBJECT_SPECIFIER)
			-- Initialize `Current'.
		local
			a_class_desc__item: POINTER
			a_container__item: POINTER
			a_property__item: POINTER
			a_start_spec__item: POINTER
			a_end_spec__item: POINTER
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
			if attached a_start_spec as a_start_spec_attached then
				a_start_spec__item := a_start_spec_attached.item
			end
			if attached a_end_spec as a_end_spec_attached then
				a_end_spec__item := a_end_spec_attached.item
			end
			make_with_pointer (objc_init_with_container_class_description__container_specifier__key__start_specifier__end_specifier_(allocate_object, a_class_desc__item, a_container__item, a_property__item, a_start_spec__item, a_end_spec__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSRangeSpecifier Externals

	objc_init_with_container_class_description__container_specifier__key__start_specifier__end_specifier_ (an_item: POINTER; a_class_desc: POINTER; a_container: POINTER; a_property: POINTER; a_start_spec: POINTER; a_end_spec: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRangeSpecifier *)$an_item initWithContainerClassDescription:$a_class_desc containerSpecifier:$a_container key:$a_property startSpecifier:$a_start_spec endSpecifier:$a_end_spec];
			 ]"
		end

	objc_start_specifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRangeSpecifier *)$an_item startSpecifier];
			 ]"
		end

	objc_set_start_specifier_ (an_item: POINTER; a_start_spec: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSRangeSpecifier *)$an_item setStartSpecifier:$a_start_spec];
			 ]"
		end

	objc_end_specifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRangeSpecifier *)$an_item endSpecifier];
			 ]"
		end

	objc_set_end_specifier_ (an_item: POINTER; a_end_spec: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSRangeSpecifier *)$an_item setEndSpecifier:$a_end_spec];
			 ]"
		end

feature -- NSRangeSpecifier

	start_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_start_specifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like start_specifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like start_specifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_start_specifier_ (a_start_spec: detachable NS_SCRIPT_OBJECT_SPECIFIER)
			-- Auto generated Objective-C wrapper.
		local
			a_start_spec__item: POINTER
		do
			if attached a_start_spec as a_start_spec_attached then
				a_start_spec__item := a_start_spec_attached.item
			end
			objc_set_start_specifier_ (item, a_start_spec__item)
		end

	end_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_end_specifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like end_specifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like end_specifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_end_specifier_ (a_end_spec: detachable NS_SCRIPT_OBJECT_SPECIFIER)
			-- Auto generated Objective-C wrapper.
		local
			a_end_spec__item: POINTER
		do
			if attached a_end_spec as a_end_spec_attached then
				a_end_spec__item := a_end_spec_attached.item
			end
			objc_set_end_specifier_ (item, a_end_spec__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSRangeSpecifier"
		end

end
