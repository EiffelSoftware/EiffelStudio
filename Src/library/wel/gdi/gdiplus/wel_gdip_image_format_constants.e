indexing
	description: "All image format constants used by gdi+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE_FORMAT_CONSTANTS

feature -- Total

	all_formats: ARRAYED_LIST [WEL_GDIP_IMAGE_FORMAT] is
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

	memoryBMP: WEL_GDIP_IMAGE_FORMAT is
    		-- Memory BMP format.
    	local
    		l_guid: WEL_GUID
    	once
    		create l_guid.make

    		-- {b96b3caa-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3caa)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
    	end

	bmp: WEL_GDIP_IMAGE_FORMAT is
			-- BMP format.
		local
			l_guid: WEL_GUID
		once
			create l_guid.make
			-- {b96b3cab-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3cab)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	emf: WEL_GDIP_IMAGE_FORMAT is
			-- EMF format.
		local
			l_guid: WEL_GUID
		once
			create l_guid.make
			-- {b96b3cac-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3cac)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	wmf: WEL_GDIP_IMAGE_FORMAT is
			-- WMF format.
		local
			l_guid: WEL_GUID
		once
			create l_guid.make
			-- {b96b3cad-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3cad)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	jpeg: WEL_GDIP_IMAGE_FORMAT is
			-- JPEG format.
		local
			l_guid: WEL_GUID
		once
			create l_guid.make
			-- {b96b3cae-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3cae)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	png: WEL_GDIP_IMAGE_FORMAT is
			-- PNG format.
		local
			l_guid: WEL_GUID
		once
			create l_guid.make
			-- {b96b3caf-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3caf)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	gif: WEL_GDIP_IMAGE_FORMAT is
			-- GIF format.
		local
			l_guid: WEL_GUID
		once
			create l_guid.make
			-- {b96b3cb0-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3cb0)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	tiff: WEL_GDIP_IMAGE_FORMAT is
			-- TIFF format.
		local
			l_guid: WEL_GUID
		once
			create l_guid.make
			-- {b96b3cb1-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3cb1)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	exif: WEL_GDIP_IMAGE_FORMAT is
			-- EXIF format.
		local
			l_guid: WEL_GUID
		once
			create l_guid.make
			-- {b96b3cb2-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3cb2)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	photoCD: WEL_GDIP_IMAGE_FORMAT is
			-- photoCD format.
		local
			l_guid: WEL_GUID
		once
			create l_guid.make
			-- {b96b3cb3-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3cb3)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	flashPIX: WEL_GDIP_IMAGE_FORMAT is
			-- flashPIX format.
		local
			l_guid: WEL_GUID
		once
			create l_guid.make
			-- {b96b3cb4-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3cb4)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
		end

	icon: WEL_GDIP_IMAGE_FORMAT is
			-- ICON format.
		local
			l_guid: WEL_GUID
		once
			create l_guid.make
			--{b96b3cb5-0728-11d3-9d7b-0000f81ef32e}

    		l_guid.set_data_1 (0xb96b3cb5)
    		l_guid.set_data_2 (0x0728)
    		l_guid.set_data_3 (0x11d3)

    		l_guid.set_data_4 (0x9d, 0)
    		l_guid.set_data_4 (0x7b, 1)
    		l_guid.set_data_4 (0x00, 2)
    		l_guid.set_data_4 (0x00, 3)
    		l_guid.set_data_4 (0xf8, 4)
    		l_guid.set_data_4 (0x1e, 5)
    		l_guid.set_data_4 (0xf3, 6)
    		l_guid.set_data_4 (0x2e, 7)

    		create Result.make (l_guid)
    	ensure
    		not_void: Result /= Void
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
