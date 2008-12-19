
class TEST

create
	make

feature

	make is
		do
			print (z.out)
		end

	z: !STRING
		local
			n: INTEGER
		do
			inspect "Stoat" 
			when 1 then
				Result := "stoat"
			else
				Result := "weasel"
			end
		end

end
