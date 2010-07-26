
class TEST [G -> ANY create default_create end, H -> ANY create default_create end]
create
	make

feature
	make
		do
			create x
			create y
		end

	x: G
	
	y: H
end
