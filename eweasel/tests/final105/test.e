class TEST
create
	make

feature {NONE}

	make
		local
			t1: TEST1 [STRING, STRING, STRING]
			i: INTEGER_REF
		do
			create t1
			t1.ad_hoc_record_by_signature ("s").do_nothing
		end

end
