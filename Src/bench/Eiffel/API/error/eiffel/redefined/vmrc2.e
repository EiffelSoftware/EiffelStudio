-- Error when there is an addtional unvalid selection

class VMRC2 

inherit

	VMRC
		redefine
			build_explain, subcode
		end

feature

	subcode: INTEGER is 2;

	selected: FEATURE_I;

	unvalid: FEATURE_I;

	init (s: FEATURE_I; u: FEATURE_I) is
			-- Initialization
		do
			selected := s;
			unvalid := u;
		end;

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		local
			u_class: CLASS_C;
			s_class: CLASS_C;
		do
			u_class := unvalid.written_class;
			s_class := selected.written_class;
			put_string ("First version: ");
			selected.append_clickable_name (error_window, s_class);
			put_string (" from class: ");
			s_class.append_clickable_name (error_window);
			put_string ("Second version: ");
			unvalid.append_clickable_name (error_window, u_class);
			put_string (" from class: ");
			u_class.append_clickable_name (error_window);
		end;

end
