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

	set_indexes (list: like indexes) is
			-- Set indexes to `l'.
		require
			valid_list: list /= Void;
			list_not_empty: not list.empty;
			not_have_void: not list.has (Void)
		do
			indexes := list
		ensure
			indexes_set: indexes = list
		end;

end -- class S_CHART
