indexing

	description: "Access to command-line arguments. This class %
		%may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ARGUMENTS

feature -- Access

	argument (i: INTEGER): STRING is
			-- `i'-th argument of command that started system execution
			-- (the command name if `i' = 0)
		require
			index_large_enough: i >= 0;
			index_small_enough: i <= argument_count
		do
			Result := arg_option (i)
		end;

	argument_array: ARRAY [STRING] is
			-- Array containing command name (position 0) and arguments
		local
			i : INTEGER
		once
			!!Result.make (0,argument_count)
			from
			until
				i > argument_count
			loop
				Result.put (arg_option (i), i)
				i := i + 1
			end
		end

	command_line: STRING is
			-- Total command line
		local
			i : INTEGER
		once
			!!Result.make (command_name.count)
			from
			until
				i > argument_count
			loop
				Result.append (" ")
				Result.append (arg_option (i))
				i := i + 1
			end
		ensure
			Result.count >= command_name.count
		end

	command_name: STRING is
			-- Name of command that started system execution
		once
			Result := arg_option (0)
		ensure
			definition: Result.is_equal (argument (0))
		end;

feature -- Status report

	has_word_option (opt: STRING): INTEGER is
			-- If one of the arguments in list of space-separated arguments
			-- is `Xopt', where `X' is `option_sign', then index of this
			-- argument in list; else 0.a
		require
			opt_non_void: opt /= Void
			opt_meaningful: not opt.empty
		local
			i : INTEGER
		do
			from
				i := 1
			until
				i > argument_count or else
				option_word_equal (argument_array.item (i), opt)
			loop
				i := i + 1
			end
			if i <= argument_count then Result := i end
		end

	has_character_option (opt: CHARACTER): INTEGER is
			-- Does command line specify option `opt' and, if so,
			-- at what position?
			-- If one of the space-separated arguments is of the form `Xxxoyy',
			-- where `o' is `opt', `X' is `option_sign', and `xx' and `yy' are
			-- arbitrary, possibly empty sequences of characters, then
			-- index of this argument in list of arguments;
			-- else 0.
		require
			opt_non_null: opt /= '%U'
		local
			i : INTEGER
 		do
			from
				i := 1
			until
				i > argument_count or else
				option_character_equal (argument_array.item (i), opt)
			loop
				i := i + 1
			end
			if i <= argument_count then Result := i end
		end

	separate_character_option_value (opt: CHARACTER): STRING is
			-- The value, if any, specified after option `opt' on the command line.
			-- This is one of the following (where `o' is `opt', `X' is the
			-- current `option_sign', and `xx' is an arbitrary, possibly
			-- empty sequence of characters):
			--   `val' if command line includes two consecutive arguments
			--	   of the form `Xxxo' and `val' respectively.
			--   Empty string if command line includes argument `Xo', which is
			--	   either last argument or followed by argument starting with `X'.
			--   Void if no `Xo' argument.
		local
			p : INTEGER
		do
			p := has_character_option (opt)
			if p /= 0 then
				if p = argument_count or else
					argument_array.item (p+1).item (1) = option_sign
				then
					Result := ""
				else
					Result := argument_array.item (p+1)
				end
			end
		end

	separate_word_option_value (opt: STRING): STRING is
			-- The value, if any, specified after option `opt' on the command line.
			-- This is one of the following (where `o' is `opt', `X' is the
			-- current `option_sign'):
			--   `val' if command line includes two consecutive arguments
			--	   of the form `Xo' and `val' respectively.
			--   Empty string if command line includes argument `Xo', which is
			--	   either last argument or followed by argument starting with `X'.
			--   Void if no `Xo' argument.
		local
			p : INTEGER
		do
			p := has_word_option (opt)
			if p /= 0 then
				if p = argument_count or else
					argument_array.item (p+1).item (1) = option_sign
				then
					Result := ""
				else
					Result := argument_array.item (p+1)
				end
			end
		end

	coalesced_option_character_value (opt: CHARACTER): STRING is
			-- The value, if any, specified for option `opt' on the command line.
			-- Defined as follows (where `o' is `opt' and X is `option_sign'):
			--   `val' if command line includes an argument of the form `Xoval'
			--		(this may be an empty string if argument is just `Xo').
			--   Void otherwise.
		local
			p : INTEGER
			l : STRING
		do
			p := has_character_option (opt)
			if p /= 0 then
				l := argument_array.item (p)
				Result := l.substring (l.index_of (opt, 2), l.count)
				Result.remove (1)
			end
		end

	coalesced_option_word_value (opt: STRING): STRING is
			-- The value, if any, specified for option `opt' on the command line.
			-- Defined as follows (where `o' is `opt' and X is `option_sign'):
			--   `val' if command line includes an argument of the form `Xoval'
			--		(this may be an empty string if argument is just `Xo').
			--   Void otherwise.
		local
			p : INTEGER
			l : STRING
		do
			p := has_word_option (opt)
			if p /= 0 then
				l := argument_array.item (p)
				Result := l.substring (l.substring_index (opt, 2), l.count)
				Result.remove (1)
			end
		end

	option_sign: CHARACTER is
			-- The character used to signal options on the command line.
			-- Default: the `-' sign.
		do
			Result := internal_option_sign;
			if Result = '%U' then
				Result := '-'
			end
		end;

feature -- Status setting

	set_option_sign (c: CHARACTER) is
			-- Make `c' the option sign.
		require
			c /= '%U'
			-- %U is the null character
		do
			internal_option_sign := c
		ensure
			option_sign = c
		end

feature -- Measurement

	argument_count: INTEGER is
			-- Number of arguments given to command that started
			-- system execution (command name does not count)
		once
			Result := arg_number - 1
		ensure
			Result >= 0
		end;

feature {NONE} -- Implementation

	arg_number: INTEGER is
		external
			"C | <argv.h>"
		end;

	arg_option (i: INTEGER): STRING is
		external
			"C | <argv.h>"
		end;

	internal_option_sign: CHARACTER
			-- The character used to signal options, if explicitly specified.

	option_word_equal (arg, w : STRING): BOOLEAN is
			-- Is `arg' equal to the word option `w'?
		do
			if internal_option_sign = '%U' then
				Result := arg.is_equal (w)
			elseif arg.item (1) = option_sign then
				Result := arg.substring (2,arg.count).is_equal (w)
			end
		end

	option_character_equal (arg: STRING; c : CHARACTER): BOOLEAN is
			-- Does `arg' contain the character option `c'?
		do
			if internal_option_sign = '%U' then
				Result := arg.has (c)
			elseif arg.item(1) = option_sign then
				Result := arg.substring (2,arg.count).has (c)
			end
		end

end -- class ARGUMENTS


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
