indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.Matrix"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_MATRIX

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals
		end
	IDISPOSABLE

create
	make_drawing_matrix_2,
	make_drawing_matrix_3,
	make_drawing_matrix,
	make_drawing_matrix_1

feature {NONE} -- Initialization

	frozen make_drawing_matrix_2 (rect: DRAWING_RECTANGLE_F; plgpts: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL creator signature (System.Drawing.RectangleF, System.Drawing.PointF[]) use System.Drawing.Drawing2D.Matrix"
		end

	frozen make_drawing_matrix_3 (rect: DRAWING_RECTANGLE; plgpts: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL creator signature (System.Drawing.Rectangle, System.Drawing.Point[]) use System.Drawing.Drawing2D.Matrix"
		end

	frozen make_drawing_matrix is
		external
			"IL creator use System.Drawing.Drawing2D.Matrix"
		end

	frozen make_drawing_matrix_1 (m11: REAL; m12: REAL; m21: REAL; m22: REAL; dx: REAL; dy: REAL) is
		external
			"IL creator signature (System.Single, System.Single, System.Single, System.Single, System.Single, System.Single) use System.Drawing.Drawing2D.Matrix"
		end

feature -- Access

	frozen get_is_identity: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Drawing2D.Matrix"
		alias
			"get_IsIdentity"
		end

	frozen get_is_invertible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Drawing2D.Matrix"
		alias
			"get_IsInvertible"
		end

	frozen get_offset_y: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Drawing2D.Matrix"
		alias
			"get_OffsetY"
		end

	frozen get_offset_x: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Drawing2D.Matrix"
		alias
			"get_OffsetX"
		end

	frozen get_elements: NATIVE_ARRAY [REAL] is
		external
			"IL signature (): System.Single[] use System.Drawing.Drawing2D.Matrix"
		alias
			"get_Elements"
		end

feature -- Basic Operations

	frozen transform_points_array_point_f (pts: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"TransformPoints"
		end

	frozen rotate (angle: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Rotate"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Drawing2D.Matrix"
		alias
			"Equals"
		end

	frozen scale (scale_x: REAL; scale_y: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Scale"
		end

	frozen shear_single_single_matrix_order (shear_x: REAL; shear_y: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Shear"
		end

	frozen transform_vectors_array_point_f (pts: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"TransformVectors"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Drawing2D.Matrix"
		alias
			"GetHashCode"
		end

	frozen scale_single_single_matrix_order (scale_x: REAL; scale_y: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Scale"
		end

	frozen reset is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Reset"
		end

	frozen translate (offset_x: REAL; offset_y: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Translate"
		end

	frozen vector_transform_points (pts: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"VectorTransformPoints"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Dispose"
		end

	frozen rotate_at_single_point_f_matrix_order (angle: REAL; point: DRAWING_POINT_F; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Drawing.PointF, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"RotateAt"
		end

	frozen rotate_at (angle: REAL; point: DRAWING_POINT_F) is
		external
			"IL signature (System.Single, System.Drawing.PointF): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"RotateAt"
		end

	frozen multiply_matrix_matrix_order (matrix: DRAWING_MATRIX; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Multiply"
		end

	frozen clone_: DRAWING_MATRIX is
		external
			"IL signature (): System.Drawing.Drawing2D.Matrix use System.Drawing.Drawing2D.Matrix"
		alias
			"Clone"
		end

	frozen transform_points (pts: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"TransformPoints"
		end

	frozen rotate_single_matrix_order (angle: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Rotate"
		end

	frozen translate_single_single_matrix_order (offset_x: REAL; offset_y: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Translate"
		end

	frozen multiply (matrix: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Multiply"
		end

	frozen transform_vectors (pts: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"TransformVectors"
		end

	frozen invert is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Invert"
		end

	frozen shear (shear_x: REAL; shear_y: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Shear"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Finalize"
		end

end -- class DRAWING_MATRIX
