
class EWB_PAST 

inherit

	EWB_FEATURE
		rename
			name as ancestors_cmd_name,
			help_message as aversions_help,
			abbreviation as ancestors_abb
		end

creation

	make, null

feature

	display (feature_i: FEATURE_I; class_c: CLASS_C) is
		local
			classes: PART_SORTED_SET [CLASS_C];
			rout_id_set: ROUT_ID_SET;
			i: INTEGER;
			feature_table: FEATURE_TABLE;
			other_feature: FEATURE_I
		do
			!! classes.make;
			rec_add_parents (classes, class_c);

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
							other_feature.append_clickable_signature (output_window, classes.item);
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

	rec_add_parents (ss: PART_SORTED_SET [CLASS_C]; class_c: CLASS_C) is
		local
			parents: FIXED_LIST [CL_TYPE_A];
			parent_c: CLASS_C
		do
			parents := class_c.parents;
			ss.extend (class_c);
			from
				parents.start
			until
				parents.after
			loop
				parent_c := parents.item.associated_class;
				if not ss.has (parent_c) then
					rec_add_parents (ss, parent_c);
				end;
				parents.forth;
			end;	
		end;

end
