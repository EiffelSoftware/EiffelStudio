
-- MENU_M: implementation of menu

indexing

	status: "See notice at end of class";
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
			ext_name_title, ext_name: ANY;
			null_label: POINTER;
		do
			if title_label /= null_label then
				ext_name := MlabelString.to_c;
				ext_name_title := a_title.to_c;
				to_left_xm_string (title_label, ext_name_title, ext_name)
			else
				label_identifier := clone (abstract_menu.identifier);
				label_identifier.append ("Title");
				ext_name_title := a_title.to_c;
				ext_name := label_identifier.to_c;
				title_label := menu_set_title (screen_object,
								$ext_name_title, ext_name)
			end
		end;

	remove_title is
			-- Remove current menu title if any.
		local
			null_label: POINTER;
		do
			if title_label /= null_label then
				xt_destroy_widget (title_label);
				title_label := null_label;
			end
		end;

	title: STRING is
			-- Title of current menu
		local
			ext_name: ANY;
			null_label: POINTER;
		do
			if title_label /= null_label then
				ext_name := MlabelString.to_c;
				Result := from_xm_string (title_label, $ext_name);
			end
		end;

	
feature {NONE}

	title_label: POINTER;


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



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
