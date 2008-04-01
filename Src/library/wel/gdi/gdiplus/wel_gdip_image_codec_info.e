indexing
	description: "ImageCodecInfo struct used by Gdi+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE_CODEC_INFO

create
	share_from_pointer

feature {NONE} -- Initlization

	share_from_pointer (a_pointer: POINTER) is
			-- Creation method
		do
			create internal_item.share_from_pointer (a_pointer, structure_size)
		end

feature -- Query

	structure_size: INTEGER is
			-- Size of Current structure.
		do
			Result := c_size_of_image_codec_info
		end

	cls_id: WEL_GUID is
			-- clsid
		do
			create Result.share_from_pointer (c_clsid (internal_item.item))
		end

	format_id: WEL_GUID is
			-- FormatId
		do
			 create Result.share_from_pointer (c_format_id (internal_item.item))
		end

	format_description_string: STRING_32 is
			-- FormatDescription
		do
			Result := pointer_to_string (c_format_description (internal_item.item))
		end

	codec_name: STRING_32 is
			-- CodecName
		do
			Result := pointer_to_string (c_codec_name (internal_item.item))
		end

	dll_name: STRING_32 is
			-- DllName
		do
			Result := pointer_to_string (c_dll_name (internal_item.item))
		end

	filename_extension: STRING_32 is
			-- FilenameExtension
		do
			Result := pointer_to_string (c_filename_extension (internal_item.item))
		end

	mime_type: STRING_32 is
			-- MimeType
		do
			Result := pointer_to_string (c_mime_type (internal_item.item))
		end

	flags: INTEGER_64 is
			-- Flags
		do
			Result := c_flags (internal_item.item)
		end

	Version: INTEGER_64 is
			-- Version
		do
			Result := c_version (internal_item.item)
		end

	sig_count: INTEGER_64 is
			-- SigCount
		do
			Result := c_sig_count (internal_item.item)
		end

	sig_size: INTEGER_64
			-- SigSize
		do
			Result := c_sig_size (internal_item.item)
		end

	sig_pattern is
			-- SigPattern
		do
			check not_implemented: False end
		end

	sig_mask is
			-- SigMask
		do
			check not_implemented: False end
		end

feature {NONE} -- Implementation

	internal_item: MANAGED_POINTER
			-- Managed pointer to the struct.

	pointer_to_string (a_wel_string_poiner: POINTER): STRING_32 is
			-- Convert from `a_wel_string_pointer' to Result STRING_32
		require
			valid: a_wel_string_poiner /= default_pointer
		local
			l_wel_string: WEL_STRING
		do
			create l_wel_string.make_by_pointer (a_wel_string_poiner)
			Result := l_wel_string.string
		ensure
			not_void: Result /= Void
		end

feature -- C externals

	c_size_of_image_codec_info: INTEGER is
			-- GUID struct size.
		external
			"C [macro %"wel_gdi_plus.h%"]"
		alias
			"sizeof (ImageCodecInfo)"
		end

feature {NONE} -- C externals

	c_format_id (a_item: POINTER): POINTER is
			-- `a_item''s formate id.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				&((ImageCodecInfo *)$a_item)->FormatID
			]"
		end

	c_format_description (a_item: POINTER): POINTER is
			-- `a_item''s formation description.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((ImageCodecInfo *)$a_item)->FormatDescription
			]"
		end

	c_clsid (a_item: POINTER): POINTER is
			-- `a_item''s clsid
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				&(((ImageCodecInfo *)$a_item)->Clsid)
			]"
		end

	c_codec_name (a_item: POINTER): POINTER is
			-- `a_item''s codec name
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->CodecName
			]"
		end

	c_dll_name (a_item: POINTER): POINTER is
			-- `a_item''s dll name
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->DllName
			]"
		end

	c_filename_extension (a_item: POINTER): POINTER is
			-- `a_item''s filename extension
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->FilenameExtension
			]"
		end

	c_mime_type (a_item: POINTER): POINTER is
			-- `a_item''s mime type
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->MimeType
			]"
		end

	c_flags (a_item: POINTER): INTEGER_64 is
			-- `a_item''s flags
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->Flags
			]"
		end

	c_version (a_item: POINTER): INTEGER_64 is
			-- `a_item''s version
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->Version
			]"
		end

	c_sig_count (a_item: POINTER): INTEGER_64 is
			-- `a_item''s sig count
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->SigCount
			]"
		end

	c_sig_size (a_item: POINTER): INTEGER_64 is
			-- `a_item''s sig size
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->SigSize
			]"
		end

feature -- Obsoletes

	format_description: WEL_STRING is
			-- FormatDescription
		obsolete
			"Use `format_description_string' instead"
		do
			create Result.make_by_pointer (c_format_description (internal_item.item))
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
