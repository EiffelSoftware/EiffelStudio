indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.Encoder"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_ENCODER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (guid: GUID) is
		external
			"IL creator signature (System.Guid) use System.Drawing.Imaging.Encoder"
		end

feature -- Access

	frozen luminance_table: DRAWING_ENCODER is
		external
			"IL static_field signature :System.Drawing.Imaging.Encoder use System.Drawing.Imaging.Encoder"
		alias
			"LuminanceTable"
		end

	frozen save_flag: DRAWING_ENCODER is
		external
			"IL static_field signature :System.Drawing.Imaging.Encoder use System.Drawing.Imaging.Encoder"
		alias
			"SaveFlag"
		end

	frozen scan_method: DRAWING_ENCODER is
		external
			"IL static_field signature :System.Drawing.Imaging.Encoder use System.Drawing.Imaging.Encoder"
		alias
			"ScanMethod"
		end

	frozen get_guid: GUID is
		external
			"IL signature (): System.Guid use System.Drawing.Imaging.Encoder"
		alias
			"get_Guid"
		end

	frozen version: DRAWING_ENCODER is
		external
			"IL static_field signature :System.Drawing.Imaging.Encoder use System.Drawing.Imaging.Encoder"
		alias
			"Version"
		end

	frozen chrominance_table: DRAWING_ENCODER is
		external
			"IL static_field signature :System.Drawing.Imaging.Encoder use System.Drawing.Imaging.Encoder"
		alias
			"ChrominanceTable"
		end

	frozen quality: DRAWING_ENCODER is
		external
			"IL static_field signature :System.Drawing.Imaging.Encoder use System.Drawing.Imaging.Encoder"
		alias
			"Quality"
		end

	frozen transformation: DRAWING_ENCODER is
		external
			"IL static_field signature :System.Drawing.Imaging.Encoder use System.Drawing.Imaging.Encoder"
		alias
			"Transformation"
		end

	frozen render_method: DRAWING_ENCODER is
		external
			"IL static_field signature :System.Drawing.Imaging.Encoder use System.Drawing.Imaging.Encoder"
		alias
			"RenderMethod"
		end

	frozen compression: DRAWING_ENCODER is
		external
			"IL static_field signature :System.Drawing.Imaging.Encoder use System.Drawing.Imaging.Encoder"
		alias
			"Compression"
		end

	frozen color_depth: DRAWING_ENCODER is
		external
			"IL static_field signature :System.Drawing.Imaging.Encoder use System.Drawing.Imaging.Encoder"
		alias
			"ColorDepth"
		end

end -- class DRAWING_ENCODER
