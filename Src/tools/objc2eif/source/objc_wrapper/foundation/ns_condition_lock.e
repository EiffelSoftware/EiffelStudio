note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CONDITION_LOCK

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
	make_with_condition_,
	make

feature {NONE} -- Initialization

	make_with_condition_ (a_condition: INTEGER_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_condition_(allocate_object, a_condition))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSConditionLock Externals

	objc_init_with_condition_ (an_item: POINTER; a_condition: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSConditionLock *)$an_item initWithCondition:$a_condition];
			 ]"
		end

	objc_condition (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConditionLock *)$an_item condition];
			 ]"
		end

	objc_lock_when_condition_ (an_item: POINTER; a_condition: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConditionLock *)$an_item lockWhenCondition:$a_condition];
			 ]"
		end

	objc_try_lock (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConditionLock *)$an_item tryLock];
			 ]"
		end

	objc_try_lock_when_condition_ (an_item: POINTER; a_condition: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConditionLock *)$an_item tryLockWhenCondition:$a_condition];
			 ]"
		end

	objc_unlock_with_condition_ (an_item: POINTER; a_condition: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConditionLock *)$an_item unlockWithCondition:$a_condition];
			 ]"
		end

	objc_lock_before_date_ (an_item: POINTER; a_limit: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConditionLock *)$an_item lockBeforeDate:$a_limit];
			 ]"
		end

	objc_lock_when_condition__before_date_ (an_item: POINTER; a_condition: INTEGER_64; a_limit: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConditionLock *)$an_item lockWhenCondition:$a_condition beforeDate:$a_limit];
			 ]"
		end

	objc_set_name_ (an_item: POINTER; a_n: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConditionLock *)$an_item setName:$a_n];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSConditionLock *)$an_item name];
			 ]"
		end

feature -- NSConditionLock

	condition: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_condition (item)
		end

	lock_when_condition_ (a_condition: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_lock_when_condition_ (item, a_condition)
		end

	try_lock: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_try_lock (item)
		end

	try_lock_when_condition_ (a_condition: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_try_lock_when_condition_ (item, a_condition)
		end

	unlock_with_condition_ (a_condition: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unlock_with_condition_ (item, a_condition)
		end

	lock_before_date_ (a_limit: detachable NS_DATE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_limit__item: POINTER
		do
			if attached a_limit as a_limit_attached then
				a_limit__item := a_limit_attached.item
			end
			Result := objc_lock_before_date_ (item, a_limit__item)
		end

	lock_when_condition__before_date_ (a_condition: INTEGER_64; a_limit: detachable NS_DATE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_limit__item: POINTER
		do
			if attached a_limit as a_limit_attached then
				a_limit__item := a_limit_attached.item
			end
			Result := objc_lock_when_condition__before_date_ (item, a_condition, a_limit__item)
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

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSConditionLock"
		end

end
