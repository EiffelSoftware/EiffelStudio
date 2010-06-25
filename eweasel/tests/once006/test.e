
class TEST

create
	make
feature

	make
		local
			x, y: TEST3
		do
			create s.ermine
			create t.weasel
			create x.ermine
			create y.weasel
		end

	s: TEST3

	t: TEST3

end
