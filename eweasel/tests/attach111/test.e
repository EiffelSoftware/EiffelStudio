class TEST
create
	make
feature
	make
		local
			t: DS_HASH_TABLE [TEST, STRING]
		do
			create t.make_with_test (Void)
		end
end