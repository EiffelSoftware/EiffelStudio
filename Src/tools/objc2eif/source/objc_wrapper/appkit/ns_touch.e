note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TOUCH

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
	make

feature -- Properties

--	identity: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_identity (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like identity} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like identity} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	phase: NATURAL_64
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_phase (item)
		end

	normalized_position: NS_POINT
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_normalized_position (item, Result.item)
		end

	is_resting: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_is_resting (item)
		end

	device: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_device (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like device} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like device} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	device_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_device_size (item, Result.item)
		end

feature {NONE} -- Properties Externals

--	objc_identity (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSTouch *)$an_item identity];
--			 ]"
--		end

	objc_phase (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTouch *)$an_item phase];
			 ]"
		end

	objc_normalized_position (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSTouch *)$an_item normalizedPosition];
			 ]"
		end

	objc_is_resting (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTouch *)$an_item isResting];
			 ]"
		end

	objc_device (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTouch *)$an_item device];
			 ]"
		end

	objc_device_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSTouch *)$an_item deviceSize];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTouch"
		end

end
