
class TEST

create
	make

feature

	make
		do
			if attached create {STRING_8}.make_from_string ("FOO") as l_string then
				print (l_string.as_lower)
			end			
		end
	
end

