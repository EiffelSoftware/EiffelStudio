
class TEST
inherit
	ANY
		redefine
			default_create
		end

create
        make, default_create
feature
	make
                do
			create x.make (Current)
			x.try
		end

	default_create
                do
			print ("In TEST default_create%N")
		end

	hamster alias "#weasel#" (n: INTEGER): INTEGER
		once
			Result := 13 * n
		end

	x: TEST1 [TEST, TESt, TEST2 [TESt, TEST]]
end
