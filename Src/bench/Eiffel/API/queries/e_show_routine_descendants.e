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

	work is
		local
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C];
			rout_id_set: ROUT_ID_SET;
			i: INTEGER;
			other_feature: E_FEATURE;
			e_class: CLASS_C;
		do
			!! classes.make;
			record_descendants (classes, current_class);

			rout_id_set := current_feature.rout_id_set;
			from
				i := 1;
			until
				i > rout_id_set.count
			loop
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
					e_class := classes.item;
					other_feature := e_class.feature_with_rout_id (rout_id_set.item (i));
					if other_feature /= Void then
						e_class.append_name (structured_text);
						structured_text.add (ti_Space);
						other_feature.append_signature (structured_text);
						structured_text.add_new_line;
						structured_text.add_indent;
						structured_text.add_string ("Version from class ");
						other_feature.written_class.append_name (structured_text);
						structured_text.add_new_line;	
					end;
					classes.forth
				end;
				i := i + 1
			end
		end;

end -- class E_SHOW_ROUTINE_FUTURE
