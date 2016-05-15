note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TOKEN_FIELD

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

feature -- NSTokenField

	set_token_style_ (a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_token_style_ (item, a_style)
		end

	token_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_token_style (item)
		end

	set_completion_delay_ (a_delay: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_completion_delay_ (item, a_delay)
		end

	completion_delay: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_completion_delay (item)
		end

	set_tokenizing_character_set_ (a_character_set: detachable NS_CHARACTER_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_character_set__item: POINTER
		do
			if attached a_character_set as a_character_set_attached then
				a_character_set__item := a_character_set_attached.item
			end
			objc_set_tokenizing_character_set_ (item, a_character_set__item)
		end

	tokenizing_character_set: detachable NS_CHARACTER_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tokenizing_character_set (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tokenizing_character_set} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tokenizing_character_set} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSTokenField Externals

	objc_set_token_style_ (an_item: POINTER; a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTokenField *)$an_item setTokenStyle:$a_style];
			 ]"
		end

	objc_token_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTokenField *)$an_item tokenStyle];
			 ]"
		end

	objc_set_completion_delay_ (an_item: POINTER; a_delay: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTokenField *)$an_item setCompletionDelay:$a_delay];
			 ]"
		end

	objc_completion_delay (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTokenField *)$an_item completionDelay];
			 ]"
		end

	objc_set_tokenizing_character_set_ (an_item: POINTER; a_character_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTokenField *)$an_item setTokenizingCharacterSet:$a_character_set];
			 ]"
		end

	objc_tokenizing_character_set (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTokenField *)$an_item tokenizingCharacterSet];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTokenField"
		end

end
