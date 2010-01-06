class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Perform test
		local
			l_aa_list: !ARRAYED_LIST [!STRING]

			l_any: ?ANY
			l_a_any: !ANY

			l_dd_al_string: ?ARRAYED_LIST [?STRING]
			l_da_al_string: ?ARRAYED_LIST [!STRING]
			l_ad_al_string: !ARRAYED_LIST [?STRING]
			l_aa_al_string: !ARRAYED_LIST [!STRING]

			l_dd_al_any: ?ARRAYED_LIST [?ANY]
			l_da_al_any: ?ARRAYED_LIST [!ANY]
			l_ad_al_any: !ARRAYED_LIST [?ANY]
			l_aa_al_any: !ARRAYED_LIST [!ANY]

			l_dd_bi_string: ?BILINEAR [?STRING]
			l_da_bi_string: ?BILINEAR [!STRING]
			l_ad_bi_string: !BILINEAR [?STRING]
			l_aa_bi_string: !BILINEAR [!STRING]

			l_dd_bi_any: ?BILINEAR [?ANY]
			l_da_bi_any: ?BILINEAR [!ANY]
			l_ad_bi_any: !BILINEAR [?ANY]
			l_aa_bi_any: !BILINEAR [!ANY]
		do
			create l_aa_list.make (1)
			l_any := l_aa_list
			l_a_any := l_aa_list

			l_dd_al_string := l_aa_list
			l_da_al_string := l_aa_list
			l_ad_al_string := l_aa_list
			l_aa_al_string := l_aa_list

			l_dd_al_any := l_aa_list
			l_da_al_any := l_aa_list
			l_ad_al_any := l_aa_list
			l_aa_al_any := l_aa_list

			l_dd_bi_string := l_aa_list
			l_da_bi_string := l_aa_list
			l_ad_bi_string := l_aa_list
			l_aa_bi_string := l_aa_list

			l_dd_bi_any := l_aa_list
			l_da_bi_any := l_aa_list
			l_ad_bi_any := l_aa_list
			l_aa_bi_any := l_aa_list
		end

end
