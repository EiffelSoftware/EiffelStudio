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

	format_description: WEL_STRING is
			-- FormatDescription
		do
			create Result.make_by_pointer (c_format_description (internal_item.item))
		end

	codec_name: WEL_STRING is
			-- CodecName
		do
			check not_implemented: False end
		end

	dll_name: WEL_STRING is
			-- DllName
		do
			check not_implemented: False end
		end

	filename_extension: WEL_STRING is
			-- FilenameExtension
		do
			check not_implemented: False end
		end

	mime_type: WEL_STRING is
			-- MimeType
		do
			check not_implemented: False end
		end

	flags: INTEGER_64 is
			-- Flags
		do
			check not_implemented: False end
		end

	Version: INTEGER_64 is
			-- Version
		do
			check not_implemented: False end
		end

	sig_count: INTEGER_64 is
			-- SigCount
		do
			check not_implemented: False end
		end

	sig_size: INTEGER_64
			-- SigSize
		do
			check not_implemented: False end
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
