-- Error when a selection is needed

class VMRC3 obsolete "NOT DEFINED IN THE BOOK"

inherit

	VMRC
		redefine
			build_explain, subcode
		end
	
feature

	selection_list: SELECTION_LIST;
			-- Info about the features to select

	set_selection_list (l: like selection_list) is
			-- Assign `l' to `selection_list'.
		do
			selection_list := l;
		end; -- set_selection_list

	subcode: INTEGER is 2;

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		local
			info: INHERIT_INFO;
		do
			from
				selection_list.start
			until
				selection_list.after
			loop
				info := selection_list.item;
				if (info.parent = Void) then
					put_string ("In current class: ");
				else
					put_string ("In parent ");
					info.parent.parent.append_clickable_name (error_window);
					put_string (": ");
				end;
				info.a_feature.append_clickable_signature (error_window, info.a_feature.written_class);
				new_line;

				selection_list.forth;
			end;
		end;

end
