indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- More_dialog_options ->  Caption_dialog_option | Class_dialog_option | Font_dialog_option |
--			   Menu_dialog_option | Style_dialog_option | Exstyle_dialog_option

class S_MORE_DIALOG_OPTIONS 

inherit
	RB_CHOICE

feature

	construct_name: STRING is
		once
			Result := "MORE_DIALOG_OPTIONS"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			caption: CAPTION_DIALOG_OPTION
			class_option: CLASS_DIALOG_OPTION
			font: FONT_DIALOG_OPTION
			menu: MENU_DIALOG_OPTION
			style: STYLE_DIALOG_OPTION
			exstyle: EXSTYLE_DIALOG_OPTION
		once
			!! Result.make
			Result.forth

			!! caption.make
			put (caption)

			!! class_option.make
			put (class_option)

			!! font.make
			put (font)

			!! menu.make
			put (menu)

			!! style.make
			put (style)

			!! exstyle.make
			put (exstyle)
		end

end -- class S_MORE_DIALOG_OPTIONS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
