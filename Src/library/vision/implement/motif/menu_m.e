--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- MENU_M: implementation of menu

indexing

	date: "$Date$";
	revision: "$Revision$"

class MENU_M 

inherit

	MENU_R_M
		export
			{NONE} all
		end;

	MANAGER_M

feature {NONE}

	abstract_menu: MENU;
			-- Current abstract menu

feature 

	set_title (a_title: STRING) is
			-- Set menu title to `a_title'.
		require
			not_title_void: not (a_title = Void)
		local
			label_identifier: STRING;
			ext_name_title, ext_name: ANY
		do
			if title_label /= Void then	
				ext_name := MlabelString.to_c;
				ext_name_title := a_title.to_c;
				to_left_xm_string (title_label, $ext_name_title,
							$ext_name)
			else
				label_identifier := abstract_menu.identifier.duplicate;
				label_identifier.append ("Title");
				ext_name_title := a_title.to_c;
				ext_name := label_identifier.to_c;
				title_label := menu_set_title (screen_object,
								$ext_name_title, $ext_name)
			end
		end;

	remove_title is
			-- Remove current menu title if any.
		do
			if title_label /= Void then
				xt_destroy_widget (title_label);
				title_label := Void 
			end
		end;

	title: STRING is
			-- Title of current menu
		local
			ext_name: ANY
		do
			if title_label /= Void then
				ext_name := MlabelString.to_c;
				Result := from_xm_string (title_label, $ext_name)
			end
		end;

	
feature {NONE}

	title_label: POINTER

feature {NONE} -- External features

	menu_set_title (scr_obj: POINTER; name1, name2: ANY): POINTER is
		external
			"C"
		end;

	from_xm_string (value: POINTER; name: ANY): STRING is
		external
			"C"
		end;

	to_left_xm_string (value: POINTER; name1, name2: ANY) is
		external
			"C"
		end;

end

