indexing

	description:
		"Information about an Eiffel feature.";
	date: "$Date$";
	revision: "$Revision$"

class EIFFEL_FUNCTION

inherit
	SHARED_EIFFEL_PROJECT
		undefine
			out
		end;
	LANGUAGE_FUNCTION
		redefine
			append_to
		end

creation
	make

feature -- Creation

	make (new_cluster_name, new_class_name, new_name: STRING) is
			-- Create an Eiffel feature with
			-- class `new_class', featurename `new_name'. I
		do
			int_cluster_name := new_cluster_name;
			int_class_name := new_class_name;
			feature_name := new_name;
		end;

	set_class (a_class: CLASS_C) is
			-- Set `e_class' to `a_class'.
		do
			class_id := a_class.class_id
		end;

feature -- Output

	append_to (st: STRUCTURED_TEXT) is
			-- Append Current function to `st'.
		local
			cluster: CLUSTER_I	
			class_i: CLASS_I
			class_c: CLASS_C
			feature_i: FEATURE_I
			e_feature: E_FEATURE
		do
			if class_id = 0 then
				if int_cluster_name /= Void then
					cluster := Eiffel_universe.cluster_of_name (int_cluster_name);
					if cluster /= Void then
						class_i := Eiffel_universe.class_named (int_class_name, cluster);
						if class_i.compiled then	
							class_id := class_i.compiled_class.class_id;
						end
					end
				end

				st.add_string ("<cluster_tag>");
				st.add_string (int_class_name);
				st.add_string (feature_name);
			else
				class_c := Eiffel_system.class_of_id (class_id);
				if class_c /= Void then
					st.add_string ("<");
					st.add_cluster (class_c.cluster, class_c.cluster.cluster_name);
					st.add_string (">");
					st.add_classi (class_c.lace_class, int_class_name);
					st.add_string (".");
					feature_i := class_c.feature_table.item (feature_name)
					if feature_i /= Void then
						e_feature := feature_i.api_feature (class_id)
						st.add_feature (e_feature, feature_name);
					else
							--| FIXME: It means that this feature has been renamed and
							--| its definition is not in `feature_table' from `class_c'.
							--| The only solution is to explicitely declare this feature
							--| as a renamed one in the profile tool
						st.add_string ("Renamed feature `")
						st.add_string (feature_name)
						st.add_string ("'")
					end
				else
					st.add_string (feature_name);
				end
			end;			
		end;

	name: STRING is
			-- The name of the feature.
		do
			!!Result.make (0);
			if class_id = 0 then
				Result.append ("<cluster_tag>")
			else
				Result.append (Eiffel_system.class_of_id (class_id).cluster.cluster_name)
			end
			Result.extend ('.');
			Result.append_string (int_class_name);
			Result.extend ('.');
			Result.append_string (feature_name);
		end;

feature {NONE} -- Access

	class_id: INTEGER
			-- Eiffel class

	int_class_name: STRING
		-- Name of class to which `feature_name' belongs.

	int_cluster_name: STRING
		-- Name of class to which `feature_name' belongs.

	feature_name: STRING
		-- Eiffel feature name as declared in source code.

end -- class EIFFEL_FUNCTION
