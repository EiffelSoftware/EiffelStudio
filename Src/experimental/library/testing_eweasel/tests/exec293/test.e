
class TEST
inherit
	EXCEPTIONS

create
	make

feature

	make is
		local
			x: TUPLE [a: INTEGER]
			tried: INTEGER
		do
			inspect tried
			when 0 then
				if x.a = 1 then
				end
			when 1 then
				x.a := 1;
			else
			end
		rescue
			print (meaning (original_exception)); io.new_line
			tried := tried + 1
			retry
		end

end
