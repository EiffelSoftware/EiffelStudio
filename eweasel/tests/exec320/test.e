
class TEST
inherit
	INTERNAL

create
	make
feature
	make
		do
			print (physical_size (x)); io.new_line
			print (deep_physical_size (x)); io.new_line
		end

	x: TEST1
end
