note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CONDITION

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_LOCKING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSCondition

	wait
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_wait (item)
		end

	wait_until_date_ (a_limit: detachable NS_DATE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_limit__item: POINTER
		do
			if attached a_limit as a_limit_attached then
				a_limit__item := a_limit_attached.item
			end
			Result := objc_wait_until_date_ (item, a_limit__item)
		end

	signal
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_signal (item)
		end

	broadcast
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_broadcast (item)
		end

	set_name_ (a_n: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_n__item: POINTER
		do
			if attached a_n as a_n_attached then
				a_n__item := a_n_attached.item
			end
			objc_set_name_ (item, a_n__item)
		end

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSCondition Externals

	objc_wait (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCondition *)$an_item wait];
			 ]"
		end

	objc_wait_until_date_ (an_item: POINTER; a_limit: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCondition *)$an_item waitUntilDate:$a_limit];
			 ]"
		end

	objc_signal (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCondition *)$an_item signal];
			 ]"
		end

	objc_broadcast (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCondition *)$an_item broadcast];
			 ]"
		end

	objc_set_name_ (an_item: POINTER; a_n: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCondition *)$an_item setName:$a_n];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCondition *)$an_item name];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCondition"
		end

end
