
class EWB_FUTURE 

inherit

	EWB_FEATURE
		rename
			name as descendants_cmd_name,
			help_message as dversions_help,
			abbreviation as descendants_abb
		end

creation

	make, null

feature

	display (feature_i: FEATURE_I; class_c: CLASS_C) is
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
				output_window.put_string ("%NHistory branch #");
				output_window.put_int (i);
				output_window.put_string ("%N-----------------%N");
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
							classes.item.append_clickable_name (output_window);
							output_window.put_string (" ");
							other_feature.append_clickable_signature (output_window,classes.item);
							output_window.put_string ("%N%TVersion from class ");
							other_feature.written_class.append_clickable_name (output_window);
							output_window.new_line;	
						end;
						feature_table.forth
					end;
					classes.forth
				end;
				output_window.new_line;
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
