
class TEST3
inherit
	TEST2
		redefine
			weasel
		end
	TEST2
		rename
			weasel as ermine
		redefine
			ermine
		select
			ermine
		end
feature
	weasel: TEST4
		attribute
			create Result
		end
	
	ermine: TEST4
		attribute
			create Result
		end
	
end

