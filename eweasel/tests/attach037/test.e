
class TEST

create
	make

feature

	make
		do
			if True then
				s := "Weasel"
			else
				s := "Stoat"
			end
		end

	s: STRING

end
