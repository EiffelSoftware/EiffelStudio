
class TEST
create
	make

feature {NONE}

	make is
		do
			x := ({NONE}).attempt ("Weasel")
			if x /= Void then
				print ("Value is not Void%N")
				print (x); io.new_line
			else
				print ("Value is Void%N")
			end
		end

	x: NONE
end
