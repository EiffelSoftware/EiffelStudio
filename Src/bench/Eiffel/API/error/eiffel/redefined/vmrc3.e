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
					io.error.putstring ("%Tin current class: ");
				else
					io.error.putstring ("%Tin parent ");
					io.error.putstring (info.parent.class_name);
					io.error.putstring (": ");
				end;
				io.error.putstring (info.a_feature.feature_name);
				io.error.new_line;

				selection_list.forth;
			end;
		end;

end
