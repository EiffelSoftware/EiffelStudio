indexing

	description: 
		"Display the implementers of a `current_feature'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ROUTINE_IMPLEMENTERS 

inherit

	E_FEATURE_CMD;
	SHARED_WORKBENCH

creation

	make, do_nothing

feature -- Execution

	execute is
		local
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C];
			rout_id_set: ROUT_ID_SET;
			rout_id: INTEGER;
			i: INTEGER;
			stop: BOOLEAN;
			written_in: INTEGER;
			select_table: SELECT_TABLE;
			feat: FEATURE_I;
			c: CLASS_C;
			written_cl: CLASS_C
		do
			!! classes.make;
			written_cl := current_feature.written_class;
			record_ancestors (classes, current_feature);
			record_descendants (classes, current_class);
			if not classes.has (current_class) then
				classes.extend (current_class)
			end;
			rout_id_set := current_feature.rout_id_set;
			from
				i := 1
			until
				i > rout_id_set.count
			loop
				rout_id := rout_id_set.item (i).abs;
				output_window.put_string ("%NClass history branch #");
				output_window.put_int (i);
				output_window.put_string ("%N-----------------------%N");
				from
					classes.start;
				until
					classes.after
				loop
					c := classes.item;
					select_table := c.feature_table.origin_table;
					written_in := c.id;
					feat := select_table.item (rout_id);
					if feat /= Void and then 
						feat.written_in = written_in 
					then
						c.append_clickable_name (output_window);
						output_window.put_string (" ");
						feat.append_clickable_name (output_window, c);
						if c = written_cl then
							output_window.put_string (" (version from)");
						end;
						output_window.new_line;
					end
					classes.forth
				end;
				i := i + 1
			end;
		end;

	record_ancestors (classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]; f: FEATURE_I) is
			-- Record precursor definition of feature `f'.
		local
			assert_id_set: ASSERT_ID_SET;
			i, nb: INTEGER;
			inh_info: INH_ASSERT_INFO;
			class_c: CLASS_C
		do
			--| Get the assertion id set which records precursor.
			assert_id_set := f.assert_id_set;
			if assert_id_set /= Void then
				from
					nb := assert_id_set.count;
					i := 1
				until
					i > nb
				loop
					inh_info := assert_id_set.item (i);
					class_c := System.class_of_id (inh_info.written_in);
					if class_c /= Void then
						--| On the off chance that this information
						--| is not upto date hence the check with void
						classes.extend (class_c)
					end;
					i := i + 1
				end
			end;
		end;

	record_descendants (classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]; class_c: CLASS_C) is
			-- Record the descendents of `class_c' into `classes'.
		local
			descendants: LINKED_LIST [CLASS_C];
			desc_c: CLASS_C;
		do
			descendants := class_c.descendants;
			from
				descendants.start
			until
				descendants.after
			loop
				desc_c := descendants.item;
				if not classes.has (desc_c) then
					classes.extend (desc_c);
					record_descendants (classes, desc_c);
				end;
				descendants.forth;
			end;	
		end;

end -- class E_SHOW_ROUTINE_IMPLEMENTERS
