indexing

	description: 
		"Command to display ancestors version of `current_feature'.";
	date: "$Date$";
	revision: "$Revision $"


class E_SHOW_ROUTINE_ANCESTORS 

inherit

	E_FEATURE_CMD

creation

	make, do_nothing

feature -- Execution

	execute is
		local
			classes: PART_SORTED_TWO_WAY_LIST [E_CLASS];
			rout_id_set: ROUT_ID_SET;
			rout_id: ROUTINE_ID;
			i: INTEGER;
			other_feature: E_FEATURE;
			c: E_CLASS
		do
			!! classes.make;
			rec_add_parents (classes, current_class);

			rout_id_set := current_feature.rout_id_set;
			from
				i := 1;
			until
				i > rout_id_set.count
			loop
				rout_id := rout_id_set.item (i);
				structured_text.add_new_line;
				structured_text.add_string ("History branch #");
				structured_text.add_int (i);
				structured_text.add_new_line;
				structured_text.add_string ("-----------------");
				structured_text.add_new_line;
				from
					classes.start
				until
					classes.after
				loop
					c := classes.item;
					other_feature := c.feature_with_rout_id (rout_id);
					if other_feature /= Void then
						classes.item.append_name (structured_text);
						structured_text.add_string (" ");
						other_feature.append_signature (structured_text, classes.item);
						structured_text.add_new_line;
						structured_text.add_indent;
						structured_text.add_string ("Version from class ");
						other_feature.written_class.append_name (structured_text);
						structured_text.add_new_line;	
					end;
					classes.forth
				end;
				i := i + 1
			end;
		end;

	rec_add_parents (classes: PART_SORTED_TWO_WAY_LIST [E_CLASS]; 
			e_class: E_CLASS) is
			-- Record parents of `class_c' to `classes'.	
		local
			parents: FIXED_LIST [CL_TYPE_A];
			e_parent: E_CLASS
		do
			parents := e_class.parents;
			classes.extend (e_class);
			from
				parents.start
			until
				parents.after
			loop
				e_parent := parents.item.associated_eclass;
				if not classes.has (e_parent) then
					rec_add_parents (classes, e_parent);
				end;
				parents.forth;
			end;	
		end;

end -- class E_SHOW_ROUTINE_ANCESTORS
