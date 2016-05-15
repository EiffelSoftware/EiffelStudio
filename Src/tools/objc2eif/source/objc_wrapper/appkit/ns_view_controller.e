note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VIEW_CONTROLLER

inherit
	NS_RESPONDER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_nib_name__bundle_,
	make

feature {NONE} -- Initialization

	make_with_nib_name__bundle_ (a_nib_name_or_nil: detachable NS_STRING; a_nib_bundle_or_nil: detachable NS_BUNDLE)
			-- Initialize `Current'.
		local
			a_nib_name_or_nil__item: POINTER
			a_nib_bundle_or_nil__item: POINTER
		do
			if attached a_nib_name_or_nil as a_nib_name_or_nil_attached then
				a_nib_name_or_nil__item := a_nib_name_or_nil_attached.item
			end
			if attached a_nib_bundle_or_nil as a_nib_bundle_or_nil_attached then
				a_nib_bundle_or_nil__item := a_nib_bundle_or_nil_attached.item
			end
			make_with_pointer (objc_init_with_nib_name__bundle_(allocate_object, a_nib_name_or_nil__item, a_nib_bundle_or_nil__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSViewController Externals

	objc_init_with_nib_name__bundle_ (an_item: POINTER; a_nib_name_or_nil: POINTER; a_nib_bundle_or_nil: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSViewController *)$an_item initWithNibName:$a_nib_name_or_nil bundle:$a_nib_bundle_or_nil];
			 ]"
		end

	objc_set_represented_object_ (an_item: POINTER; a_represented_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSViewController *)$an_item setRepresentedObject:$a_represented_object];
			 ]"
		end

	objc_represented_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSViewController *)$an_item representedObject];
			 ]"
		end

	objc_set_title_ (an_item: POINTER; a_title: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSViewController *)$an_item setTitle:$a_title];
			 ]"
		end

	objc_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSViewController *)$an_item title];
			 ]"
		end

	objc_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSViewController *)$an_item view];
			 ]"
		end

	objc_load_view (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSViewController *)$an_item loadView];
			 ]"
		end

	objc_nib_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSViewController *)$an_item nibName];
			 ]"
		end

	objc_nib_bundle (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSViewController *)$an_item nibBundle];
			 ]"
		end

	objc_set_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSViewController *)$an_item setView:$a_view];
			 ]"
		end

feature -- NSViewController

	set_represented_object_ (a_represented_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_represented_object__item: POINTER
		do
			if attached a_represented_object as a_represented_object_attached then
				a_represented_object__item := a_represented_object_attached.item
			end
			objc_set_represented_object_ (item, a_represented_object__item)
		end

	represented_object: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_represented_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like represented_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like represented_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_title_ (a_title: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			objc_set_title_ (item, a_title__item)
		end

	title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	load_view
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_load_view (item)
		end

	nib_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_nib_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like nib_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like nib_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	nib_bundle: detachable NS_BUNDLE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_nib_bundle (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like nib_bundle} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like nib_bundle} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_view_ (item, a_view__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSViewController"
		end

end
