
class EWB_HISTORY 

inherit

	EWB_CMD
		rename
			name as implementers_cmd_name,
			help_message as implementers_help
		end

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

	name: STRING is "compute the implementers"

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
			rout_id: INTEGER;
			i: INTEGER;
			stop: BOOLEAN;
			written_in: INTEGER;
			feature_table: FEATURE_TABLE;
			feat: FEATURE_I;
			c: CLASS_C;
			written_cl: CLASS_C
		do
			!! classes.make;
			written_cl := feature_i.written_class;
			classes.add (feature_i.written_class);
			record_ancestors (classes, feature_i);
			record_descendants (classes, class_c, feature_i.rout_id_set.first);

			rout_id_set := feature_i.rout_id_set;
			from
				i := 1
			until
				i > rout_id_set.count
			loop
				rout_id := rout_id_set.item (i);
				display.put_string ("%NClass history branch #");
				display.put_int (i);
				display.put_string ("%N-----------------------%N");
				from
					classes.start;
				until
					classes.after
				loop
					c := classes.item;
					feature_table := c.feature_table;
					written_in := c.id;
					from
						stop := False;
						feature_table.start
					until
						feature_table.after or else stop
					loop
						feat := feature_table.item_for_iteration;
						if feat.written_in = written_in then
							if feat.rout_id_set.has (rout_id) or else
								rout_id_set.has (feat.rout_id_set.first) then
								c.append_clickable_name (display);
								if c = written_cl then
									display.put_string (" (version from)");
								end;
								--| I commented the next two lines 
								--| because Fred pleaded with me to
								--| do so (dinov).
								--display.put_string (".");
								--feat.append_clickable_name (display, c);
								display.new_line;
								stop := True;
							end
						end;
						feature_table.forth 
					end
					classes.forth
				end;
				i := i + 1
			end;
		end;

	record_ancestors (ss: SORTED_SET [CLASS_C]; f: FEATURE_I) is
		local
			assert_id_set: ASSERT_ID_SET;
			i, nb: INTEGER;
			inh_info: INH_ASSERT_INFO;
			class_c: CLASS_C
		do
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
						ss.add (class_c)
					end;
					i := i + 1
				end
			end;
		end;

	record_descendants (ss: SORTED_SET [CLASS_C]; 
						class_c: CLASS_C; rout_id: INTEGER) is
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
				if not ss.has (desc_c) then
					ss.add (desc_c)
				end;
				record_descendants (ss, desc_c, rout_id);
				descendants.forth;
			end;	
		end;

end
