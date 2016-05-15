note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CI_VECTOR_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- CIVector

--	vector_with_values__count_ (a_values: UNSUPPORTED_TYPE; a_count: NATURAL_64): detachable CI_VECTOR
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_values__item: POINTER
--		do
--			if attached a_values as a_values_attached then
--				a_values__item := a_values_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_vector_with_values__count_ (l_objc_class.item, a_values__item, a_count)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like vector_with_values__count_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like vector_with_values__count_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	vector_with_x_ (a_x: REAL_64): detachable CI_VECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_vector_with_x_ (l_objc_class.item, a_x)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like vector_with_x_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like vector_with_x_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	vector_with_x___y_ (a_x: REAL_64; a_y: REAL_64): detachable CI_VECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_vector_with_x___y_ (l_objc_class.item, a_x, a_y)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like vector_with_x___y_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like vector_with_x___y_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	vector_with_x___y___z_ (a_x: REAL_64; a_y: REAL_64; a_z: REAL_64): detachable CI_VECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_vector_with_x___y___z_ (l_objc_class.item, a_x, a_y, a_z)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like vector_with_x___y___z_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like vector_with_x___y___z_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	vector_with_x___y___z___w_ (a_x: REAL_64; a_y: REAL_64; a_z: REAL_64; a_w: REAL_64): detachable CI_VECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_vector_with_x___y___z___w_ (l_objc_class.item, a_x, a_y, a_z, a_w)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like vector_with_x___y___z___w_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like vector_with_x___y___z___w_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	vector_with_string_ (a_representation: detachable NS_STRING): detachable CI_VECTOR
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
			result_pointer := objc_vector_with_string_ (l_objc_class.item, a_representation__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like vector_with_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like vector_with_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- CIVector Externals

--	objc_vector_with_values__count_ (a_class_object: POINTER; a_values: UNSUPPORTED_TYPE; a_count: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object vectorWithValues: count:$a_count];
--			 ]"
--		end

	objc_vector_with_x_ (a_class_object: POINTER; a_x: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object vectorWithX:$a_x];
			 ]"
		end

	objc_vector_with_x___y_ (a_class_object: POINTER; a_x: REAL_64; a_y: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object vectorWithX:$a_x Y:$a_y];
			 ]"
		end

	objc_vector_with_x___y___z_ (a_class_object: POINTER; a_x: REAL_64; a_y: REAL_64; a_z: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object vectorWithX:$a_x Y:$a_y Z:$a_z];
			 ]"
		end

	objc_vector_with_x___y___z___w_ (a_class_object: POINTER; a_x: REAL_64; a_y: REAL_64; a_z: REAL_64; a_w: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object vectorWithX:$a_x Y:$a_y Z:$a_z W:$a_w];
			 ]"
		end

	objc_vector_with_string_ (a_class_object: POINTER; a_representation: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object vectorWithString:$a_representation];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "CIVector"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
