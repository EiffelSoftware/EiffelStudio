indexing

	description: 
		"Display the implementers of a `current_feature'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ROUTINE_IMPLEMENTERS 

inherit

	E_FEATURE_CMD;
	SHARED_EIFFEL_PROJECT

creation

	make, do_nothing

feature -- Execution

	execute is
		local
			classes: PART_SORTED_TWO_WAY_LIST [E_CLASS];
			rout_id_set: ROUT_ID_SET;
			rout_id: ROUTINE_ID;
			i: INTEGER;
			stop: BOOLEAN;
			written_in: CLASS_ID;
			feat: E_FEATURE;
			c: E_CLASS;
			written_cl: E_CLASS;
			precursors: LIST [E_CLASS]
        do
			written_cl := current_feature.written_class;
			precursors := current_feature.precursors;
			!! classes.make;
			record_descendants (classes, current_class);
			if not classes.has (current_class) then
				classes.extend (current_class)
			end;
			if precursors /= Void then
				classes.append (precursors)
			end;
			rout_id_set := current_feature.rout_id_set;
			from
				i := 1
			until
				i > rout_id_set.count
			loop
				rout_id := rout_id_set.item (i);
				structured_text.add_new_line;
				structured_text.add_string ("Class history branch #");
				structured_text.add_int (i);
				structured_text.add_new_line;
				structured_text.add_string ("-----------------------");
				structured_text.add_new_line;
				from
					classes.start;
				until
					classes.after
				loop
					c := classes.item;
					written_in := c.id;
					feat := c.feature_with_rout_id (rout_id);
					if feat /= Void and then 
						equal (feat.written_in, written_in)
					then
						c.append_name (structured_text);
						structured_text.add_string (" ");
						feat.append_name (structured_text);
						if c = written_cl then
							structured_text.add_string (" (version from)");
						end;
						structured_text.add_new_line;
					end
					classes.forth
				end;
				i := i + 1
			end;
		end;

end -- class E_SHOW_ROUTINE_IMPLEMENTERS
