-- Information storage for the Polynomial language

class POLYNOM_INFO 

create

	make

feature 

	make is
		do
			create id_table.make;
			create id_value.make
		end; -- make

	end_session: BOOLEAN;

	child_value: INTEGER

feature {NONE}

	id_table: SORTED_TWO_WAY_LIST [STRING];
			-- List of identifiers in the polynom

	id_value: LINKED_LIST [INTEGER]
			-- List of values of the variables of the polynom

feature 

	set_child_value (i: INTEGER) is
		do
			child_value := i
		end;

	cons_id_table (s: STRING) is
			-- Fill the id_table with the identifiers found
			-- in the declarations list.
		do
			if not id_table.has (s) then
				id_table.extend (s);
				id_value.put_right (0)
			end
		end;

	print_id_table is
		do
			io.putstring ("id_table:%N");
			if not id_table.empty then
				from
					id_table.start
				until
					id_table.after
				loop
					io.putstring ("%T");
					io.putstring (id_table.item);
					io.putstring ("%N");
					id_table.forth
				end
			end
		end;

	set_value is
		do
			if not id_table.empty then
				io.putstring ("Enter the integer values (9999 to end):");
				id_value.wipe_out;
				id_value.forth
				io.new_line;
				from
					id_table.start
				until
					id_table.after
				loop
					io.putstring (id_table.item);
					io.putstring (": ");
					io.readint;
					id_value.put_left (io.lastint);
					end_session := io.lastint = 9999;
					id_table.forth
				end
			end
		end;

	int_value (s: STRING): INTEGER is
		do
			id_table.start;
			id_table.compare_objects
			id_table.search (s);
			if not (id_table.empty or id_table.after) then
				id_value.go_i_th (id_table.index);
				Result := id_value.item
			else
				io.putstring ("The variable ");
				io.putstring (s);
				io.putstring (" is not declared");
				io.new_line
			end
		end

end -- POLYNOM_INFO

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

