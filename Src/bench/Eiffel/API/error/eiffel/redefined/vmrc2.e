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

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		local
			u_class: CLASS_C;
			s_class: CLASS_C;
		do
			u_class := unvalid.written_class;
			s_class := selected.written_class;
			ow.put_string ("First version: ");
			selected.append_name (ow, s_class);
			ow.put_string (" from class: ");
			s_class.append_name (ow);
			ow.put_string ("Second version: ");
			unvalid.append_name (ow, u_class);
			ow.put_string (" from class: ");
			u_class.append_name (ow);
		end;

end
