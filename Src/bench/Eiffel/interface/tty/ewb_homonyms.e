-- Synonyms of `feature_i'.

class EWB_SYNONYMS 

inherit

	EWB_FEATURE
		rename
			name as synonyms_cmd_name,
			help_message as synonyms_help,
			abbreviation as synonyms_abb
		end

creation

	make, null

feature

	display (feature_i: FEATURE_I; class_c: CLASS_C) is
		local
			clusters: LINKED_LIST [CLUSTER_I];
			classes: EXTEND_TABLE [CLASS_I, STRING];
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING];
			features: HASH_TABLE [FEATURE_I, STRING];
			classcs: HASH_TABLE [CLASS_C, STRING];
			classi: CLASS_I;
			classc: CLASS_C;
			feature_table: FEATURE_TABLE;
			feat: FEATURE_I
		do
			!!sorted_class_names.make;
			feature_name := feature_i.feature_name;
			clusters := Universe.clusters;
			!! features.make (30);
			!! classcs.make (30);
			from clusters.start until clusters.after loop
				classes := clusters.item.classes;
				from classes.start until classes.after loop
					classc ?= classes.item_for_iteration.compiled_class;
					if classc /= Void then 
						feature_table := classc.feature_table;
						if feature_table.has (feature_name)  then
							class_name := classc.class_name;
							sorted_class_names.extend (class_name);
							feat := feature_table.item (feature_name);
							features.put (feat, class_name);
							classcs.put (classc, class_name)
						end
					end;
					classes.forth
				end;
				clusters.forth
			end;
			from sorted_class_names.start until sorted_class_names.after loop
				class_name := sorted_class_names.item;
				feat := features.item (class_name);
				classc := classcs.item (class_name);
				feat.append_clickable_signature (output_window, classc);
				output_window.put_string ("%N%TFrom class ");
				classc.append_clickable_signature (output_window);
				output_window.new_line;
				sorted_class_names.forth
			end
		end;

end -- class EWB_SYNONYMS
