indexing
	description: "Page containing contexts representing windows."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class WINDOW_PAGE 

inherit

	CONTEXT_CAT_PAGE

creation

	make
	
feature 

-- 	perm_wind_type: CONTEXT_TYPE

-- 	temp_wind_type: CONTEXT_TYPE

feature {NONE} -- Initialization

	build_interface is
		local
-- 			perm_wind_c: PERM_WIND_C
-- 			temp_wind_c: TEMP_WIND_C
		do
-- 			!!perm_wind_c
-- 			perm_wind_type := create_type (Widget_names.perm_wind_name, 
-- 					perm_wind_c, Pixmaps.cat_perm_wind_pixmap)
-- 
-- 			!!temp_wind_c
-- 			temp_wind_type := create_type (Widget_names.temp_wind_name, 
-- 					temp_wind_c, Pixmaps.cat_temp_wind_pixmap)
-- 			attach_left (perm_wind_type.source, 1)
-- 			attach_left_widget (perm_wind_type.source, 
-- 					temp_wind_type.source, 10)
-- 
-- 			attach_top (perm_wind_type.source, 1)
-- 			attach_top (temp_wind_type.source, 1)
-- 
-- 			button.set_focus_string (Focus_labels.windows_label)
		end

	tab_label: STRING is
		do
			Result := "Windows"
			-- XX Add once of type TAB_NAMES in CONSTANTS
		end


end -- class WINDOW_PAGE

