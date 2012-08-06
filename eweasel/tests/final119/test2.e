class TEST2
inherit
	TEST1

create
	make

feature

	set_center
		do
			center.set_x (1)
			is_center_valid := True
		end

end
