
class TEST
inherit
	EXCEPTIONS

create
	make

feature

	make is
		local
			tried: BOOLEAN
		do
			create x
			if not tried then
				print (x.y.generating_type); io.new_line
			end
		rescue
			handle_exception
			tried := True
			tried := True
			retry
		end

	handle_exception
		local
			s: detachable STRING
		do
			s := exception_trace
			if s /= Void then 
				if s.substring_index ("make @3", 1) = 0 then
					print (s)
				end
			end
		end

	x: TEST1 [STRING]

end
