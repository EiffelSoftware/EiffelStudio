indexing

	description: 
		"Chart information based on the BON method.";
	date: "$Date$";
	revision: "$Revision $"

class S_CHART

feature -- Property

	indexes: FIXED_LIST [S_TAG_DATA];
		-- Data on Current synonymn,
		-- application domain, authors,
		-- date of creation, revision level
		-- and keywords.

feature -- Setting

	set_indexes (l: like indexes) is
			-- Set indexes to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			indexes := l
		ensure
			indexes_set: indexes = l
		end;

end -- class S_CHART
