note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CLASS_DESCRIPTION_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSClassDescription

	register_class_description__for_class_ (a_description: detachable NS_CLASS_DESCRIPTION; a_class: detachable OBJC_CLASS)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_description__item: POINTER
			a_class__item: POINTER
		do
			if attached a_description as a_description_attached then
				a_description__item := a_description_attached.item
			end
			if attached a_class as a_class_attached then
				a_class__item := a_class_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_register_class_description__for_class_ (l_objc_class.item, a_description__item, a_class__item)
		end

	invalidate_class_description_cache
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_invalidate_class_description_cache (l_objc_class.item)
		end

	class_description_for_class_ (a_class: detachable OBJC_CLASS): detachable NS_CLASS_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_class__item: POINTER
		do
			if attached a_class as a_class_attached then
				a_class__item := a_class_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_class_description_for_class_ (l_objc_class.item, a_class__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_description_for_class_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_description_for_class_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSClassDescription Externals

	objc_register_class_description__for_class_ (a_class_object: POINTER; a_description: POINTER; a_class: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object registerClassDescription:$a_description forClass:$a_class];
			 ]"
		end

	objc_invalidate_class_description_cache (a_class_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object invalidateClassDescriptionCache];
			 ]"
		end

	objc_class_description_for_class_ (a_class_object: POINTER; a_class: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object classDescriptionForClass:$a_class];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSClassDescription"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
