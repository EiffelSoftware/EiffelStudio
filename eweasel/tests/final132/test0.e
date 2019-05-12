class
	TEST

create
	make

feature {NONE} -- Creation

	make
		local
			f: RAW_FILE
		do
			create f.make_with_name ("../general.dat")
			if f.exists then
				f.delete
			end
			f.open_write
			f.general_store (create {CELL [A]}.put (create {A}))
			f.close
			create f.make_with_name ("../independent.dat")
			if f.exists then
				f.delete
			end
			f.open_write
			f.independent_store (create {CELL [A]}.put (create {A}))
			f.close
		end

end
