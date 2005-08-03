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

create
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

	set_class_id (a_class_id: INTEGER) is
			-- Set `class_id' to `a_class_id'.
		do
			class_id := a_class_id
		end;
		
feature -- Output

	class_c: CLASS_C is
			-- CLASS_C associated with `Current'.
		do
			Result := Eiffel_system.class_of_id (class_id);
		end
		
	e_feature: E_FEATURE is
			-- E_FEATURE associated with `Current'.
			-- May be Void if feature was renamed or profile
			-- information is out of synch with the compiled project.
		local
			feature_i: FEATURE_I
		do
			feature_i := class_c.feature_table.item (feature_name)
			if feature_i /= Void then
				Result := feature_i.api_feature (class_id)
			else
					--| FIXME: It means that this feature has been renamed and
					--| its definition is not in `feature_table' from `class_c'.
					--| The only solution is to explicitely declare this feature
					--| as a renamed one in the profile tool
			end			
		end
				
	displayed_feature_name: STRING is
			-- Representation of `feature_name' to be displayed
			-- as part of profiler output.
		do
			if e_feature /= Void then
				Result := feature_name
			else
				Result := once "Renamed feature `" + feature_name + once "'"
			end
		end

	append_to (st: STRUCTURED_TEXT) is
			-- Append Current function to `st'.
		local
			cluster: CLUSTER_I	
			class_i: CLASS_I
			l_class_c: CLASS_C
			feature_i: FEATURE_I
			l_e_feature: E_FEATURE
		do
			if class_id = 0 then
				if int_cluster_name /= Void then
					cluster := Eiffel_universe.cluster_of_name (int_cluster_name);
					if cluster /= Void then
						class_i := Eiffel_universe.class_named (int_class_name, cluster);
						if class_i.is_compiled then	
							class_id := class_i.compiled_class.class_id;
						end
					end
				end

				st.add_string ("<cluster_tag>");
				st.add_string (int_class_name);
				st.add_string (feature_name);
			else
				if Eiffel_system.valid_class_id (class_id) then
					l_class_c := class_c
					st.add_string ("<");
					st.add_cluster (l_class_c.cluster, l_class_c.cluster.cluster_name);
					st.add_string (">");
					st.add_classi (l_class_c.lace_class, int_class_name);
					st.add_string (".");
					feature_i := l_class_c.feature_table.item (feature_name)
					if feature_i /= Void then
						l_e_feature := feature_i.api_feature (class_id)
						st.add_feature (l_e_feature, feature_name);
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
			create Result.make (0);
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

feature --{NONE} -- Access

	class_id: INTEGER
			-- Eiffel class

	int_class_name: STRING
		-- Name of class to which `feature_name' belongs.

	int_cluster_name: STRING
		-- Name of class to which `feature_name' belongs.

	feature_name: STRING
		-- Eiffel feature name as declared in source code.

end -- class EIFFEL_FUNCTION
