
deferred class SORTED_PASS

inherit

	PASS
		redefine
			changed_classes, controler_of, new_controler
		end

feature

	changed_classes: PART_SORTED_TWO_WAY_LIST [COMP_PASS_C];

	new_controler (a_class: CLASS_C): COMP_PASS_C is
		deferred
		end;

	controler_of (a_class: CLASS_C): COMP_PASS_C is
			-- Find the controler of `a_class', create it if
			-- it does not exist
		local
			found: BOOLEAN;
			after: BOOLEAN;
			pass_c: COMP_PASS_C;
			current_class: CLASS_C;
			old_cursor: CURSOR
			local_changed_classes: PART_SORTED_TWO_WAY_LIST [COMP_PASS_C]
		do
			from
				local_changed_classes := changed_classes
				old_cursor := local_changed_classes.cursor;
				local_changed_classes.start
			until
				found or else after or else local_changed_classes.after
			loop
				pass_c := local_changed_classes.item;
				current_class := pass_c.associated_class;
				if current_class = a_class then
					found := True;
					Result := pass_c;
				elseif a_class < current_class then
					after := True;
				end;
				local_changed_classes.forth
			end;
			if not found then
				Result := new_controler (a_class);
				local_changed_classes.extend (Result);
			end;
			local_changed_classes.go_to (old_cursor);
		ensure then
			changed_classes.sorted
		end;

	sort is
			-- Sort the `changed_classes'
		do
			changed_classes.sort
		end;

end
