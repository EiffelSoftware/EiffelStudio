indexing

	description: 
		"Class content information that includes features%
		%clauses, invariants and chart information";
	date: "$Date$";
	revision: "$Revision $"

class S_CLASS_CONTENT

inherit

	STORABLE

creation

	make

feature {NONE} -- Initialization

	make is
		do
			!! chart;
			!! feature_clause_list.make (2);
		end;

feature -- Properties

	feature_clause_list: ARRAYED_LIST [S_FEATURE_CLAUSE];
			-- Features of class

	invariants: FIXED_LIST [S_TAG_DATA];
			-- Invariants of the current class

	chart: S_CLASS_CHART
			-- Informal description of Current class

feature -- Setting values

	set_feature_clause_list (l: like feature_clause_list) is
			-- Set features to `l'.
			--| Allow empty features to be stored
			--| to disk (because of bench).
		do
			feature_clause_list := l
		end;

	set_invariants (l: like invariants) is
			-- Set invariants to `l'.
		do
			invariants := l
		end;

	set_chart (ch: like chart) is
			-- Set chart to `ch'.
		do
			chart := ch
		end;

invariant

	valid_chart: chart /= Void;
	valid_feature_clause_list: feature_clause_list /= Void

end -- class S_CLASS_CONTENT
