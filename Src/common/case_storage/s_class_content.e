class S_CLASS_CONTENT

inherit

	STORABLE

feature -- Specification

	features: ARRAYED_LIST [S_FEATURE_DATA];
			-- Features of class

	invariants: FIXED_LIST [S_TAG_DATA];
			-- Invariants of the current class

	chart: S_CLASS_CHART
			-- Informal description of Current class

feature -- Setting values

	set_features (l: like features) is
			-- Set features to `l'.
			--| Allow empty features to be stored
			--| to disk (because of bench).
		do
			features := l
		end;
 
	set_invariants (l: like invariants) is
			-- Set invariants to `l'.
		do
io.error.putstring ("");
			invariants := l
		end;
 
	set_chart (ch: like chart) is
			-- Set chart to `ch'.
		do
			chart := ch
		end;

end

