indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.Path"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PATH

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen volume_separator_char: CHARACTER is
		external
			"IL static_field signature :System.Char use System.IO.Path"
		alias
			"VolumeSeparatorChar"
		end

	frozen invalid_path_chars: NATIVE_ARRAY [CHARACTER] is
		external
			"IL static_field signature :System.Char[] use System.IO.Path"
		alias
			"InvalidPathChars"
		end

	frozen directory_separator_char: CHARACTER is
		external
			"IL static_field signature :System.Char use System.IO.Path"
		alias
			"DirectorySeparatorChar"
		end

	frozen alt_directory_separator_char: CHARACTER is
		external
			"IL static_field signature :System.Char use System.IO.Path"
		alias
			"AltDirectorySeparatorChar"
		end

	frozen path_separator: CHARACTER is
		external
			"IL static_field signature :System.Char use System.IO.Path"
		alias
			"PathSeparator"
		end

feature -- Basic Operations

	frozen has_extension (path: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.IO.Path"
		alias
			"HasExtension"
		end

	frozen get_file_name_without_extension (path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.IO.Path"
		alias
			"GetFileNameWithoutExtension"
		end

	frozen get_extension (path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.IO.Path"
		alias
			"GetExtension"
		end

	frozen get_temp_file_name: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.IO.Path"
		alias
			"GetTempFileName"
		end

	frozen get_path_root (path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.IO.Path"
		alias
			"GetPathRoot"
		end

	frozen is_path_rooted (path: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.IO.Path"
		alias
			"IsPathRooted"
		end

	frozen get_temp_path: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.IO.Path"
		alias
			"GetTempPath"
		end

	frozen get_file_name (path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.IO.Path"
		alias
			"GetFileName"
		end

	frozen get_directory_name (path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.IO.Path"
		alias
			"GetDirectoryName"
		end

	frozen combine (path1: SYSTEM_STRING; path2: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.IO.Path"
		alias
			"Combine"
		end

	frozen change_extension (path: SYSTEM_STRING; extension: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.IO.Path"
		alias
			"ChangeExtension"
		end

	frozen get_full_path (path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.IO.Path"
		alias
			"GetFullPath"
		end

end -- class PATH
