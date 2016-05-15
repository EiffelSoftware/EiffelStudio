note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CI_VECTOR

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_x_,
	make_with_x___y_,
	make_with_x___y___z_,
	make_with_x___y___z___w_,
	make_with_string_,
	make

feature {NONE} -- Initialization

--	make_with_values__count_ (a_values: UNSUPPORTED_TYPE; a_count: NATURAL_64)
--			-- Initialize `Current'.
--		local
--			a_values__item: POINTER
--		do
--			if attached a_values as a_values_attached then
--				a_values__item := a_values_attached.item
--			end
--			make_with_pointer (objc_init_with_values__count_(allocate_object, a_values__item, a_count))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_x_ (a_x: REAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_x_(allocate_object, a_x))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_x___y_ (a_x: REAL_64; a_y: REAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_x___y_(allocate_object, a_x, a_y))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_x___y___z_ (a_x: REAL_64; a_y: REAL_64; a_z: REAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_x___y___z_(allocate_object, a_x, a_y, a_z))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_x___y___z___w_ (a_x: REAL_64; a_y: REAL_64; a_z: REAL_64; a_w: REAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_x___y___z___w_(allocate_object, a_x, a_y, a_z, a_w))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_string_ (a_representation: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_representation__item: POINTER
		do
			if attached a_representation as a_representation_attached then
				a_representation__item := a_representation_attached.item
			end
			make_with_pointer (objc_init_with_string_(allocate_object, a_representation__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- CIVector Externals

--	objc_init_with_values__count_ (an_item: POINTER; a_values: UNSUPPORTED_TYPE; a_count: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIVector *)$an_item initWithValues: count:$a_count];
--			 ]"
--		end

	objc_init_with_x_ (an_item: POINTER; a_x: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIVector *)$an_item initWithX:$a_x];
			 ]"
		end

	objc_init_with_x___y_ (an_item: POINTER; a_x: REAL_64; a_y: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIVector *)$an_item initWithX:$a_x Y:$a_y];
			 ]"
		end

	objc_init_with_x___y___z_ (an_item: POINTER; a_x: REAL_64; a_y: REAL_64; a_z: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIVector *)$an_item initWithX:$a_x Y:$a_y Z:$a_z];
			 ]"
		end

	objc_init_with_x___y___z___w_ (an_item: POINTER; a_x: REAL_64; a_y: REAL_64; a_z: REAL_64; a_w: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIVector *)$an_item initWithX:$a_x Y:$a_y Z:$a_z W:$a_w];
			 ]"
		end

	objc_init_with_string_ (an_item: POINTER; a_representation: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIVector *)$an_item initWithString:$a_representation];
			 ]"
		end

	objc_value_at_index_ (an_item: POINTER; a_index: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CIVector *)$an_item valueAtIndex:$a_index];
			 ]"
		end

	objc_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CIVector *)$an_item count];
			 ]"
		end

	objc_x (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CIVector *)$an_item X];
			 ]"
		end

	objc_y (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CIVector *)$an_item Y];
			 ]"
		end

	objc_z (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CIVector *)$an_item Z];
			 ]"
		end

	objc_w (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CIVector *)$an_item W];
			 ]"
		end

	objc_string_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIVector *)$an_item stringRepresentation];
			 ]"
		end

feature -- CIVector

	value_at_index_ (a_index: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_value_at_index_ (item, a_index)
		end

	count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_count (item)
		end

	x: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_x (item)
		end

	y: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_y (item)
		end

	z: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_z (item)
		end

	w: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_w (item)
		end

	string_representation: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_representation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_representation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_representation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "CIVector"
		end

end
