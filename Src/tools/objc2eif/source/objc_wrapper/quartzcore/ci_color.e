note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CI_COLOR

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature {NONE} -- Initialization

--	make_with_cg_color_ (a_c: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_c__item: POINTER
--		do
--			if attached a_c as a_c_attached then
--				a_c__item := a_c_attached.item
--			end
--			make_with_pointer (objc_init_with_cg_color_(allocate_object, a_c__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- CIColor Externals

--	objc_init_with_cg_color_ (an_item: POINTER; a_c: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIColor *)$an_item initWithCGColor:];
--			 ]"
--		end

	objc_number_of_components (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CIColor *)$an_item numberOfComponents];
			 ]"
		end

--	objc_components (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIColor *)$an_item components];
--			 ]"
--		end

	objc_alpha (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CIColor *)$an_item alpha];
			 ]"
		end

--	objc_color_space (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIColor *)$an_item colorSpace];
--			 ]"
--		end

	objc_red (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CIColor *)$an_item red];
			 ]"
		end

	objc_green (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CIColor *)$an_item green];
			 ]"
		end

	objc_blue (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CIColor *)$an_item blue];
			 ]"
		end

	objc_string_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIColor *)$an_item stringRepresentation];
			 ]"
		end

feature -- CIColor

	number_of_components: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_components (item)
		end

--	components: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_components (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like components} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like components} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	alpha: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alpha (item)
		end

--	color_space: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_color_space (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like color_space} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like color_space} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	red: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_red (item)
		end

	green: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_green (item)
		end

	blue: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_blue (item)
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
			Result := "CIColor"
		end

end
