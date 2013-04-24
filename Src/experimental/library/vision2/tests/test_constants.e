note
	description: "Constants to use in tests."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CONSTANTS

inherit
	ANY
		undefine
			default_create
		end

feature {NONE} -- Helpers

    red: EV_COLOR
    	once
    		create Result.make_with_rgb ({REAL_32}1.0, {REAL_32}0.0, {REAL_32}0.0)
    	end

    lenna: STRING
    	once
    		Result := "graphics/Lenna.png"
    	end

	bitmaps: ARRAYED_LIST [STRING]
		once
			create Result.make (10)
			Result.extend (lenna)
			Result.extend (image_01bpp)
			Result.extend (image_04bpp)
			Result.extend (image_08bpp)
			Result.extend (image_16bpp)
			Result.extend (image_24bpp)
			Result.extend (image_32bpp)
		end

	image_32bpp: STRING
		once
			Result := "graphics/32bpp.bmp"
		end

	image_24bpp: STRING
		once
			Result := "graphics/24bpp.bmp"
		end

	image_16bpp: STRING
		once
			Result := "graphics/16bpp.bmp"
		end

	image_08bpp: STRING
		once
			Result := "graphics/08bpp.bmp"
		end

	image_04bpp: STRING
		once
			Result := "graphics/04bpp.bmp"
		end

	image_01bpp: STRING
		once
			Result := "graphics/01bpp.bmp"
		end

    image_path: STRING_32 = "graphics/测试图片.png";

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
