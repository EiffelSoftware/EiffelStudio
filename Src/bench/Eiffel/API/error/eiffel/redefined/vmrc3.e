-- Error when a selection is needed

class VMRC3 

inherit

	EIFFEL_ERROR
		rename
			build_explain as old_build_explain
		end;

	EIFFEL_ERROR
		redefine
			build_explain
		select
			build_explain
		end
	
feature 

	selection_list: SELECTION_LIST;
			-- Info about the features to select

	set_selection_list (l: like selection_list) is
			-- Assign `l' to `selection_list'.
		do
			selection_list := l;
		end; -- set_selection_list

	code: STRING is "VMRC";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
		local
			info: INHERIT_INFO;
		do
            old_build_explain (a_clickable);
			from
				selection_list.start
			until
				selection_list.offright
			loop
				info := selection_list.item;
				if (info.parent = Void) then
					a_clickable.put_string ("%Tin current class: ");
				else
					a_clickable.put_string ("%Tin parent ");
					a_clickable.put_string (info.parent.class_name);
					a_clickable.put_string (": ");
				end;
				info.a_feature.append_clickable_signature (a_clickable);
				a_clickable.new_line;

				selection_list.forth;
			end;
		end;

end
