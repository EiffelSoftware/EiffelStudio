
class TEST
inherit
	EXCEPTION_MANAGER

create
	make

feature

	make
		local
			tried: BOOLEAN
		do
			if not tried then
				check
					valid: (agent {STRING}.is_integer).item ([value])
				end
			else
				print (last_exception.original.meaning); io.new_line
			end
		rescue
			if not tried then
				tried := True
				retry
			end
		end

	value: STRING

end
