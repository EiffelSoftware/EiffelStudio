indexing

	description: 
		"Command to display homonyms of `current_feature'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ROUTINE_HOMONYMNS 

inherit

	E_FEATURE_CMD
		redefine
			has_valid_feature
		end;
	SHARED_WORKBENCH

creation

	make, do_nothing

feature -- Access

	has_valid_feature: BOOLEAN is
			-- Always a valid feature
		do
			Result := True
		end

feature -- Execution

	execute is
			-- Execute Current command.
		local
			clusters: LINKED_LIST [CLUSTER_I];
			classes: EXTEND_TABLE [CLASS_I, STRING];
			classc: CLASS_C;
			feature_table: FEATURE_TABLE;
			feat: FEATURE_I;
			feature_name: STRING;
			class_name: STRING
		do
			feature_name := current_feature.feature_name;
			clusters := Universe.clusters;
			from 
				clusters.start 
			until 
				clusters.after 
			loop
				classes := clusters.item.classes;
				from 
					classes.start 
				until 
					classes.after 
				loop
					classc := classes.item_for_iteration.compiled_class;
					if classc /= Void then 
						feature_table := classc.feature_table;
						if feature_table.has (feature_name) then
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

end -- class E_SHOW_ROUTINE_HOMONYMNS
