
class EWB_FUTURE 

inherit

	EWB_CMD

creation

	make, null

feature -- Creation

	make (cn, fn: STRING) is
		do
			class_name := cn;
			class_name.to_lower;
			feature_name := fn;
			feature_name.to_lower;
		end;

	class_name, feature_name: STRING;

feature

	name: STRING is "compute the history";

	loop_execute is
		do
			get_class_name;
			class_name := last_input;
			class_name.to_lower;
			get_feature_name;
			feature_name := last_input;
			feature_name.to_lower;
			execute;
		end;

	execute is
		local
			class_c: CLASS_C;
			feature_i: FEATURE_I;
			class_i: CLASS_I
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
                    class_i := Universe.unique_class (class_name);
                    if class_i /= Void then
                        class_c := class_i.compiled_class;
                    end;
					if class_c = Void then
						io.error.putstring (class_name);
						io.error.putstring (" is not in the system%N");
					else
						feature_i := class_c.feature_table.item (feature_name);
						if feature_i = Void then
							io.error.putstring (feature_name);
							io.error.putstring (" is not a feature of ");
							io.error.putstring (class_name);
							io.error.new_line
						else
							display_hist (error_window, feature_i, class_c);
						end;
					end;
				end;
			end;
		end;

	display_hist (display: CLICK_WINDOW; feature_i: FEATURE_I; class_c: CLASS_C) is
		local
			classes: SORTED_SET [CLASS_C];
			rout_id_set: ROUT_ID_SET;
			i: INTEGER;
			feature_table: FEATURE_TABLE;
			other_feature: FEATURE_I
		do
			!! classes.make;
			rec_add_descendants (classes, class_c);

			rout_id_set := feature_i.rout_id_set;
			from
				i := 1;
			until
				i > rout_id_set.count
			loop
				display.put_string ("%NHistory branch #");
				display.put_int (i);
				display.put_string ("%N-----------------%N");
				from
					classes.start
				until
					classes.after
				loop
					feature_table := classes.item.feature_table;
					from
						feature_table.start
					until
						feature_table.after
					loop
						other_feature := feature_table.item_for_iteration;
						if other_feature.rout_id_set.has (rout_id_set.item (i)) then
							classes.item.append_clickable_name (display);
							display.put_string (" ");
							other_feature.append_clickable_signature (display,classes.item);
							display.put_string ("%N%TVersion from class ");
							other_feature.written_class.append_clickable_name (display);
							display.new_line;	
						end;
						feature_table.forth
					end;
					classes.forth
				end;
				display.new_line;
				i := i + 1
			end;
		end;

	rec_add_descendants (ss: SORTED_SET [CLASS_C]; class_c: CLASS_C) is
		local
			descendants: LINKED_LIST [CLASS_C];
			desc_c: CLASS_C
		do
			descendants := class_c.descendants;
			ss.add (class_c);
			from
				descendants.start
			until
				descendants.after
			loop
				desc_c := descendants.item;
				if not ss.has (desc_c) then
					rec_add_descendants (ss, desc_c);
				end;
				descendants.forth;
			end;	
		end;

end
