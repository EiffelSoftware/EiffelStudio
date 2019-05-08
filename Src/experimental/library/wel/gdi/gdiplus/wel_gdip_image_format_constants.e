note
	description: "All image format constants used by gdi+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE_FORMAT_CONSTANTS

obsolete
	"Use WEL_GDIP_IMAGE_ENCODER_CONSTANTS instead"

feature -- Total

	all_formats: ARRAYED_LIST [WEL_GDIP_IMAGE_FORMAT]
			-- All formats supported.
		do
			create Result.make (12)
			Result.extend (memorybmp)
			Result.extend (bmp)
			Result.extend (emf)
			Result.extend (wmf)
			Result.extend (jpeg)
			Result.extend (png)
			Result.extend (gif)
			Result.extend (tiff)
			Result.extend (exif)
			Result.extend (photocd)
			Result.extend (flashpix)
			Result.extend (icon)
		ensure
			not_void: Result /= Void
		end

feature -- Query

	memoryBMP: WEL_GDIP_IMAGE_FORMAT
    		-- Memory BMP format.
    	local
    		l_guid: WEL_GUID
    	once
    			-- {b96b3caa-0728-11d3-9d7b-0000f81ef32e}
    		create l_guid.make (0xb96b3caa, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} <<0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e>>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
    	end

	bmp: WEL_GDIP_IMAGE_FORMAT
			-- BMP format.
		local
			l_guid: WEL_GUID
		once
				-- {b96b3cab-0728-11d3-9d7b-0000f81ef32e}
			create l_guid.make (0xb96b3cab, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} << 0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e >>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	emf: WEL_GDIP_IMAGE_FORMAT
			-- EMF format.
		local
			l_guid: WEL_GUID
		once
				-- {b96b3cac-0728-11d3-9d7b-0000f81ef32e}
			create l_guid.make (0xb96b3cac, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} << 0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e >>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	wmf: WEL_GDIP_IMAGE_FORMAT
			-- WMF format.
		local
			l_guid: WEL_GUID
		once
				-- {b96b3cad-0728-11d3-9d7b-0000f81ef32e}
			create l_guid.make (0xb96b3cad, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} << 0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e >>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	jpeg: WEL_GDIP_IMAGE_FORMAT
			-- JPEG format.
		local
			l_guid: WEL_GUID
		once
				-- {b96b3cae-0728-11d3-9d7b-0000f81ef32e}
			create l_guid.make (0xb96b3cae, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} << 0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e >>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	png: WEL_GDIP_IMAGE_FORMAT
			-- PNG format.
		local
			l_guid: WEL_GUID
		once
				-- {b96b3caf-0728-11d3-9d7b-0000f81ef32e}
			create l_guid.make (0xb96b3caf, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} << 0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e >>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	gif: WEL_GDIP_IMAGE_FORMAT
			-- GIF format.
		local
			l_guid: WEL_GUID
		once
				-- {b96b3cb0-0728-11d3-9d7b-0000f81ef32e}
			create l_guid.make (0xb96b3cb0, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} << 0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e >>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	tiff: WEL_GDIP_IMAGE_FORMAT
			-- TIFF format.
		local
			l_guid: WEL_GUID
		once
				-- {b96b3cb1-0728-11d3-9d7b-0000f81ef32e}
			create l_guid.make (0xb96b3cb1, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} << 0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e >>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	exif: WEL_GDIP_IMAGE_FORMAT
			-- EXIF format.
		local
			l_guid: WEL_GUID
		once
				-- {b96b3cb2-0728-11d3-9d7b-0000f81ef32e}
			create l_guid.make (0xb96b3cb2, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} << 0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e >>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	photoCD: WEL_GDIP_IMAGE_FORMAT
			-- photoCD format.
		local
			l_guid: WEL_GUID
		once
				-- {b96b3cb3-0728-11d3-9d7b-0000f81ef32e}
			create l_guid.make (0xb96b3cb3, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} << 0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e >>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	flashPIX: WEL_GDIP_IMAGE_FORMAT
			-- flashPIX format.
		local
			l_guid: WEL_GUID
		once
				-- {b96b3cb4-0728-11d3-9d7b-0000f81ef32e}
			create l_guid.make (0xb96b3cb4, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} << 0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e >>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	icon: WEL_GDIP_IMAGE_FORMAT
			-- ICON format.
		local
			l_guid: WEL_GUID
		once
				--{b96b3cb5-0728-11d3-9d7b-0000f81ef32e}
			create l_guid.make (0xb96b3cb5, 0x0728, 0x11d3, {ARRAY [NATURAL_8]} << 0x9d, 0x7b, 0x00, 0x00, 0xf8, 0x1e, 0xf3, 0x2e >>)
    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
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
