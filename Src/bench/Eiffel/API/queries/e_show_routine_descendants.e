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
			classes: PART_SORTED_TWO_WAY_LIST [E_CLASS];
			rout_id_set: ROUT_ID_SET;
			i: INTEGER;
			other_feature: E_FEATURE;
			e_class: E_CLASS;
		do
			!! classes.make;
			record_descendants (classes, current_class);

			rout_id_set := current_feature.rout_id_set;
			from
				i := 1;
			until
				i > rout_id_set.count
			loop
				structured_text.add_string ("%NHistory branch #");
				structured_text.add_int (i);
				structured_text.add_string ("%N-----------------%N");
				from
					classes.start
				until
					classes.after
				loop
					e_class := classes.item;
					other_feature := e_class.feature_with_rout_id (rout_id_set.item (i));
					if other_feature /= Void then
						e_class.append_name (structured_text);
						structured_text.add_string (" ");
						other_feature.append_signature (structured_text, classes.item);
						structured_text.add_string ("%N%TVersion from class ");
						other_feature.written_class.append_name (structured_text);
						structured_text.add_new_line;	
					end;
					classes.forth
				end;
				i := i + 1
			end
		end;

end -- class E_SHOW_ROUTINE_FUTURE
