
class TEST
inherit
	EXCEPTIONS
create
        make

feature
	make
		local
			s: STRING
			tried: BOOLEAN
		do
			if not tried then
				s := "Ermine"
				print (s.item (20)); io.new_line
			else
				print (meaning (exception)); io.new_line
			end
		rescue
			tried := True
			retry
		end

end

