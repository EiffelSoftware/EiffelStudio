-- Homonyms of `feature_i'.

class EWB_HOMONYMS 

inherit

	EWB_FEATURE
		rename
			name as homonyms_cmd_name,
			help_message as homonyms_help,
			abbreviation as homonyms_abb
		end

creation

	make, null

feature

	display (feature_i: FEATURE_I; class_c: CLASS_C) is
		local
			clusters: LINKED_LIST [CLUSTER_I];
			classes: EXTEND_TABLE [CLASS_I, STRING];
			classc: CLASS_C;
			feature_table: FEATURE_TABLE;
			feat: FEATURE_I
		do
			feature_name := feature_i.feature_name;
			clusters := Universe.clusters;
			from clusters.start until clusters.after loop
				classes := clusters.item.classes;
				from classes.start until classes.after loop
					classc ?= classes.item_for_iteration.compiled_class;
					if classc /= Void then 
						feature_table := classc.feature_table;
						if feature_table.has (feature_name)  then
							class_name := classc.class_name;
							feat := feature_table.item (feature_name);
							feat.append_clickable_signature (output_window, classc);
							output_window.put_string ("%N%TFrom class ");
							classc.append_clickable_signature (output_window);
							output_window.new_line;
						end
					end;
					classes.forth
				end;
				clusters.forth
			end
		end;

end -- class EWB_HOMONYMS
