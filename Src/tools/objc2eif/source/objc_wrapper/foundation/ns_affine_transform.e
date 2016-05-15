note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_AFFINE_TRANSFORM

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
	make_with_transform_,
	make

feature {NONE} -- Initialization

	make_with_transform_ (a_transform: detachable NS_AFFINE_TRANSFORM)
			-- Initialize `Current'.
		local
			a_transform__item: POINTER
		do
			if attached a_transform as a_transform_attached then
				a_transform__item := a_transform_attached.item
			end
			make_with_pointer (objc_init_with_transform_(allocate_object, a_transform__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSAffineTransform Externals

	objc_init_with_transform_ (an_item: POINTER; a_transform: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAffineTransform *)$an_item initWithTransform:$a_transform];
			 ]"
		end

	objc_translate_x_by__y_by_ (an_item: POINTER; a_delta_x: REAL_64; a_delta_y: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAffineTransform *)$an_item translateXBy:$a_delta_x yBy:$a_delta_y];
			 ]"
		end

	objc_rotate_by_degrees_ (an_item: POINTER; a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAffineTransform *)$an_item rotateByDegrees:$a_angle];
			 ]"
		end

	objc_rotate_by_radians_ (an_item: POINTER; a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAffineTransform *)$an_item rotateByRadians:$a_angle];
			 ]"
		end

	objc_scale_by_ (an_item: POINTER; a_scale: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAffineTransform *)$an_item scaleBy:$a_scale];
			 ]"
		end

	objc_scale_x_by__y_by_ (an_item: POINTER; a_scale_x: REAL_64; a_scale_y: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAffineTransform *)$an_item scaleXBy:$a_scale_x yBy:$a_scale_y];
			 ]"
		end

	objc_invert (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAffineTransform *)$an_item invert];
			 ]"
		end

	objc_append_transform_ (an_item: POINTER; a_transform: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAffineTransform *)$an_item appendTransform:$a_transform];
			 ]"
		end

	objc_prepend_transform_ (an_item: POINTER; a_transform: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAffineTransform *)$an_item prependTransform:$a_transform];
			 ]"
		end

	objc_transform_point_ (an_item: POINTER; result_pointer: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSAffineTransform *)$an_item transformPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_transform_size_ (an_item: POINTER; result_pointer: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSAffineTransform *)$an_item transformSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_transform_struct (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSAffineTransformStruct *)$result_pointer = [(NSAffineTransform *)$an_item transformStruct];
			 ]"
		end

	objc_set_transform_struct_ (an_item: POINTER; a_transform_struct: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAffineTransform *)$an_item setTransformStruct:*((NSAffineTransformStruct *)$a_transform_struct)];
			 ]"
		end

feature -- NSAffineTransform

	translate_x_by__y_by_ (a_delta_x: REAL_64; a_delta_y: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_translate_x_by__y_by_ (item, a_delta_x, a_delta_y)
		end

	rotate_by_degrees_ (a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_rotate_by_degrees_ (item, a_angle)
		end

	rotate_by_radians_ (a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_rotate_by_radians_ (item, a_angle)
		end

	scale_by_ (a_scale: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scale_by_ (item, a_scale)
		end

	scale_x_by__y_by_ (a_scale_x: REAL_64; a_scale_y: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scale_x_by__y_by_ (item, a_scale_x, a_scale_y)
		end

	invert
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invert (item)
		end

	append_transform_ (a_transform: detachable NS_AFFINE_TRANSFORM)
			-- Auto generated Objective-C wrapper.
		local
			a_transform__item: POINTER
		do
			if attached a_transform as a_transform_attached then
				a_transform__item := a_transform_attached.item
			end
			objc_append_transform_ (item, a_transform__item)
		end

	prepend_transform_ (a_transform: detachable NS_AFFINE_TRANSFORM)
			-- Auto generated Objective-C wrapper.
		local
			a_transform__item: POINTER
		do
			if attached a_transform as a_transform_attached then
				a_transform__item := a_transform_attached.item
			end
			objc_prepend_transform_ (item, a_transform__item)
		end

	transform_point_ (a_point: NS_POINT): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_transform_point_ (item, Result.item, a_point.item)
		end

	transform_size_ (a_size: NS_SIZE): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_transform_size_ (item, Result.item, a_size.item)
		end

	transform_struct: NS_AFFINE_TRANSFORM_STRUCT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_transform_struct (item, Result.item)
		end

	set_transform_struct_ (a_transform_struct: NS_AFFINE_TRANSFORM_STRUCT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_transform_struct_ (item, a_transform_struct.item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAffineTransform"
		end

end
