indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Multiline -> Accelerators_resource | Dialog_resource | DialogEx_resource | Menu_resource |
--              MenuEx_resource | Rcdata_resource | VersionInfo_resource | Textinclude_resource |
--              Dlginit_resource | Tool_bar_resource

class S_MULTILINE 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "MULTILINE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			accelerators: ACCELERATORS_RESOURCE
			dialog: DIALOG_RESOURCE
			dialogEx: DIALOGEX_RESOURCE
			menu: MENU_RESOURCE
			menuEx: MENUEX_RESOURCE
			rcdata: RCDATA_RESOURCE
			version: VERSIONINFO_RESOURCE
			textinclude: TEXTINCLUDE_RESOURCE
			dlginit: DLGINIT_RESOURCE
			toolbar: TOOLBAR_RESOURCE
		once
			!! Result.make
			Result.forth

			!! accelerators.make
			put (accelerators)

			!! dialog.make
			put (dialog)

			!! dialogEx.make
			put (dialogEx)

			!! menu.make
			put (menu)

			!! menuEx.make
			put (menuEx)

			!! rcdata.make
			put (rcdata)

			!! version.make
			put (version)

			!! textinclude.make
			put (textinclude)

			!! dlginit.make
			put (Dlginit)

			!! toolbar.make
			put (toolbar)
		end

end -- class S_MULTILINE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
