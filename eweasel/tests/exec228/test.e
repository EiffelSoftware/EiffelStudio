class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_f: FILE_NAME
			l_a: ANY
			a: ROUTINE [ANY, TUPLE]
		do
			create l_f.make
			create l_a

			a := agent g
			check_expected_result (True, a.valid_operands (Void))
			check_expected_result (True, a.valid_operands ([]))
			check_expected_result (True, a.valid_operands ([1]))
			check_expected_result (True, a.valid_operands (["st"]))
			check_expected_result (True, a.valid_operands ([l_a]))
			check_expected_result (True, a.valid_operands ([l_f]))
			check_expected_result (True, a.valid_operands ([6.4]))

			a := agent f
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands (["st"]))
			check_expected_result (False, a.valid_operands ([l_a]))
			check_expected_result (False, a.valid_operands ([l_f]))
			check_expected_result (False, a.valid_operands ([6.4]))
			check_expected_result (True, a.valid_operands ([1]))
			check_expected_result (True, a.valid_operands ([1, 2]))
			check_expected_result (True, a.valid_operands ([1, 2.4]))
			check_expected_result (True, a.valid_operands ([1, "st"]))

			a := agent h
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands (["st"]))
			check_expected_result (False, a.valid_operands ([l_a]))
			check_expected_result (False, a.valid_operands ([l_f]))
			check_expected_result (False, a.valid_operands ([6.4]))
			check_expected_result (False, a.valid_operands ([1, 1]))
			check_expected_result (False, a.valid_operands ([1, l_a]))
			check_expected_result (False, a.valid_operands ([1, 6.4]))
			check_expected_result (True, a.valid_operands ([1, Void]))
			check_expected_result (True, a.valid_operands ([1, "st"]))
			check_expected_result (True, a.valid_operands ([1, l_f]))

			a := agent i_8
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (True, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent i_16
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (True, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent i_32
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (True, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent i_64
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (True, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent n_8
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (True, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent n_16
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (True, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent n_32
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (True, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent n_64
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (True, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent c_8
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (True, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent c_32
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (True, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent r_32
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (True, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent r_64
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (True, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent bool
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (True, a.valid_operands ([True]))
			check_expected_result (False, a.valid_operands ([default_pointer]))

			a := agent ptr
			check_expected_result (False, a.valid_operands (Void))
			check_expected_result (False, a.valid_operands ([]))
			check_expected_result (False, a.valid_operands ([{INTEGER_8} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_16} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_32} 1]))
			check_expected_result (False, a.valid_operands ([{INTEGER_64} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_8} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_16} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_32} 1]))
			check_expected_result (False, a.valid_operands ([{NATURAL_64} 1]))
			check_expected_result (False, a.valid_operands (['c']))
			check_expected_result (False, a.valid_operands ([('c').to_character_32]))
			check_expected_result (False, a.valid_operands ([{REAL_32} 5.0]))
			check_expected_result (False, a.valid_operands ([{REAL_64} 5.0]))
			check_expected_result (False, a.valid_operands ([True]))
			check_expected_result (True, a.valid_operands ([default_pointer]))
		end

feature -- Actions

	g is do end
	f (i: INTEGER) is do end
	h (i: INTEGER; s: STRING) is do end

	i_8 (i: INTEGER_8) is do end
	i_16 (i: INTEGER_16) is do end
	i_32 (i: INTEGER_32) is do end
	i_64 (i: INTEGER_64) is do end

	n_8 (i: NATURAL_8) is do end
	n_16 (i: NATURAL_16) is do end
	n_32 (i: NATURAL_32) is do end
	n_64 (i: NATURAL_64) is do end

	c_8 (i: CHARACTER_8) is do end
	c_32 (i: CHARACTER_32) is do end

	r_32 (i: REAL_32) is do end
	r_64 (i: REAL_64) is do end

	bool (i: BOOLEAN) is do end
	ptr (i: POINTER) is do end

feature -- Test

	check_expected_result (a_result, b: BOOLEAN) is
			-- Print error when `a_result' is different from `b'.
		do
			if a_result /= b then
				io.put_string ("Not OK%N")
			end
		end

end
