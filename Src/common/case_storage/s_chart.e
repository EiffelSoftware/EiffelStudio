class S_CHART

feature

	version: S_TEXT_DATA;
		-- Version of chart

	indexes: FIXED_LIST [S_TEXT_DATA];
		-- Data on Current synonymn,
		-- application domain, authors,
		-- date of creation, revision level
		-- and keywords.

	descriptions: S_FREE_TEXT_DATA;
		-- Description of the purpose of the class

feature


	set_version (v: like version) is
			-- Set name to `s'.
		require
			valid_v: v /= Void
		do
			version := v
		ensure
			version_set: version = v
		end;

	set_indexes (l: like indexes) is
			-- Set indexes to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			indexes := l
		ensure
			indexes_set: indexes = l
		end;

	set_descriptions (l: like descriptions) is
			-- Set descriptions to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			descriptions := l
		ensure
			descriptions_set: descriptions = l
		end;

end

