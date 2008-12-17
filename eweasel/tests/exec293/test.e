
class TEST
inherit
	EXCEPTIONS

create
	make

feature
        make is
		local
			x: TUPLE [a: INTEGER]
			tried: BOOLEAN
		do
			if not tried then
				print (x.a); io.new_line
			end
		rescue
			print (meaning (original_exception)); io.new_line
			tried := True
			retry
                end

end
