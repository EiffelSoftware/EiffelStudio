indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataFormats"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DATA_FORMATS

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen palette: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"Palette"
		end

	frozen rtf: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"Rtf"
		end

	frozen text: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"Text"
		end

	frozen bitmap: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"Bitmap"
		end

	frozen dib: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"Dib"
		end

	frozen metafile_pict: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"MetafilePict"
		end

	frozen dif: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"Dif"
		end

	frozen file_drop: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"FileDrop"
		end

	frozen tiff: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"Tiff"
		end

	frozen oem_text: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"OemText"
		end

	frozen html: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"Html"
		end

	frozen unicode_text: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"UnicodeText"
		end

	frozen comma_separated_value: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"CommaSeparatedValue"
		end

	frozen pen_data: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"PenData"
		end

	frozen locale: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"Locale"
		end

	frozen riff: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"Riff"
		end

	frozen string_format: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"StringFormat"
		end

	frozen enhanced_metafile: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"EnhancedMetafile"
		end

	frozen symbolic_link: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"SymbolicLink"
		end

	frozen wave_audio: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"WaveAudio"
		end

	frozen serializable: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Windows.Forms.DataFormats"
		alias
			"Serializable"
		end

feature -- Basic Operations

	frozen get_format_string (format: SYSTEM_STRING): WINFORMS_FORMAT_IN_WINFORMS_DATA_FORMATS is
		external
			"IL static signature (System.String): System.Windows.Forms.DataFormats+Format use System.Windows.Forms.DataFormats"
		alias
			"GetFormat"
		end

	frozen get_format (id: INTEGER): WINFORMS_FORMAT_IN_WINFORMS_DATA_FORMATS is
		external
			"IL static signature (System.Int32): System.Windows.Forms.DataFormats+Format use System.Windows.Forms.DataFormats"
		alias
			"GetFormat"
		end

end -- class WINFORMS_DATA_FORMATS
