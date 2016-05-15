note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_USER_DEFAULTS_CONTROLLER

inherit
	NS_CONTROLLER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_defaults__initial_values_,
	makeial_values,
	make

feature {NONE} -- Initialization

	make_with_defaults__initial_values_ (a_defaults: detachable NS_USER_DEFAULTS; a_initial_values: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_defaults__item: POINTER
			a_initial_values__item: POINTER
		do
			if attached a_defaults as a_defaults_attached then
				a_defaults__item := a_defaults_attached.item
			end
			if attached a_initial_values as a_initial_values_attached then
				a_initial_values__item := a_initial_values_attached.item
			end
			make_with_pointer (objc_init_with_defaults__initial_values_(allocate_object, a_defaults__item, a_initial_values__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	makeial_values
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_initial_values(allocate_object))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSUserDefaultsController Externals

	objc_init_with_defaults__initial_values_ (an_item: POINTER; a_defaults: POINTER; a_initial_values: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaultsController *)$an_item initWithDefaults:$a_defaults initialValues:$a_initial_values];
			 ]"
		end

	objc_defaults (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaultsController *)$an_item defaults];
			 ]"
		end

	objc_set_initial_values_ (an_item: POINTER; a_initial_values: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSUserDefaultsController *)$an_item setInitialValues:$a_initial_values];
			 ]"
		end

	objc_initial_values (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaultsController *)$an_item initialValues];
			 ]"
		end

	objc_set_applies_immediately_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSUserDefaultsController *)$an_item setAppliesImmediately:$a_flag];
			 ]"
		end

	objc_applies_immediately (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSUserDefaultsController *)$an_item appliesImmediately];
			 ]"
		end

	objc_has_unapplied_changes (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSUserDefaultsController *)$an_item hasUnappliedChanges];
			 ]"
		end

	objc_values (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaultsController *)$an_item values];
			 ]"
		end

	objc_revert_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSUserDefaultsController *)$an_item revert:$a_sender];
			 ]"
		end

	objc_save_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSUserDefaultsController *)$an_item save:$a_sender];
			 ]"
		end

	objc_revert_to_initial_values_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSUserDefaultsController *)$an_item revertToInitialValues:$a_sender];
			 ]"
		end

feature -- NSUserDefaultsController

	defaults: detachable NS_USER_DEFAULTS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_defaults (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like defaults} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like defaults} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_initial_values_ (a_initial_values: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_initial_values__item: POINTER
		do
			if attached a_initial_values as a_initial_values_attached then
				a_initial_values__item := a_initial_values_attached.item
			end
			objc_set_initial_values_ (item, a_initial_values__item)
		end

	set_applies_immediately_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_applies_immediately_ (item, a_flag)
		end

	applies_immediately: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_applies_immediately (item)
		end

	has_unapplied_changes: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_unapplied_changes (item)
		end

	values: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_values (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like values} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like values} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	revert_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_revert_ (item, a_sender__item)
		end

	save_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_save_ (item, a_sender__item)
		end

	revert_to_initial_values_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_revert_to_initial_values_ (item, a_sender__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSUserDefaultsController"
		end

end
