class
	TEST

inherit
	SED_STORABLE_FACILITIES

create
	make

feature {NONE} -- Creation

	make
		local
			f: RAW_FILE
		do
			create f.make_with_name ("../data.dat")
			if f.exists then
				f.delete
			end
			f.open_write
			store (create {CELL [A]}.put (create {A}), create {SED_MEDIUM_READER_WRITER}.make_for_writing (f))
			f.close
		end

end
