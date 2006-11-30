class TEST1 [G]

feature

	once_procedure is
		local
			t: LINKED_LIST [G]
		once
			create t.make
			create t.make
		end

end
