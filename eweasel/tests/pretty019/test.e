
class TEST
inherit
	ANY
		rename
			out as x,
			twin as y
		export
			{NONE} all
		undefine
			generating_type,generator
		redefine
			x,y
		select
			x,y
		end
	
create
	make

feature 

make
	do
	end

end
