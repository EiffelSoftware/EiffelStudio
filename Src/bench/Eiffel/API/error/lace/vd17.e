-- Error when unvaid file name in C/Object file name list

class VD17

inherit

	ERROR
		redefine
			build_explain
		end

feature

	file_name: ID_SD;
			-- File name involved

	file_name_list: LACE_LIST [ID_SD];
			-- File name list

	set_file_name (fn: ID_SD) is
			-- Assign `fn' to `file_name'.
		do
			file_name := fn;
		end;

	set_file_name_list (l: like file_name_list) is
			-- Assign `l' to `file_name_list'.
		do
			file_name_list := l;
		end;

	code: STRING is "VD17";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
		do
not in the system ?????
		end;

end
