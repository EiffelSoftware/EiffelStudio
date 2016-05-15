note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_HELP_MANAGER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSHelpManager

	set_context_help__for_object_ (a_attr_string: detachable NS_ATTRIBUTED_STRING; a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_attr_string__item: POINTER
			a_object__item: POINTER
		do
			if attached a_attr_string as a_attr_string_attached then
				a_attr_string__item := a_attr_string_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_set_context_help__for_object_ (item, a_attr_string__item, a_object__item)
		end

	remove_context_help_for_object_ (a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_remove_context_help_for_object_ (item, a_object__item)
		end

	context_help_for_object_ (a_object: detachable NS_OBJECT): detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			result_pointer := objc_context_help_for_object_ (item, a_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like context_help_for_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like context_help_for_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	show_context_help_for_object__location_hint_ (a_object: detachable NS_OBJECT; a_pt: NS_POINT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_show_context_help_for_object__location_hint_ (item, a_object__item, a_pt.item)
		end

	open_help_anchor__in_book_ (a_anchor: detachable NS_STRING; a_book: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_anchor__item: POINTER
			a_book__item: POINTER
		do
			if attached a_anchor as a_anchor_attached then
				a_anchor__item := a_anchor_attached.item
			end
			if attached a_book as a_book_attached then
				a_book__item := a_book_attached.item
			end
			objc_open_help_anchor__in_book_ (item, a_anchor__item, a_book__item)
		end

	find_string__in_book_ (a_query: detachable NS_STRING; a_book: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_query__item: POINTER
			a_book__item: POINTER
		do
			if attached a_query as a_query_attached then
				a_query__item := a_query_attached.item
			end
			if attached a_book as a_book_attached then
				a_book__item := a_book_attached.item
			end
			objc_find_string__in_book_ (item, a_query__item, a_book__item)
		end

	register_books_in_bundle_ (a_bundle: detachable NS_BUNDLE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_bundle__item: POINTER
		do
			if attached a_bundle as a_bundle_attached then
				a_bundle__item := a_bundle_attached.item
			end
			Result := objc_register_books_in_bundle_ (item, a_bundle__item)
		end

feature {NONE} -- NSHelpManager Externals

	objc_set_context_help__for_object_ (an_item: POINTER; a_attr_string: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSHelpManager *)$an_item setContextHelp:$a_attr_string forObject:$a_object];
			 ]"
		end

	objc_remove_context_help_for_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSHelpManager *)$an_item removeContextHelpForObject:$a_object];
			 ]"
		end

	objc_context_help_for_object_ (an_item: POINTER; a_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHelpManager *)$an_item contextHelpForObject:$a_object];
			 ]"
		end

	objc_show_context_help_for_object__location_hint_ (an_item: POINTER; a_object: POINTER; a_pt: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSHelpManager *)$an_item showContextHelpForObject:$a_object locationHint:*((NSPoint *)$a_pt)];
			 ]"
		end

	objc_open_help_anchor__in_book_ (an_item: POINTER; a_anchor: POINTER; a_book: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSHelpManager *)$an_item openHelpAnchor:$a_anchor inBook:$a_book];
			 ]"
		end

	objc_find_string__in_book_ (an_item: POINTER; a_query: POINTER; a_book: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSHelpManager *)$an_item findString:$a_query inBook:$a_book];
			 ]"
		end

	objc_register_books_in_bundle_ (an_item: POINTER; a_bundle: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSHelpManager *)$an_item registerBooksInBundle:$a_bundle];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSHelpManager"
		end

end
