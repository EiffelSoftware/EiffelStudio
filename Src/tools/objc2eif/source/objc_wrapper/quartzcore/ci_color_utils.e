note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CI_COLOR_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- CIColor

--	color_with_cg_color_ (a_c: UNSUPPORTED_TYPE): detachable CI_COLOR
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_c__item: POINTER
--		do
--			if attached a_c as a_c_attached then
--				a_c__item := a_c_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_color_with_cg_color_ (l_objc_class.item, a_c__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like color_with_cg_color_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like color_with_cg_color_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	color_with_red__green__blue__alpha_ (a_r: REAL_64; a_g: REAL_64; a_b: REAL_64; a_a: REAL_64): detachable CI_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_red__green__blue__alpha_ (l_objc_class.item, a_r, a_g, a_b, a_a)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_red__green__blue__alpha_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_red__green__blue__alpha_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_with_red__green__blue_ (a_r: REAL_64; a_g: REAL_64; a_b: REAL_64): detachable CI_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_red__green__blue_ (l_objc_class.item, a_r, a_g, a_b)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_red__green__blue_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_red__green__blue_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_with_string_ (a_representation: detachable NS_STRING): detachable CI_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_representation__item: POINTER
		do
			if attached a_representation as a_representation_attached then
				a_representation__item := a_representation_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_string_ (l_objc_class.item, a_representation__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- CIColor Externals

--	objc_color_with_cg_color_ (a_class_object: POINTER; a_c: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object colorWithCGColor:];
--			 ]"
--		end

	objc_color_with_red__green__blue__alpha_ (a_class_object: POINTER; a_r: REAL_64; a_g: REAL_64; a_b: REAL_64; a_a: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithRed:$a_r green:$a_g blue:$a_b alpha:$a_a];
			 ]"
		end

	objc_color_with_red__green__blue_ (a_class_object: POINTER; a_r: REAL_64; a_g: REAL_64; a_b: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithRed:$a_r green:$a_g blue:$a_b];
			 ]"
		end

	objc_color_with_string_ (a_class_object: POINTER; a_representation: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithString:$a_representation];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "CIColor"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
