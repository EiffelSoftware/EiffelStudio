indexing
	description: "Can read and convert X-bitmap to Windows bitmap"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	X_BITMAP_WINDOWS

inherit
	WEL_DIB
		redefine
			width, height
		end

	BASIC_ROUTINES

creation
	read_from_xbm_file

feature -- Initialization

	read_from_xbm_file (a_filename: STRING) is
			-- Read the X bitmap from the file
		require
			a_filename_exists: a_filename /= Void
			a_filename_sensible: a_filename.count > 0
		local
			file: PLAIN_TEXT_FILE
			line: STRING
			retried: BOOLEAN
			int_width: INTEGER
		do
			if not retried then
				!! file.make (a_filename)
				is_valid := false
				if file.exists then
					is_valid := true
					file.open_read
					file.readline
					line := file.laststring
					if is_value_line (line) then
						width := process_value_line (line)
						file.readline
						line := file.laststring
						if is_value_line (line) then
							height := process_value_line (line)
							file.readline
							line := file.laststring
							if is_value_line (line) then
								hot_x := process_value_line (line)
								file.readline
								line := file.laststring
								if is_value_line (line) then
									hot_y := process_value_line (line)
									file.readline
								end
							end
						else
							hot_x := 0
							hot_y := 0
						end
					end
					-- Got the width, height, hot_x and hot_y
					-- skipped over line with opening {
					-- now get the data
					if is_valid then
						from
							int_width := width // 8
							if width \\ 8 /= 0 then
								int_width := int_width + 1
							end
							!! temporary_storage.make (height, int_width)
						until
							not is_valid or file.end_of_file
						loop
							file.readline
							line := file.laststring
							process_data_line (line, int_width)
						end
						if is_valid then
							make_dib_from_array 							
						end
					end
					file.close
				end
			else
				io.error.putstring ("Unable to read XBM from file ")
				io.error.putstring (a_filename)
				io.error.new_line
			end
		rescue
			retried := true
			retry
		end

feature {SCREEN_CURSOR_IMP} -- Access

	array: ARRAY2 [CHARACTER] is
		do
			Result := temporary_storage
		end

feature -- Access

	depth: INTEGER
			-- Number of colors

	height: INTEGER
			-- Numbers of pixels down

	hot_x: INTEGER
			-- X position of hot spot if this is a cursor

	hot_y: INTEGER
			-- Y position of hot spot if this is a cursor

	is_valid: BOOLEAN
			-- Is this a valid X bitmap?

	width: INTEGER
			-- Number of pixels across

feature -- Implementation

	hex_characters: STRING is "084c2a6e195d3b7f"	
			-- Valid hexadecimal characters
			-- in inverted order

	is_value_line (l: STRING): BOOLEAN is
			-- Is the line `l' a value line?
			-- ie is approximatley "#define xyz abc"
			-- and last line was ok
		do
			Result := l.substring (1,7).is_equal ("#define") and
				l.occurrences (' ') >= 2 and is_valid
		end

	make_dib_from_array is
			-- Make the actual DIB based on information we have at hand
		require
			width_valid: width > 0
			height_valid: height > 0
			storage_exists: temporary_storage /= Void
			is_valid: is_valid
		local
			i,j, p, row_filler: INTEGER
			a: ANY
			black, white: CHARACTER
			s: STRING
		do
			!! info_header.make
			info_header.set_width (width)	 
			info_header.set_height (height)
			info_header.set_planes (1)
			info_header.set_bit_count (1)
			info_header.set_clr_used (2)
			info_header.set_clr_important (2)
			row_filler := temporary_storage.width \\ 4 
			if row_filler /= 0 then 
				row_filler := 4 - row_filler
			end
			structure_size := info_header.structure_size + 8 + 
				(row_filler + temporary_storage.width) * temporary_storage.height
			structure_make
			i := info_header.structure_size
			!! s.make (structure_size);
			s.fill_blank
			black := charconv (0)
			white := charconv (255)
				-- White
			s.put (white,i+1)  
			s.put (white,i+2)  
			s.put (white,i+3)  
			s.put (black,i+4)  
				-- Black
			s.put (black,i+5)  
			s.put (black,i+6)  
			s.put (black,i+7)  
			s.put (black,i+8)  
				-- Data
			from
				p := i+9
				i := height
			until
				i < 1
			loop
				from 
					j := 1
				until
					j > temporary_storage.width
				loop
					s.put (temporary_storage.item (i,j), p)
					p := p + 1
					j := j + 1	
				end
				from
					j := 1
				until
					j > row_filler
				loop
					s.put ('%U', p)
					p := p + 1
					j := j + 1
				end
				i := i - 1
			end
			a := s.area
			memory_copy ($a, structure_size)
			memory_copy (info_header.item, info_header.structure_size)
			calculate_palette
			depth := 2
		end

	process_data_item (s: STRING): CHARACTER is
			-- Convert a hexadecimal string to a number
			-- representative of the same colors for 
			-- Windows as X
		local
			h1, h2: INTEGER
		do
			h1 := hex_characters.index_of (s.item (3).lower,1)
			h2 := hex_characters.index_of (s.item (4).lower,1)
			is_valid := s.item (1) = '0' and s.item (2).lower = 'x' and
				h1 /= 0 and h2 /= 0
			if is_valid then
				Result := charconv(h1 - 1 + 16 * (h2 - 1))
			end
		end

	process_data_line (line: STRING; columns: INTEGER) is
			-- Process lines of hexadecimal numbers for the DIB
		local
			i: INTEGER
			n: CHARACTER
		do
			line.left_adjust
			line.right_adjust
			from
				i := 1
			until
				not is_valid or i > line.count or last_row > height
			loop
				if i + 3 <= line.count then
					n := process_data_item (line.substring (i,i+3))
				else
					is_valid := false
				end
				if is_valid then
					temporary_storage.put (n, last_row+1, last_column+1)
					last_column := last_column + 1
					if last_column = columns then
						last_column := 0
						last_row := last_row + 1
					end
					i := i + 4
					from
					until
						i > line.count or line.item (i) = '0'
					loop
						i := i + 1
					end
				end
			end
		end

	process_value_line (line: STRING): INTEGER is
			-- Process `line' that reads
			-- "#define xyz.width 22"
			-- and return 22.
		require
			is_value_line: is_value_line (line)
		local
			place: INTEGER
			num_string: STRING
		do
			place := line.index_of (' ', 1)
			place := line.index_of (' ', place+1)
			num_string := line.substring (place+1, line.count)
			num_string.left_adjust
			num_string.right_adjust
			if num_string.is_integer then
				Result := num_string.to_integer
			else
				is_valid := false
			end
		end

	last_column: INTEGER
			-- last column a value was placed in

	last_row: INTEGER
			-- last row a value was placed in

	temporary_storage: ARRAY2 [CHARACTER]
			-- storage for X data being converted

end  -- class X_BITMAP_WINDOWS


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

