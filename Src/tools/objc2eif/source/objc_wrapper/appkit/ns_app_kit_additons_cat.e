note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APP_KIT_ADDITONS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSAppKitAdditons

	transform_bezier_path_ (a_ns_affine_transform: NS_AFFINE_TRANSFORM; a_path: detachable NS_BEZIER_PATH): detachable NS_BEZIER_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			result_pointer := objc_transform_bezier_path_ (a_ns_affine_transform.item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like transform_bezier_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like transform_bezier_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set (a_ns_affine_transform: NS_AFFINE_TRANSFORM)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set (a_ns_affine_transform.item)
		end

	concat (a_ns_affine_transform: NS_AFFINE_TRANSFORM)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_concat (a_ns_affine_transform.item)
		end

feature {NONE} -- NSAppKitAdditons Externals

	objc_transform_bezier_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAffineTransform *)$an_item transformBezierPath:$a_path];
			 ]"
		end

	objc_set (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAffineTransform *)$an_item set];
			 ]"
		end

	objc_concat (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAffineTransform *)$an_item concat];
			 ]"
		end

end
