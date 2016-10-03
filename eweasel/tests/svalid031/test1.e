
class TEST1
inherit
	TEST
		rename
			value as value
		end

create
	make

feature
	weasel alias "+" (n: like Current): detachable like Current
		do
			print ("In weasel%N")
		end

end
