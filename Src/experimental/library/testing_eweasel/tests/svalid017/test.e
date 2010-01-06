

class TEST
inherit
	TEST1
		redefine
			weasel
		end

create
	make

feature

	make
		do
			Current.try
		end

	try
		do
		end

	weasel: CHILD


end
