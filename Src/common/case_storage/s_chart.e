class S_CHART

feature

	indexes: FIXED_LIST [S_TEXT_DATA];
		-- Data on Current synonymn,
		-- application domain, authors,
		-- date of creation, revision level
		-- and keywords.

	descriptions: S_FREE_TEXT_DATA;
		-- Purpose of the linkable

feature

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

	set_descriptions (l: like descriptions) is
			-- Set descriptions to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			descriptions := l
		ensure
			descriptions_set: descriptions = l
		end;

end

