indexing

	description: 
		"Abstract description for a class format command which%
		%displays features of `current_class' that follow `criterium'.";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_CLASS_FORMAT_CMD

inherit

	SHARED_SERVER;
	E_CLASS_CMD

feature -- Access

	criterium (f: FEATURE_I): BOOLEAN is 
			-- Criterium for feature `f'
		deferred 
		end;

	any_criterium (f: FEATURE_I): BOOLEAN is
			-- True if:
			--	`f' is written in a descendant of ANY
			--	 or if formatted class is a parent of ANY
		do
			Result :=
				 f.written_class > System.any_class.compiled_class;
			Result := Result or
				(current_class <= System.any_class.compiled_class);
		ensure
			valid_result: Result implies 
				f.written_class > System.any_class.compiled_class or else
					current_class <= System.any_class.compiled_class
		end;

	display_feature (f: FEATURE_I; c: CLASS_C) is
			-- Display feature `f' defined in class `c'
			-- to the output window.
		do
			f.append_clickable_signature (output_window, c);
		end;

feature -- Execution

	execute is
			-- Display routines of `current_class' that follow `criterium'.
		local
				-- Compiler structures
			feature_table: FEATURE_TABLE;
			feature_i: FEATURE_I;
			class_c: CLASS_C;
			id: INTEGER;
				-- Temporary structures
			list: PART_SORTED_TWO_WAY_LIST [FEATURE_I];
			table: EXTEND_TABLE [PART_SORTED_TWO_WAY_LIST [FEATURE_I], INTEGER];
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C];
			c: like current_class
		do
			c := current_class;
			feature_table := Feat_tbl_server.item (c.id);
			
			-- Group the features in terms of their origin.
			from
				!!table.make (20);
				!!classes.make;
				feature_table.start
			until
				feature_table.after
			loop
				feature_i := feature_table.item_for_iteration;
				if criterium (feature_i) then
					class_c := feature_i.written_class;
					id := class_c.id;
					if table.has (id) then
						list := table.item (id);
					else
						!! list.make;
						table.put (list, id);
						classes.put_front (class_c);
					end;
					list.put_front (feature_i);
				end;
				feature_table.forth
			end;
			classes.sort;

				-- Display the features.
			from
				classes.start
			until
				classes.after
			loop
				output_window.put_string ("Class ");
				class_c := classes.item;
				class_c.append_clickable_signature (output_window);
				output_window.put_string (":%N%N");
				list := table.item (class_c.id);
				list.sort;
				from
					list.start
				until
					list.after
				loop
					feature_i := list.item;
					output_window.put_char ('%T');
					display_feature (feature_i, c);
					output_window.new_line;
					list.forth
				end;
				output_window.new_line;
				classes.forth
			end
		end

end -- class E_CLASS_FORMAT_CMD
