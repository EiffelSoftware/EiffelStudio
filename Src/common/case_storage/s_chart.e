class S_CHART

feature

	indexes: FIXED_LIST [S_TAG_DATA];
		-- Data on Current synonymn,
		-- application domain, authors,
		-- date of creation, revision level
		-- and keywords.

	explanation: S_FREE_TEXT_DATA;
		-- Explanation of the linkable

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

	set_explanation (l: like explanation) is
			-- Set explanation to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			explanation := l
		ensure
			explanation_set: explanation = l
		end;

end

