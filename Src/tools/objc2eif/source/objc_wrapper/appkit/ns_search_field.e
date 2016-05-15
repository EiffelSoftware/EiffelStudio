note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SEARCH_FIELD

inherit
	NS_TEXT_FIELD
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSSearchField

	set_recent_searches_ (a_searches: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_searches__item: POINTER
		do
			if attached a_searches as a_searches_attached then
				a_searches__item := a_searches_attached.item
			end
			objc_set_recent_searches_ (item, a_searches__item)
		end

	recent_searches: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_recent_searches (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like recent_searches} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like recent_searches} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_recents_autosave_name_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_recents_autosave_name_ (item, a_string__item)
		end

	recents_autosave_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_recents_autosave_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like recents_autosave_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like recents_autosave_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSSearchField Externals

	objc_set_recent_searches_ (an_item: POINTER; a_searches: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchField *)$an_item setRecentSearches:$a_searches];
			 ]"
		end

	objc_recent_searches (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSearchField *)$an_item recentSearches];
			 ]"
		end

	objc_set_recents_autosave_name_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSearchField *)$an_item setRecentsAutosaveName:$a_string];
			 ]"
		end

	objc_recents_autosave_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSearchField *)$an_item recentsAutosaveName];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSearchField"
		end

end
