class CC1

feature

	b: BB1
		do
			check False then end
		end

	x: XX [like b.z]
		do
			create Result.make
		end
		
end