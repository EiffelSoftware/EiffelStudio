indexing

	description: 
		"Command to display descendants version of `current_feature'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ROUTINE_DESCENDANTS 

inherit

	E_FEATURE_CMD

creation

	make, do_nothing

feature -- Execution

	execute is
		local
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C];
			rout_id_set: ROUT_ID_SET;
			i: INTEGER;
			select_table: SELECT_TABLE;
			other_feature: FEATURE_I
		do
			!! classes.make;
			record_descendants (classes, current_class);

			rout_id_set := current_feature.rout_id_set;
			from
				i := 1;
			until
				i > rout_id_set.count
			loop
				output_window.put_string ("%NHistory branch #");
				output_window.put_int (i);
				output_window.put_string ("%N-----------------%N");
				from
					classes.start
				until
					classes.after
				loop
					select_table := classes.item.feature_table.origin_table;
					other_feature := select_table.item (rout_id_set.item (i).abs);
					if other_feature /= Void then
						classes.item.append_clickable_name (output_window);
						output_window.put_string (" ");
						other_feature.append_clickable_signature (output_window,classes.item);
						output_window.put_string ("%N%TVersion from class ");
						other_feature.written_class.append_clickable_name (output_window);
						output_window.new_line;	
					end;
					classes.forth
				end;
				i := i + 1
			end;
		end;

	record_descendants (classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]; class_c: CLASS_C) is
			-- Record the descendants of `class_c' to `classes'.
		local
			descendants: LINKED_LIST [CLASS_C];
			desc_c: CLASS_C
		do
			descendants := class_c.descendants;
			classes.extend (class_c);
			from
				descendants.start
			until
				descendants.after
			loop
				desc_c := descendants.item;
				if not classes.has (desc_c) then
					record_descendants (classes, desc_c);
				end;
				descendants.forth;
			end;	
		end;

end -- class E_SHOW_ROUTINE_FUTURE
