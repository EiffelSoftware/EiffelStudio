indexing

	description:

		"Character buffers"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001-2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_CHARACTER_BUFFER

inherit

	KI_CHARACTER_BUFFER
		redefine






			fill_from_string, fill_from_stream,
			move_left, move_right
		end









	KL_IMPORTED_ANY_ROUTINES

create

	make, make_from_string

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Create a new character buffer being able
			-- to contain `n' characters.
		do











			create area.make_filled ('%U', n)







		end

feature -- Access

	item (i: INTEGER): CHARACTER is
			-- Item at position `i'
		do







			Result := area.item (i)

		end

	substring (s, e: INTEGER): STRING is
			-- New string made up of characters held in
			-- buffer between indexes `s' and `e'

		local
			i, nb: INTEGER

			j: INTEGER


		do
			if e < s then
					-- Empty string

				create Result.make_empty



			else
















				nb := e - s + 1
				create Result.make_filled ('%U', nb)
				from i := s until i > e loop
					j := j + 1
					Result.put (area.item (i), j)
					i := i + 1
				end

			end
		end

feature -- Measurement





	count: INTEGER is
			-- Number of characters in buffer
		do







			Result := area.count

		end












feature -- Element change

	put (v: CHARACTER; i: INTEGER) is
			-- Replace character at position `i' by `v'.
		do







			area.put (v, i)

		end




























































	fill_from_string (a_string: STRING; pos: INTEGER) is
			-- Copy characters of `a_string' to buffer
			-- starting at position `pos'.
		local
			nb: INTEGER

			i, j: INTEGER

		do
			nb := a_string.count
			if nb > 0 then







				j := pos
				from i := 1 until i > nb loop
					area.put (a_string.item (i), j)
					j := j + 1
					i := i + 1
				end

			end
		end

	fill_from_stream (a_stream: KI_CHARACTER_INPUT_STREAM; pos, nb: INTEGER): INTEGER is
			-- Fill buffer, starting at position `pos', with
			-- at most `nb' characters read from `a_stream'.
			-- Return the number of characters actually read.
		do










			Result := a_stream.read_to_string (area, pos, nb)


		end

	move_left (old_pos, new_pos: INTEGER; nb: INTEGER) is
			-- Copy `nb' characters from `old_pos' to
			-- `new_pos' in buffer.

		local
			i, j, nb2: INTEGER

		do
			if nb > 0 then







				j := new_pos
				nb2 := old_pos + nb - 1
				from i := old_pos until i > nb2 loop
					area.put (area.item (i), j)
					j := j + 1
					i := i + 1
				end

			end
		end

	move_right (old_pos, new_pos: INTEGER; nb: INTEGER) is
			-- Copy `nb' characters from `old_pos' to
			-- `new_pos' in buffer.

		local
			i, j: INTEGER

		do
			if nb > 0 then







				j := new_pos + nb - 1
				from i := old_pos + nb - 1 until i < old_pos loop
					area.put (area.item (i), j)
					j := j - 1
					i := i - 1
				end

			end
		end

feature -- Resizing

	resize (n: INTEGER) is
			-- Resize buffer so that it contains `n' characters.
			-- Do not lose any previously entered characters.

		do
			area.resize (n)



















		end

feature {NONE} -- Implementation










	area: STRING
			-- Implementation



invariant


	area_not_void: area /= Void






end
