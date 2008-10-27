class TEST
create
	make

feature

	test: TUPLE [ b: BOOLEAN; i: ANY ]
 
	make is
		do
			create test
			create last_original
			create last_translated

			test.b := False -- Works
			test.i := ({ANY}).attempt (7) -- Works
			test.i := 7 -- Segmentation violation; Operating system signal
			test.i := True -- Segmentation violation; Operating system signal

			get_original_entries (2)
			get_translated_entries (4)
		end

	last_original: TUPLE [i:INTEGER; list: LIST[STRING_32]]
	last_translated: TUPLE [i:INTEGER; list: LIST[STRING_32]]

	get_original_entries (i_th: INTEGER) is
			-- get `i_th' original entry in the file
		do
			if (last_original.i /= i_th) then
				last_original.i := i_th
				last_original.list := extract_string (1, 3).split('%U')
			end
		ensure
			last_original.list = Void or last_original.list /= Void
		end

	get_translated_entries (i_th: INTEGER) is
			-- What's the `i-th' translated entry?
		do
			if (last_translated.i /= i_th) then
				last_translated.i := i_th
				last_translated.list := extract_string (1, 3).split('%U')
			end
		ensure
			last_translated.list = Void or last_translated.list /= Void
		end

	extract_string (a_offset, a_number: INTEGER): STRING_32 is
		do
			create Result.make (10)
		end

end
