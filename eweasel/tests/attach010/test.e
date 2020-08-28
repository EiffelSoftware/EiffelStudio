class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Perform test
		local
			l_aa_list: attached ARRAYED_LIST [attached STRING]

			l_any: detachable ANY
			l_a_any: attached ANY

			l_dd_al_string: detachable ARRAYED_LIST [detachable STRING]
			l_da_al_string: detachable ARRAYED_LIST [attached STRING]
			l_ad_al_string: attached ARRAYED_LIST [detachable STRING]
			l_aa_al_string: attached ARRAYED_LIST [attached STRING]

			l_dd_al_any: detachable ARRAYED_LIST [detachable ANY]
			l_da_al_any: detachable ARRAYED_LIST [attached ANY]
			l_ad_al_any: attached ARRAYED_LIST [detachable ANY]
			l_aa_al_any: attached ARRAYED_LIST [attached ANY]

			l_dd_bi_string: detachable BILINEAR [detachable STRING]
			l_da_bi_string: detachable BILINEAR [attached STRING]
			l_ad_bi_string: attached BILINEAR [detachable STRING]
			l_aa_bi_string: attached BILINEAR [attached STRING]

			l_dd_bi_any: detachable BILINEAR [detachable ANY]
			l_da_bi_any: detachable BILINEAR [attached ANY]
			l_ad_bi_any: attached BILINEAR [detachable ANY]
			l_aa_bi_any: attached BILINEAR [attached ANY]
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
