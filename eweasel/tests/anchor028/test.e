
class TEST

create
       make
feature

	make
		do
			c := "Weasel"
		end

	a: TEST1 [STRING] 

	b: like a.value

	c: like {TEST1 [like b]}.value

end
