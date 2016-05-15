note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CONTROL_UTILS

inherit
	NS_VIEW_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSControl

	set_cell_class_ (a_factory_id: detachable OBJC_CLASS)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_factory_id__item: POINTER
		do
			if attached a_factory_id as a_factory_id_attached then
				a_factory_id__item := a_factory_id_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_cell_class_ (l_objc_class.item, a_factory_id__item)
		end

	cell_class: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_cell_class (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cell_class} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cell_class} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSControl Externals

	objc_set_cell_class_ (a_class_object: POINTER; a_factory_id: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setCellClass:$a_factory_id];
			 ]"
		end

	objc_cell_class (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object cellClass];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSControl"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
