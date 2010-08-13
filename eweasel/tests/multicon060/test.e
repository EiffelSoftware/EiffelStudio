class TEST

create
	make
feature

	make
		local
			t: TEST1 [TEST2 [TEST2 [STRING]]]
		do
			create t
			t.do_something
			if attached t.item as l_item then
				t.item.do_something
			end
		end

end
