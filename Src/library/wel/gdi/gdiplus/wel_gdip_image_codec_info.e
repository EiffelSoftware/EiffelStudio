note
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

	share_from_pointer (a_pointer: POINTER)
			-- Creation method
		do
			create internal_item.share_from_pointer (a_pointer, structure_size)
		end

feature -- Query

	structure_size: INTEGER
			-- Size of Current structure.
		do
			Result := c_size_of_image_codec_info
		end

	cls_id: WEL_GUID
			-- clsid
		do
			create Result.share_from_pointer (c_clsid (internal_item.item))
		end

	format_id: WEL_GUID
			-- FormatId
		do
			 create Result.share_from_pointer (c_format_id (internal_item.item))
		end

	format_description_string: STRING_32
			-- FormatDescription
		do
			Result := pointer_to_string (c_format_description (internal_item.item))
		end

	codec_name: STRING_32
			-- CodecName
		do
			Result := pointer_to_string (c_codec_name (internal_item.item))
		end

	dll_name: STRING_32
			-- DllName
		do
			Result := pointer_to_string (c_dll_name (internal_item.item))
		end

	filename_extension: STRING_32
			-- FilenameExtension
		do
			Result := pointer_to_string (c_filename_extension (internal_item.item))
		end

	mime_type: STRING_32
			-- MimeType
		do
			Result := pointer_to_string (c_mime_type (internal_item.item))
		end

	flags: INTEGER_64
			-- Flags
		do
			Result := c_flags (internal_item.item)
		end

	Version: INTEGER_64
			-- Version
		do
			Result := c_version (internal_item.item)
		end

	sig_count: INTEGER_64
			-- SigCount
		do
			Result := c_sig_count (internal_item.item)
		end

	sig_size: INTEGER_64
			-- SigSize
		do
			Result := c_sig_size (internal_item.item)
		end

	sig_pattern
			-- SigPattern
		do
			check not_implemented: False end
		end

	sig_mask
			-- SigMask
		do
			check not_implemented: False end
		end

feature {NONE} -- Implementation

	internal_item: MANAGED_POINTER
			-- Managed pointer to the struct.

	pointer_to_string (a_wel_string_poiner: POINTER): STRING_32
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

	c_size_of_image_codec_info: INTEGER
			-- GUID struct size.
		external
			"C [macro %"wel_gdi_plus.h%"]"
		alias
			"sizeof (ImageCodecInfo)"
		ensure
			is_class: class
		end

feature {NONE} -- C externals

	c_format_id (a_item: POINTER): POINTER
			-- `a_item''s formate id.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				&((ImageCodecInfo *)$a_item)->FormatID
			]"
		ensure
			is_class: class
		end

	c_format_description (a_item: POINTER): POINTER
			-- `a_item''s formation description.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((ImageCodecInfo *)$a_item)->FormatDescription
			]"
		ensure
			is_class: class
		end

	c_clsid (a_item: POINTER): POINTER
			-- `a_item''s clsid
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				&(((ImageCodecInfo *)$a_item)->Clsid)
			]"
		ensure
			is_class: class
		end

	c_codec_name (a_item: POINTER): POINTER
			-- `a_item''s codec name
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->CodecName
			]"
		ensure
			is_class: class
		end

	c_dll_name (a_item: POINTER): POINTER
			-- `a_item''s dll name
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->DllName
			]"
		ensure
			is_class: class
		end

	c_filename_extension (a_item: POINTER): POINTER
			-- `a_item''s filename extension
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->FilenameExtension
			]"
		ensure
			is_class: class
		end

	c_mime_type (a_item: POINTER): POINTER
			-- `a_item''s mime type
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->MimeType
			]"
		ensure
			is_class: class
		end

	c_flags (a_item: POINTER): INTEGER_64
			-- `a_item''s flags
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->Flags
			]"
		ensure
			is_class: class
		end

	c_version (a_item: POINTER): INTEGER_64
			-- `a_item''s version
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->Version
			]"
		ensure
			is_class: class
		end

	c_sig_count (a_item: POINTER): INTEGER_64
			-- `a_item''s sig count
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->SigCount
			]"
		ensure
			is_class: class
		end

	c_sig_size (a_item: POINTER): INTEGER_64
			-- `a_item''s sig size
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageCodecInfo *)$a_item)->SigSize
			]"
		ensure
			is_class: class
		end

feature -- Obsoletes

	format_description: WEL_STRING
			-- FormatDescription
		obsolete
			"Use `format_description_string' instead [2017-05-31]."
		do
			create Result.make_by_pointer (c_format_description (internal_item.item))
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
