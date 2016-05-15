note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SPELL_SERVER

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

feature -- NSSpellServer

	set_delegate_ (an_object: detachable NS_SPELL_SERVER_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	delegate: detachable NS_SPELL_SERVER_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	register_language__by_vendor_ (a_language: detachable NS_STRING; a_vendor: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_language__item: POINTER
			a_vendor__item: POINTER
		do
			if attached a_language as a_language_attached then
				a_language__item := a_language_attached.item
			end
			if attached a_vendor as a_vendor_attached then
				a_vendor__item := a_vendor_attached.item
			end
			Result := objc_register_language__by_vendor_ (item, a_language__item, a_vendor__item)
		end

	is_word_in_user_dictionaries__case_sensitive_ (a_word: detachable NS_STRING; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_word__item: POINTER
		do
			if attached a_word as a_word_attached then
				a_word__item := a_word_attached.item
			end
			Result := objc_is_word_in_user_dictionaries__case_sensitive_ (item, a_word__item, a_flag)
		end

	run
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_run (item)
		end

feature {NONE} -- NSSpellServer Externals

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSSpellServer *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellServer *)$an_item delegate];
			 ]"
		end

	objc_register_language__by_vendor_ (an_item: POINTER; a_language: POINTER; a_vendor: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSSpellServer *)$an_item registerLanguage:$a_language byVendor:$a_vendor];
			 ]"
		end

	objc_is_word_in_user_dictionaries__case_sensitive_ (an_item: POINTER; a_word: POINTER; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSSpellServer *)$an_item isWordInUserDictionaries:$a_word caseSensitive:$a_flag];
			 ]"
		end

	objc_run (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSSpellServer *)$an_item run];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSpellServer"
		end

end
