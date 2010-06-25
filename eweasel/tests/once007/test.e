
class TEST

create
	make
feature

	make
		local
			x, y: TEST3
		do
			create x
			x.ermine
			x.ermine
			x.weasel
			x.weasel
			create y
			y.ermine
			y.ermine
			y.weasel
			y.weasel
			create s
			s.ermine
			s.ermine
			s.weasel
			s.weasel
			create t
			t.ermine
			t.ermine
			t.weasel
			t.weasel
		end

	s: TEST3

	t: TEST3
end
