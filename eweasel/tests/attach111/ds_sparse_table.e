deferred class DS_SPARSE_TABLE [G, K]

inherit

	DS_LINEAR [G]

	DS_SPARSE_CONTAINER [G, K]
		rename
			make as make_sparse_container
		redefine
			new_cursor
		end

feature {NONE}

	make_with_test (t: detachable TEST)
		do
			equality_tester := t
			key_equality_tester := t
			make_sparse_container
			create internal_keys.make_with_table_cursor (Current, new_cursor)
			internal_keys.internal_set_equality_tester (key_equality_tester)
		end

feature

	new_cursor: DS_SPARSE_TABLE_CURSOR [G, K]
		do
			create Result.make (Current)
		end

	key_equality_tester: detachable TEST

	keys: DS_LINEAR [K]
		do
			Result := internal_keys
		end

feature {NONE}

	internal_keys: DS_SPARSE_TABLE_KEYS [G, K]

end
