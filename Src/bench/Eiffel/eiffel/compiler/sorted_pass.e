
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
			position: INTEGER;
			current_class: CLASS_C;
		do
			from
				position := changed_classes.index;
				changed_classes.start
			until
				after or else changed_classes.after or else found
			loop
				pass_c := changed_classes.item;
				current_class := pass_c.associated_class;
				if current_class = a_class then
					found := True;
					Result := pass_c;
				elseif a_class < current_class then
					after := True;
				end;
				changed_classes.forth
			end;
			if not found then
				Result := new_controler (a_class);
				changed_classes.extend (Result);
			end;
			changed_classes.go_i_th (position);
		ensure then
			changed_classes.sorted
		end;

	sort is
			-- Sort the `changed_classes'
		do
			changed_classes.sort
		end;

end
