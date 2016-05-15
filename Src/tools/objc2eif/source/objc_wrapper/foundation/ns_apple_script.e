note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APPLE_SCRIPT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_source_,
	make

feature {NONE} -- Initialization

--	make_with_contents_of_ur_l__error_ (a_url: detachable NS_URL; a_error_info: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_url__item: POINTER
--			a_error_info__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error_info as a_error_info_attached then
--				a_error_info__item := a_error_info_attached.item
--			end
--			make_with_pointer (objc_init_with_contents_of_ur_l__error_(allocate_object, a_url__item, a_error_info__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_source_ (a_source: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_source__item: POINTER
		do
			if attached a_source as a_source_attached then
				a_source__item := a_source_attached.item
			end
			make_with_pointer (objc_init_with_source_(allocate_object, a_source__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSAppleScript Externals

--	objc_init_with_contents_of_ur_l__error_ (an_item: POINTER; a_url: POINTER; a_error_info: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAppleScript *)$an_item initWithContentsOfURL:$a_url error:];
--			 ]"
--		end

	objc_init_with_source_ (an_item: POINTER; a_source: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleScript *)$an_item initWithSource:$a_source];
			 ]"
		end

	objc_source (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleScript *)$an_item source];
			 ]"
		end

	objc_is_compiled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAppleScript *)$an_item isCompiled];
			 ]"
		end

--	objc_compile_and_return_error_ (an_item: POINTER; a_error_info: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSAppleScript *)$an_item compileAndReturnError:];
--			 ]"
--		end

--	objc_execute_and_return_error_ (an_item: POINTER; a_error_info: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAppleScript *)$an_item executeAndReturnError:];
--			 ]"
--		end

--	objc_execute_apple_event__error_ (an_item: POINTER; a_event: POINTER; a_error_info: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAppleScript *)$an_item executeAppleEvent:$a_event error:];
--			 ]"
--		end

feature -- NSAppleScript

	source: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_source (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like source} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like source} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_compiled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_compiled (item)
		end

--	compile_and_return_error_ (a_error_info: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error_info__item: POINTER
--		do
--			if attached a_error_info as a_error_info_attached then
--				a_error_info__item := a_error_info_attached.item
--			end
--			Result := objc_compile_and_return_error_ (item, a_error_info__item)
--		end

--	execute_and_return_error_ (a_error_info: UNSUPPORTED_TYPE): detachable NS_APPLE_EVENT_DESCRIPTOR
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_error_info__item: POINTER
--		do
--			if attached a_error_info as a_error_info_attached then
--				a_error_info__item := a_error_info_attached.item
--			end
--			result_pointer := objc_execute_and_return_error_ (item, a_error_info__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like execute_and_return_error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like execute_and_return_error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	execute_apple_event__error_ (a_event: detachable NS_APPLE_EVENT_DESCRIPTOR; a_error_info: UNSUPPORTED_TYPE): detachable NS_APPLE_EVENT_DESCRIPTOR
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_event__item: POINTER
--			a_error_info__item: POINTER
--		do
--			if attached a_event as a_event_attached then
--				a_event__item := a_event_attached.item
--			end
--			if attached a_error_info as a_error_info_attached then
--				a_error_info__item := a_error_info_attached.item
--			end
--			result_pointer := objc_execute_apple_event__error_ (item, a_event__item, a_error_info__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like execute_apple_event__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like execute_apple_event__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAppleScript"
		end

end
