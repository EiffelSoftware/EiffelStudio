indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Single_line -> Bitmap_resource | Cursor_resource | Icon_resource | Font_resource |
--                Messagetable_resource

class S_SINGLE_LINE 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "SINGLE_LINE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			anicursor: ANICURSOR_RESOURCE
			aniicon: ANIICON_RESOURCE
			bitmap: BITMAP_RESOURCE
			cursor: CURSOR_RESOURCE
			icon: ICON_RESOURCE
			font: FONT_RESOURCE
			messagetable: MESSAGETABLE_RESOURCE
		once
			!! Result.make
			Result.forth

			!! anicursor.make
			put (anicursor)

			!! aniicon.make
			put (aniicon)

			!! bitmap.make
			put (bitmap)

			!! cursor.make
			put (cursor)

			!! icon.make
			put (icon)

			!! font.make
			put (font)

			!! messagetable.make
			put (messagetable)
		end

end -- class S_SINGLE_LINE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
