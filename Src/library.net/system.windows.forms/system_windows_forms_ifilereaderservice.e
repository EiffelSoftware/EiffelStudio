indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.IFileReaderService"

deferred external class
	SYSTEM_WINDOWS_FORMS_IFILEREADERSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	open_file_from_source (relative_path: STRING): SYSTEM_IO_STREAM is
		external
			"IL deferred signature (System.String): System.IO.Stream use System.Windows.Forms.IFileReaderService"
		alias
			"OpenFileFromSource"
		end

end -- class SYSTEM_WINDOWS_FORMS_IFILEREADERSERVICE
