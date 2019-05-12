class
	TEST

inherit
	SED_STORABLE_FACILITIES

create
	make

feature {NONE} -- Creation

	make
		local
			a: A
			b: B
			f: RAW_FILE
		do
			if attached a then
				a.do_nothing
			end
			;(create {B}).do_nothing
			;(create {CELL [detachable A]}.put (Void)).do_nothing
			create f.make_open_read ("../data.dat")
			if not attached retrieved (create {SED_MEDIUM_READER_WRITER}.make_for_reading (f), True) as x then
				io.put_string ("Cannot retrieve an object.%N")
			elseif attached {CELL [A]} x as y then
				io.put_string ("Retrieved object successfully: " + y.item.generating_type.name + ".%N")
			else
				io.put_string ("Retrieved incompatible object: " + x.generating_type.name + ".%N")
			end
			f.close
		end

end
