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
	SHARED_EIFFEL_PROJECT

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
			e_class: E_CLASS;
			feat: E_FEATURE;
			feature_name: STRING;
			class_name: STRING
		do
			feature_name := current_feature.name;
			clusters := Eiffel_universe.clusters;
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
					e_class := classes.item_for_iteration.compiled_eclass;
					if e_class /= Void then 
						feat := e_class.feature_with_name (feature_name);
						if feat /= Void then
							class_name := e_class.name;
							feat.append_signature (structured_text, e_class);
							structured_text.add_string ("%N%TFrom class ");
							e_class.append_signature (structured_text);
							structured_text.add_new_line;
						end
					end;
					classes.forth
				end;
				clusters.forth
			end
		end;

end -- class E_SHOW_ROUTINE_HOMONYMNS
