indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.Matrix"

frozen external class
	SYSTEM_DRAWING_DRAWING2D_MATRIX

inherit
	SYSTEM_MARSHALBYREFOBJECT
		rename
			is_equal as equals_object
		redefine
			finalize,
			get_hash_code,
			equals_object
		end
	SYSTEM_IDISPOSABLE
		rename
			is_equal as equals_object
		end

create
	make_matrix_3,
	make_matrix_2,
	make_matrix_1,
	make_matrix

feature {NONE} -- Initialization

	frozen make_matrix_3 (rect: SYSTEM_DRAWING_RECTANGLE; plgpts: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL creator signature (System.Drawing.Rectangle, System.Drawing.Point[]) use System.Drawing.Drawing2D.Matrix"
		end

	frozen make_matrix_2 (rect: SYSTEM_DRAWING_RECTANGLEF; plgpts: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL creator signature (System.Drawing.RectangleF, System.Drawing.PointF[]) use System.Drawing.Drawing2D.Matrix"
		end

	frozen make_matrix_1 (m11: REAL; m12: REAL; m21: REAL; m22: REAL; dx: REAL; dy: REAL) is
		external
			"IL creator signature (System.Single, System.Single, System.Single, System.Single, System.Single, System.Single) use System.Drawing.Drawing2D.Matrix"
		end

	frozen make_matrix is
		external
			"IL creator use System.Drawing.Drawing2D.Matrix"
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

	frozen get_elements: ARRAY [REAL] is
		external
			"IL signature (): System.Single[] use System.Drawing.Drawing2D.Matrix"
		alias
			"get_Elements"
		end

feature -- Basic Operations

	frozen transform_points_array_point_f (pts: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"TransformPoints"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Drawing2D.Matrix"
		alias
			"Equals"
		end

	frozen rotate (angle: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Rotate"
		end

	frozen clone: SYSTEM_DRAWING_DRAWING2D_MATRIX is
		external
			"IL signature (): System.Drawing.Drawing2D.Matrix use System.Drawing.Drawing2D.Matrix"
		alias
			"Clone"
		end

	frozen shear_single_single_matrix_order (shear_x: REAL; shear_y: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Shear"
		end

	frozen transform_vectors_array_point_f (pts: ARRAY [SYSTEM_DRAWING_POINTF]) is
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

	frozen scale_single_single_matrix_order (scale_x: REAL; scale_y: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
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

	frozen vector_transform_points (pts: ARRAY [SYSTEM_DRAWING_POINT]) is
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

	frozen scale (scale_x: REAL; scale_y: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Scale"
		end

	frozen rotate_at_single_point_f_matrix_order (angle: REAL; point: SYSTEM_DRAWING_POINTF; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Drawing.PointF, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"RotateAt"
		end

	frozen rotate_at (angle: REAL; point: SYSTEM_DRAWING_POINTF) is
		external
			"IL signature (System.Single, System.Drawing.PointF): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"RotateAt"
		end

	frozen multiply_matrix_matrix_order (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Multiply"
		end

	frozen transform_points (pts: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"TransformPoints"
		end

	frozen rotate_single_matrix_order (angle: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Rotate"
		end

	frozen translate_single_single_matrix_order (offset_x: REAL; offset_y: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Translate"
		end

	frozen multiply (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.Matrix"
		alias
			"Multiply"
		end

	frozen transform_vectors (pts: ARRAY [SYSTEM_DRAWING_POINT]) is
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

end -- class SYSTEM_DRAWING_DRAWING2D_MATRIX
