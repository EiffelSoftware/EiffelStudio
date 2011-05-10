class TEST

create
	make
feature

	make
		local
			t: TEST1 [STRING, STRING]
			list: LINKED_LIST [STRING]
		do
			create list.make
			create t.make ("", list)
		end

end
