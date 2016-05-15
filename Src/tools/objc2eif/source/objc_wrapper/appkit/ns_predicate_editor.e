note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PREDICATE_EDITOR

inherit
	NS_RULE_EDITOR
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSPredicateEditor

	set_row_templates_ (a_row_templates: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_row_templates__item: POINTER
		do
			if attached a_row_templates as a_row_templates_attached then
				a_row_templates__item := a_row_templates_attached.item
			end
			objc_set_row_templates_ (item, a_row_templates__item)
		end

	row_templates: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_row_templates (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like row_templates} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like row_templates} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPredicateEditor Externals

	objc_set_row_templates_ (an_item: POINTER; a_row_templates: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPredicateEditor *)$an_item setRowTemplates:$a_row_templates];
			 ]"
		end

	objc_row_templates (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicateEditor *)$an_item rowTemplates];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPredicateEditor"
		end

end
