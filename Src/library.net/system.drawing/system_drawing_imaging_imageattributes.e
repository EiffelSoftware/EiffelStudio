indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.ImageAttributes"

frozen external class
	SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Imaging.ImageAttributes"
		end

feature -- Basic Operations

	frozen clear_color_key is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearColorKey"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.ImageAttributes"
		alias
			"ToString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.ImageAttributes"
		alias
			"GetHashCode"
		end

	frozen clear_threshold is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearThreshold"
		end

	frozen set_no_op is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetNoOp"
		end

	frozen clear_output_channel_color_adjust_type (type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearOutputChannel"
		end

	frozen set_no_op_color_adjust_type (type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetNoOp"
		end

	frozen set_output_channel (flags: SYSTEM_DRAWING_IMAGING_COLORCHANNELFLAG) is
		external
			"IL signature (System.Drawing.Imaging.ColorChannelFlag): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetOutputChannel"
		end

	frozen clear_threshold_color_adjust_type (type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearThreshold"
		end

	frozen set_brush_remap_table (map: ARRAY [SYSTEM_DRAWING_IMAGING_COLORMAP]) is
		external
			"IL signature (System.Drawing.Imaging.ColorMap[]): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetBrushRemapTable"
		end

	frozen clear_brush_remap_table is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearBrushRemapTable"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"Dispose"
		end

	frozen set_color_matrices (new_color_matrix: SYSTEM_DRAWING_IMAGING_COLORMATRIX; gray_matrix: SYSTEM_DRAWING_IMAGING_COLORMATRIX) is
		external
			"IL signature (System.Drawing.Imaging.ColorMatrix, System.Drawing.Imaging.ColorMatrix): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetColorMatrices"
		end

	frozen set_gamma (gamma: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetGamma"
		end

	frozen clear_output_channel is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearOutputChannel"
		end

	frozen set_output_channel_color_profile (color_profile_filename: STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetOutputChannelColorProfile"
		end

	frozen set_color_matrix_color_matrix_color_matrix_flag_color_adjust_type (new_color_matrix: SYSTEM_DRAWING_IMAGING_COLORMATRIX; mode: SYSTEM_DRAWING_IMAGING_COLORMATRIXFLAG; type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorMatrix, System.Drawing.Imaging.ColorMatrixFlag, System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetColorMatrix"
		end

	frozen set_color_key (color_low: SYSTEM_DRAWING_COLOR; color_high: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color, System.Drawing.Color): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetColorKey"
		end

	frozen set_color_matrices_color_matrix_color_matrix_color_matrix_flag (new_color_matrix: SYSTEM_DRAWING_IMAGING_COLORMATRIX; gray_matrix: SYSTEM_DRAWING_IMAGING_COLORMATRIX; flags: SYSTEM_DRAWING_IMAGING_COLORMATRIXFLAG) is
		external
			"IL signature (System.Drawing.Imaging.ColorMatrix, System.Drawing.Imaging.ColorMatrix, System.Drawing.Imaging.ColorMatrixFlag): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetColorMatrices"
		end

	frozen set_color_matrices_color_matrix_color_matrix_color_matrix_flag_color_adjust_type (new_color_matrix: SYSTEM_DRAWING_IMAGING_COLORMATRIX; gray_matrix: SYSTEM_DRAWING_IMAGING_COLORMATRIX; mode: SYSTEM_DRAWING_IMAGING_COLORMATRIXFLAG; type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorMatrix, System.Drawing.Imaging.ColorMatrix, System.Drawing.Imaging.ColorMatrixFlag, System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetColorMatrices"
		end

	frozen clear_remap_table_color_adjust_type (type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearRemapTable"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Imaging.ImageAttributes"
		alias
			"Clone"
		end

	frozen clear_no_op is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearNoOp"
		end

	frozen set_wrap_mode_wrap_mode_color_boolean (mode: SYSTEM_DRAWING_DRAWING2D_WRAPMODE; color: SYSTEM_DRAWING_COLOR; clamp: BOOLEAN) is
		external
			"IL signature (System.Drawing.Drawing2D.WrapMode, System.Drawing.Color, System.Boolean): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetWrapMode"
		end

	frozen set_gamma_single_color_adjust_type (gamma: REAL; type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Single, System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetGamma"
		end

	frozen set_remap_table_array_color_map_color_adjust_type (map: ARRAY [SYSTEM_DRAWING_IMAGING_COLORMAP]; type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorMap[], System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetRemapTable"
		end

	frozen set_threshold (threshold: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetThreshold"
		end

	frozen clear_output_channel_color_profile_color_adjust_type (type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearOutputChannelColorProfile"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Imaging.ImageAttributes"
		alias
			"Equals"
		end

	frozen clear_color_matrix is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearColorMatrix"
		end

	frozen get_adjusted_palette (palette: SYSTEM_DRAWING_IMAGING_COLORPALETTE; type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorPalette, System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"GetAdjustedPalette"
		end

	frozen set_wrap_mode_wrap_mode_color (mode: SYSTEM_DRAWING_DRAWING2D_WRAPMODE; color: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Drawing2D.WrapMode, System.Drawing.Color): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetWrapMode"
		end

	frozen set_remap_table (map: ARRAY [SYSTEM_DRAWING_IMAGING_COLORMAP]) is
		external
			"IL signature (System.Drawing.Imaging.ColorMap[]): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetRemapTable"
		end

	frozen clear_color_matrix_color_adjust_type (type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearColorMatrix"
		end

	frozen clear_gamma is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearGamma"
		end

	frozen set_color_matrix (new_color_matrix: SYSTEM_DRAWING_IMAGING_COLORMATRIX) is
		external
			"IL signature (System.Drawing.Imaging.ColorMatrix): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetColorMatrix"
		end

	frozen set_wrap_mode (mode: SYSTEM_DRAWING_DRAWING2D_WRAPMODE) is
		external
			"IL signature (System.Drawing.Drawing2D.WrapMode): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetWrapMode"
		end

	frozen set_output_channel_color_profile_string_color_adjust_type (color_profile_filename: STRING; type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.String, System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetOutputChannelColorProfile"
		end

	frozen clear_remap_table is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearRemapTable"
		end

	frozen clear_gamma_color_adjust_type (type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearGamma"
		end

	frozen clear_no_op_color_adjust_type (type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearNoOp"
		end

	frozen clear_output_channel_color_profile is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearOutputChannelColorProfile"
		end

	frozen set_output_channel_color_channel_flag_color_adjust_type (flags: SYSTEM_DRAWING_IMAGING_COLORCHANNELFLAG; type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorChannelFlag, System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetOutputChannel"
		end

	frozen set_color_matrix_color_matrix_color_matrix_flag (new_color_matrix: SYSTEM_DRAWING_IMAGING_COLORMATRIX; flags: SYSTEM_DRAWING_IMAGING_COLORMATRIXFLAG) is
		external
			"IL signature (System.Drawing.Imaging.ColorMatrix, System.Drawing.Imaging.ColorMatrixFlag): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetColorMatrix"
		end

	frozen set_threshold_single_color_adjust_type (threshold: REAL; type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Single, System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetThreshold"
		end

	frozen set_color_key_color_color_color_adjust_type (color_low: SYSTEM_DRAWING_COLOR; color_high: SYSTEM_DRAWING_COLOR; type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Color, System.Drawing.Color, System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"SetColorKey"
		end

	frozen clear_color_key_color_adjust_type (type: SYSTEM_DRAWING_IMAGING_COLORADJUSTTYPE) is
		external
			"IL signature (System.Drawing.Imaging.ColorAdjustType): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"ClearColorKey"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.ImageAttributes"
		alias
			"Finalize"
		end

end -- class SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES
