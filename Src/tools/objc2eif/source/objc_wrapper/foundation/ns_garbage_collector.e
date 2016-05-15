note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_GARBAGE_COLLECTOR

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

feature -- NSGarbageCollector

	disable
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_disable (item)
		end

	enable
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_enable (item)
		end

	is_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_enabled (item)
		end

	collect_if_needed
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_collect_if_needed (item)
		end

	collect_exhaustively
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_collect_exhaustively (item)
		end

--	disable_collector_for_pointer_ (a_ptr: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_ptr__item: POINTER
--		do
--			if attached a_ptr as a_ptr_attached then
--				a_ptr__item := a_ptr_attached.item
--			end
--			objc_disable_collector_for_pointer_ (item, a_ptr__item)
--		end

--	enable_collector_for_pointer_ (a_ptr: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_ptr__item: POINTER
--		do
--			if attached a_ptr as a_ptr_attached then
--				a_ptr__item := a_ptr_attached.item
--			end
--			objc_enable_collector_for_pointer_ (item, a_ptr__item)
--		end

feature {NONE} -- NSGarbageCollector Externals

	objc_disable (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSGarbageCollector *)$an_item disable];
			 ]"
		end

	objc_enable (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSGarbageCollector *)$an_item enable];
			 ]"
		end

	objc_is_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSGarbageCollector *)$an_item isEnabled];
			 ]"
		end

	objc_collect_if_needed (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSGarbageCollector *)$an_item collectIfNeeded];
			 ]"
		end

	objc_collect_exhaustively (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSGarbageCollector *)$an_item collectExhaustively];
			 ]"
		end

--	objc_disable_collector_for_pointer_ (an_item: POINTER; a_ptr: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSGarbageCollector *)$an_item disableCollectorForPointer:];
--			 ]"
--		end

--	objc_enable_collector_for_pointer_ (an_item: POINTER; a_ptr: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSGarbageCollector *)$an_item enableCollectorForPointer:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSGarbageCollector"
		end

end
