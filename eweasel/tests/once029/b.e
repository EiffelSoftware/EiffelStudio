
class
	B
inherit
	A
create
	make2

feature

	make2
		once
				-- a once creation procedure can be call in a creation procedure.
			make
		end
end
