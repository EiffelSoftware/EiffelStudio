class
	TEST1 [G, H, I]

inherit
	TEST2 [I]

feature

	ad_hoc_record_by_signature (a_sig: I): LIST [I]
		local
			l_result: ARRAY [LIST [I]]
		do
			l_result := retrieve_signature (a_sig, "", Void)
		end

end
