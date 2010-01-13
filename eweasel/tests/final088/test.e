
class TEST
inherit
	EXCEPTION_MANAGER
create
	make

feature {NONE}

	make
		local
			tried: BOOLEAN
		do
			if not tried then
				print (a.out)
			else
				print (last_exception.generating_type); io.new_line
				print (last_exception.code); io.new_line
				print (last_exception.meaning); io.new_line
			end
		rescue
			tried := True
			retry
		end

	a: TEST2
end
