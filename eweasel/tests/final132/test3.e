class
	TEST

inherit
	SED_STORABLE_FACILITIES

create
	make

feature {NONE} -- Creation

	make
		do
			;(create {CELL [detachable A]}.put (Void)).do_nothing
			test ("../general.dat")
			test ("../independent.dat")
		end

feature {NONE} -- Testing

	test (n: READABLE_STRING_GENERAL)
			-- Report results of retrieval from a file of name `n`.
		local
			f: RAW_FILE
			is_retried: BOOLEAN
		do
			if not is_retried then
				create f.make_open_read (n)
				if not attached f.retrieved as x then
					io.put_string ("Cannot retrieve an object.%N")
				elseif attached {CELL [A]} x as y then
					io.put_string ("Retrieved object successfully: " + y.item.generating_type.name + ".%N")
				else
					io.put_string ("Retrieved incompatible object: " + x.generating_type.name + ".%N")
				end
				f.close
			end
		rescue
			io.put_string_32 ({STRING_32} "Aborted with exception: " + if attached {EXCEPTION_MANAGER}.last_exception as e then e.tag else {IMMUTABLE_STRING_32} "" end + {STRING_32} "%N")
			is_retried := True
			retry
		end

end
