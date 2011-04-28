
class TEST3 [G]

inherit
	TEST4 [G]

create
	make

feature

	make
		local
			u: TEST1
		do
			if not u.success then

			end
		end

	t1: TEST2 [ANY]

end
