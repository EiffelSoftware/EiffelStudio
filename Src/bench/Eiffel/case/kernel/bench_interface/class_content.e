indexing

	description: 
		"Data related to the content of class information.%
		%This includes feature clauses, invariants and chart%
		%information.";
	date: "$Date$";
	revision: "$Revision $"

		-- Class information 
class CLASS_CONTENT

creation
		
	make, make_from_storer

feature -- Initialization

	make (cd: CLASS_DATA) is
		do
			!! feature_clause_list.make (cd);
			!! chart;
		end;

	make_from_storer (storer: S_CLASS_CONTENT; c_data: CLASS_DATA) is
		require
			valid_storer: storer /= Void;
			valid_c_data: c_data /= Void
		local
			i_l: FIXED_LIST [S_TAG_DATA];
			invariant_data: INVARIANT_DATA
			descr : DESCRIPTION_DATA
		do
		end;

feature -- Properties

	feature_clause_list: FEATURE_CLAUSE_LIST;
			-- Features of class

	invariants: ELEMENT_LIST [INVARIANT_DATA];
			-- Invariants of the current class

	chart: CLASS_CHART;
			-- Informal description of Current class

feature -- Access

	features: FEATURE_LIST is
		do
			!! Result.make;
			from
				feature_clause_list.start
			until
				feature_clause_list.after
			loop
				Result.append (feature_clause_list.item.features);
				feature_clause_list.forth
			end
		ensure
			valid_features: Result /= Void
		end;

feature -- Storage

	storage_info: S_CLASS_CONTENT is
		local
			f_l: FIXED_LIST [S_FEATURE_DATA];
			i_l: FIXED_LIST [S_TAG_DATA];
		do
			!! Result.make;	
			if not feature_clause_list.empty then
				Result.set_feature_clause_list (feature_clause_list.storage_info);
			end;
			if invariants /= Void and then not invariants.empty then
				!! i_l.make_filled (invariants.count);
				from
					i_l.start;
					invariants.start
				until
					invariants.after
				loop
					i_l.replace (invariants.item.storage_info);
					i_l.forth;
					invariants.forth
				end;
				Result.set_invariants (i_l);
			end;
			Result.set_chart (chart.storage_info);
		end;

		set_invariants (l: like invariants) is
			do
				invariants := l
			end

feature {CLASS_DATA} -- Implementation

	make_invariants is
			-- Create the invariants.
		do
			!! invariants.make;
		end;

invariant

	has_feature_clauses: feature_clause_list/= Void;
	has_features: features /= void;
	has_chart: chart /= void

end -- class CLASS_CONTENT
