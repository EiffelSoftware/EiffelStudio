indexing
	description	: "System's root class"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
				--| Add your code here
			a4 := (0x1234).to_character_32
			display
			a1 := 123
			display
			a2 := "str"
			display
			a3 := 'a'
			display
			a5 := Current
			display
		end

	last_display: STRING

	display is
		local
			s: STRING
		do
			s := a4.out
			print (s + "%N")
			if
				last_display /= Void
				and then not last_display.is_equal (s)
			then
				print ("Error ... output of wide_character differs %N")
				print (" before: " + last_display + "%N")
				print (" now   : " + s + "%N")
			end
			last_display := s.twin
		end

	a1: INTEGER
	a2: STRING
	a3: CHARACTER
	a4: WIDE_CHARACTER
	a5: like Current

end -- class TEST
