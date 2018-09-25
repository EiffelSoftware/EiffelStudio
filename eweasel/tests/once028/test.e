
class TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			a: A
		do
			create a.make2
			a.make
		end


end
