indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.IFileReaderService"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IFILE_READER_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	open_file_from_source (relative_path: SYSTEM_STRING): SYSTEM_STREAM is
		external
			"IL deferred signature (System.String): System.IO.Stream use System.Windows.Forms.IFileReaderService"
		alias
			"OpenFileFromSource"
		end

end -- class WINFORMS_IFILE_READER_SERVICE
