
class TEST1 [H -> {TEST3, TEST4 rename default_create as hamster, min_value as weasel end} create default_create end]
create
	make
feature
	make
		do
			create x.default_create
			print ({H}.min_value); io.new_line
		end

	x: H
end
