
class EWB_HISTORY 

inherit

	EWB_FEATURE
		rename
			name as implementers_cmd_name,
			help_message as implementers_help,
			abbreviation as implementers_abb
		end

creation

	make, null

feature

	display (feature_i: FEATURE_I; class_c: CLASS_C) is
		local
			classes: PART_SORTED_SET [CLASS_C];
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
			classes.extend (feature_i.written_class);
			record_ancestors (classes, feature_i);
			record_descendants (classes, class_c, feature_i.rout_id_set.first);

			rout_id_set := feature_i.rout_id_set;
			from
				i := 1
			until
				i > rout_id_set.count
			loop
				rout_id := rout_id_set.item (i);
				output_window.put_string ("%NClass history branch #");
				output_window.put_int (i);
				output_window.put_string ("%N-----------------------%N");
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
								c.append_clickable_name (output_window);
								if c = written_cl then
									output_window.put_string (" (version from)");
								else
									output_window.put_string (" ");
									feat.append_clickable_signature (output_window, c);
								end;
								output_window.new_line;
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

	record_ancestors (ss: PART_SORTED_SET [CLASS_C]; f: FEATURE_I) is
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
						ss.extend (class_c)
					end;
					i := i + 1
				end
			end;
		end;

	record_descendants (ss: PART_SORTED_SET [CLASS_C]; 
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
					ss.extend (desc_c)
				end;
				record_descendants (ss, desc_c, rout_id);
				descendants.forth;
			end;	
		end;

end
