indexing
	description: "[
					Image encoder used by Gdi+, 
					such as {WEL_GDIP_IMAGE}.save_image_to_file_with_encoder 
																							]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE_ENCODER

create
	make,
	make_empty

feature {NONE} -- Initlization

	make (a_guid: WEL_GUID) is
			-- Creation method
		require
			not_void: a_guid /= Void
		do
			guid := a_guid
		ensure
			set: guid = a_guid
		end

	make_empty is
			-- Creation method that makes nothing
			-- Used for query enumerations
		do
		end

feature -- Query

	guid: WEL_GUID
			-- Guid

	find_encoder: WEL_GDIP_IMAGE_CODEC_INFO is
			-- Find image encoder related.
		local
			l_all_encoders: ARRAYED_LIST [WEL_GDIP_IMAGE_CODEC_INFO]
			l_image: WEL_GDIP_IMAGE
		do
			from
				create l_image
				l_all_encoders := l_image.all_image_encoders
				l_all_encoders.start
			until
				l_all_encoders.after or Result /= Void
			loop
				if l_all_encoders.item.format_id.is_equal (guid) then
					Result := l_all_encoders.item
				end
				l_all_encoders.forth
			end
		end

feature -- Format encoders enumeration

	bmp: WEL_GDIP_IMAGE_ENCODER is
			-- Bmp format encoder
		do
			Result := find_encoder_with (create {STRING_32}.make_from_string ("image/bmp"))
		end

	jpg: WEL_GDIP_IMAGE_ENCODER is
			-- Jpeg format encoder
		do
			Result := find_encoder_with (create {STRING_32}.make_from_string ("image/jpeg"))
		end

	gif: WEL_GDIP_IMAGE_ENCODER is
			-- Gif format encoder
		do
			Result := find_encoder_with (create {STRING_32}.make_from_string ("image/gif"))
		end

	tiff: WEL_GDIP_IMAGE_ENCODER is
			-- Tiff format encoder
		do
			Result := find_encoder_with (create {STRING_32}.make_from_string ("image/tiff"))
		end

	png: WEL_GDIP_IMAGE_ENCODER is
			-- Png format encoder
		do
			Result := find_encoder_with (create {STRING_32}.make_from_string ("image/png"))
		end

feature -- Parameters type enumeration

	compression: !WEL_GUID is
			-- Gdi+ compression GUID
		once
			create Result.make ((-526552163).as_natural_32, (-13100).as_natural_16, 0x44ee, <<0x8e, 0xba, 0x3f, 0xbf, 0x8b, 0xe4, 0xfc, 0x58>>)
		end

	color_depth: !WEL_GUID is
			-- Gdi+ color depth GUID
		once
			create Result.make (0x66087055, (-21146).as_natural_16, 0x4c7c, <<0x9a, 0x18, 0x38, 0xa2, 0x31, 11, 0x83, 0x37>>)
		end

	scan_method: !WEL_GUID is
			-- Gdi+ scan method GUID
		once
			create Result.make (0x3a4e2661, 0x3109, 0x4e56, <<0x85, 0x36, 0x42, 0xc1, 0x56, 0xe7, 220, 250>>)
		end

	version: !WEL_GUID is
			-- Gdi+ version GUID
		once
			create Result.make (0x24d18c76, (-32438).as_natural_16, 0x41a4, <<0xbf, 0x53, 0x1c, 0x21, 0x9c, 0xcc, 0xf7, 0x97>>)
		end

	render_method: !WEL_GUID is
			-- Gdi+ render method GUID
		once
			create Result.make (0x6d42c53a, 0x229a, 0x4825, <<0x8b, 0xb7, 0x5c, 0x99, 0xe2, 0xb9, 0xa8, 0xb8>>)
		end

	quality: !WEL_GUID is
			-- Gdi+ quality GUID
		once
			create Result.make (0x1d5be4b5, (-1462).as_natural_16, 0x452d, <<0x9c, 0xdd, 0x5d, 0xb3, 0x51, 5, 0xe7, 0xeb>>)
		end

	transformation: !WEL_GUID is
			-- Gdi+ transformation GUID
		once
			create Result.make ((-1928416559).as_natural_32, (-23154).as_natural_16, 0x4ea8, <<170, 20, 0x10, 0x80, 0x74, 0xb7, 0xb6, 0xf9>>)
		end

	luminance_table: !WEL_GUID is
			-- Gdi+ luminance table GUID
		once
			create Result.make ((-307020850).as_natural_32, 0x266, 0x4a77, <<0xb9, 4, 0x27, 0x21, 0x60, 0x99, 0xe7, 0x17>>)
		end

	chrominance_table: !WEL_GUID is
			-- Gdi+ chrominance table GUID
		once
			create Result.make ((-219916836).as_natural_32, 0x9b3, 0x4316, <<130, 0x60, 0x67, 0x6a, 0xda, 50, 0x48, 0x1c>>)
		end

	save_flag: !WEL_GUID is
			-- Gdi+ save flag GUID
		once
			create Result.make (0x292266fc, (-21440).as_natural_16, 0x47bf, <<140, 0xfc, 0xa8, 0x5b, 0x89, 0xa6, 0x55, 0xde>>)
		end

feature -- Contract support

	is_valid (a_guid: !WEL_GUID): BOOLEAN is
			-- If `a_guid' valid?
		do
			Result := 	a_guid.is_equal (quality) or
						a_guid.is_equal (compression) or
						a_guid.is_equal (color_depth) or
						a_guid.is_equal (scan_method) or
						a_guid.is_equal (version) or
						a_guid.is_equal (render_method) or
						a_guid.is_equal (transformation) or
						a_guid.is_equal (luminance_table) or
						a_guid.is_equal (chrominance_table) or
						a_guid.is_equal (save_flag)
		end

feature {NONE} -- Implementation

	find_encoder_with (a_mini_type: !STRING_32): WEL_GDIP_IMAGE_ENCODER is
			-- Find encoder which mini type is `a_mini_type'.
			-- Result void if not found
		local
			l_all_encoders: ARRAYED_LIST [WEL_GDIP_IMAGE_CODEC_INFO]
			l_image: WEL_GDIP_IMAGE
			l_info: WEL_GDIP_IMAGE_CODEC_INFO
		do
			from
				create l_image
				l_all_encoders := l_image.all_image_encoders
				l_all_encoders.start
			until
				l_all_encoders.after or l_info /= Void
			loop
				if  l_all_encoders.item.mime_type.is_equal (a_mini_type) then
					l_info := l_all_encoders.item
				end
				l_all_encoders.forth
			end

			if l_info /= Void then
				create Result.make (l_info.cls_id)
			end
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

