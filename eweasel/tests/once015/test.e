
class TEST
inherit
	ANY
	EXCEPTION_MANAGER
		export
			{NONE} all
		end
create
	make
feature
	make
		local
			tried: BOOLEAN
		do
			if not tried then
				try
			else
				print (last_exception.meaning); io.new_line
			end
		rescue
			tried := True
			retry
		end

	try
		local
			a: TEST2
		once ("OBJECT")
			create a
			a.try
		end

end
