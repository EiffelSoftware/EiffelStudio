
class TEST3
inherit
	TEST1
		redefine
			ermine
		end
	TEST2

create
	weasel, ermine

feature
	ermine
		do
			precursor
		end


end
