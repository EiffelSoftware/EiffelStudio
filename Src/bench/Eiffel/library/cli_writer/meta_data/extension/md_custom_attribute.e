indexing
	description: "Representation of a custom attribute blob as specified in Partition II 22.3."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_CUSTOM_ATTRIBUTE

inherit
	MD_SIGNATURE
		rename
			set_type as add_local_type
		redefine
			make
		end
	
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize current.
		do
			Precursor {MD_SIGNATURE}
			item.put_integer_16 (feature {MD_SIGNATURE_CONSTANTS}.Ca_prolog, 0)
			current_position := 2
		ensure then
			current_position_set: current_position = 2
		end

feature -- Settings

	put_boolean (v: BOOLEAN) is
			-- Insert `v' at `current_position'.
		do
			if v then
				put_integer_8 (1)
			else
				put_integer_8 (0)
			end
		end

	put_character (c: CHARACTER) is
			-- Insert `c' at `current_position'.
		do
			put_integer_16 (c.code.to_integer_16)
		end

	put_real (r: REAL) is
			-- Insert `r' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 4)
			item.put_real (r, l_pos)
			current_position := l_pos + 4
		end

	put_double (d: DOUBLE) is
			-- Insert `d' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 8)
			item.put_double (d, l_pos)
			current_position := l_pos + 8
		end
		
	put_integer_8 (i: INTEGER_8) is
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 1)
			item.put_integer_8 (i, l_pos)
			current_position := l_pos + 1
		end

	put_integer_16 (i: INTEGER_16) is
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 2)
			item.put_integer_16 (i, l_pos)
			current_position := l_pos + 2
		end
		
	put_integer_32 (i: INTEGER) is
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 4)
			item.put_integer_32 (i, l_pos)
			current_position := l_pos + 4
		end
	
	put_integer_64 (i: INTEGER_64) is
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 8)
			item.put_integer_64 (i, l_pos)
			current_position := l_pos + 8
		end

	put_string (s: STRING) is
			-- Insert `s' at `current_position' using PackedLen encoding and
			-- UTF-8.
		local
			l_count: INTEGER
			i: INTEGER
		do
			if s = Void then
				put_integer_8 (0xFF)
			else
					-- Store count.
				l_count := s.count
				compress_data (l_count)
				
				from
					i := 1
				until
					i > l_count
				loop
					put_integer_8 (s.item_code (i).to_integer_8)
					i := i + 1
				end
			end
		end
		
end -- class MD_CUSTOM_ATTRIBUTE
