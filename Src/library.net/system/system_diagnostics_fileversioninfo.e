indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.FileVersionInfo"

frozen external class
	SYSTEM_DIAGNOSTICS_FILEVERSIONINFO

inherit
	ANY
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_is_private_build: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.FileVersionInfo"
		alias
			"get_IsPrivateBuild"
		end

	frozen get_language: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_Language"
		end

	frozen get_internal_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_InternalName"
		end

	frozen get_file_version: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_FileVersion"
		end

	frozen get_file_minor_part: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.FileVersionInfo"
		alias
			"get_FileMinorPart"
		end

	frozen get_file_build_part: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.FileVersionInfo"
		alias
			"get_FileBuildPart"
		end

	frozen get_file_description: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_FileDescription"
		end

	frozen get_product_private_part: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.FileVersionInfo"
		alias
			"get_ProductPrivatePart"
		end

	frozen get_comments: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_Comments"
		end

	frozen get_product_version: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_ProductVersion"
		end

	frozen get_is_pre_release: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.FileVersionInfo"
		alias
			"get_IsPreRelease"
		end

	frozen get_legal_trademarks: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_LegalTrademarks"
		end

	frozen get_product_major_part: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.FileVersionInfo"
		alias
			"get_ProductMajorPart"
		end

	frozen get_special_build: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_SpecialBuild"
		end

	frozen get_company_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_CompanyName"
		end

	frozen get_private_build: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_PrivateBuild"
		end

	frozen get_legal_copyright: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_LegalCopyright"
		end

	frozen get_file_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_FileName"
		end

	frozen get_is_patched: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.FileVersionInfo"
		alias
			"get_IsPatched"
		end

	frozen get_is_special_build: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.FileVersionInfo"
		alias
			"get_IsSpecialBuild"
		end

	frozen get_product_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_ProductName"
		end

	frozen get_original_filename: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"get_OriginalFilename"
		end

	frozen get_product_minor_part: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.FileVersionInfo"
		alias
			"get_ProductMinorPart"
		end

	frozen get_product_build_part: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.FileVersionInfo"
		alias
			"get_ProductBuildPart"
		end

	frozen get_file_private_part: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.FileVersionInfo"
		alias
			"get_FilePrivatePart"
		end

	frozen get_is_debug: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.FileVersionInfo"
		alias
			"get_IsDebug"
		end

	frozen get_file_major_part: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.FileVersionInfo"
		alias
			"get_FileMajorPart"
		end

feature -- Basic Operations

	frozen get_version_info (file_name: STRING): SYSTEM_DIAGNOSTICS_FILEVERSIONINFO is
		external
			"IL static signature (System.String): System.Diagnostics.FileVersionInfo use System.Diagnostics.FileVersionInfo"
		alias
			"GetVersionInfo"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.FileVersionInfo"
		alias
			"ToString"
		end

end -- class SYSTEM_DIAGNOSTICS_FILEVERSIONINFO
