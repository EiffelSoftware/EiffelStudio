class FORMATTING

inherit
	STD_FILES

create
	make

feature -- Initialization

	make is
		do
			get_number
			format_integer_demo
			get_number
			format_double_demo
		end

	format_integer_demo is
		local
			i : INTEGER
			fi : FORMAT_INTEGER
		do
			i := random.i_th (item)
			io.putstring ("Unformatted             : ")
			io.putint (i)
			io.new_line
			create fi.make (10)
			io.putstring ("Default                 : ")
			io.putstring (fi.formatted (i))
			io.new_line
			fi.set_width (15)
			io.putstring ("Set width               : ")
			io.putstring (fi.formatted (i))
			io.new_line
			fi.left_justify
			io.putstring ("Left justified          : ")
			io.putstring (fi.formatted (i))
			io.new_line
			fi.center_justify
			io.putstring ("Centered                : ")
			io.putstring (fi.formatted (i))
			io.new_line
			fi.right_justify
			io.putstring ("Right justification     : ")
			io.putstring (fi.formatted (i))
			io.new_line
			fi.asterisk_fill
			io.putstring ("Asterisk fill           : ")
			io.putstring (fi.formatted (i))
			io.new_line
			fi.blank_fill
			fi.comma_separate
			io.putstring (", Separator             : ")
			io.putstring (fi.formatted (i))
			io.new_line
			fi.underscore_separate
			io.putstring ("_ Separator             : ")
			io.putstring (fi.formatted (i))
			io.new_line
			fi.sign_negative_only
			io.putstring ("Negative only           : ")
			io.putstring (fi.formatted (i))
			io.putstring ("     ")
			io.putstring (fi.formatted (-i))
			io.new_line
			fi.sign_positive_only
			io.putstring ("Positive only           : ")
			io.putstring (fi.formatted (i))
			io.putstring ("     ")
			io.putstring (fi.formatted (-i))
			io.new_line
			fi.sign_show
			io.putstring ("Both                    : ")
			io.putstring (fi.formatted (i))
			io.putstring ("     ")
			io.putstring (fi.formatted (-i))
			io.new_line
			fi.sign_leading
			io.putstring ("Leading sign            : ")
			io.putstring (fi.formatted (i))
			io.putstring ("     ")
			io.putstring (fi.formatted (-i))
			io.new_line
			fi.sign_trailing
			io.putstring ("Trailing sign           : ")
			io.putstring (fi.formatted (i))
			io.putstring ("     ")
			io.putstring (fi.formatted (-i))
			io.new_line
			fi.sign_cr_dr
			io.putstring ("Sign as CR/DR           : ")
			io.putstring (fi.formatted (i))
			io.putstring ("     ")
			io.putstring (fi.formatted (-i))
			io.new_line
			fi.sign_dr_cr
			io.putstring ("Sign as DR/CR           : ")
			io.putstring (fi.formatted (i))
			io.putstring ("     ")
			io.putstring (fi.formatted (-i))
			io.new_line
			fi.sign_floating_dollar
			io.putstring ("Sign floating $ no sign : ")
			io.putstring (fi.formatted (i))
			io.putstring ("     ")
			io.putstring (fi.formatted (-i))
			io.new_line
			fi.sign_floating_dollar_signed
			io.putstring ("Sign floating $ signed  : ")
			io.putstring (fi.formatted (i))
			io.putstring ("     ")
			io.putstring (fi.formatted (-i))
			io.new_line
			fi.set_sign ("Plus      Minus")
			io.putstring ("Sign user set           : ")
			io.putstring (fi.formatted (i))
			io.putstring ("     ")
			io.putstring (fi.formatted (-i))
			io.new_line
			fi.sign_ignore
			fi.bracket_negative
			io.putstring ("Bracket neg             : ")
			io.putstring (fi.formatted (i))
			io.putstring ("     ")
			io.putstring (fi.formatted (-i))
			io.new_line
		end

	format_double_demo is
		local
			d : DOUBLE
			fd : FORMAT_DOUBLE
		do
			d := random.double_i_th (item) 
			io.putstring ("Unformatted                : ")
			io.putdouble (d)
			io.new_line
			create fd.make (13,4)
			io.putstring ("Default                    : ")
			io.putstring (fd.formatted (d))
			io.new_line
			fd.set_decimals (6)
			io.putstring ("Set decimals               : ")
			io.putstring (fd.formatted (d))
			io.new_line
			io.putstring ("Hide zero                  : ")
			fd.hide_zero
			io.putstring (fd.formatted (d))
			io.new_line
			io.putstring ("Show zero                  : ")
			fd.show_zero
			io.putstring (fd.formatted (d))
			io.new_line
			fd.comma_separate
			io.putstring (", Separator                : ")
			io.putstring (fd.formatted (d))
			io.new_line
			fd.underscore_separate
			io.putstring ("_ Separator                : ")
			io.putstring (fd.formatted (d))
			io.new_line
			fd.comma_decimal
			io.putstring (", decimal                  : ")
			io.putstring (fd.formatted (d))
			io.new_line
			fd.point_decimal
			io.putstring (". decimal                  : ")
			io.putstring (fd.formatted (d))
			io.new_line
			d := d + 1000
			fd.no_separate_after_decimal
			io.putstring ("No separator after decimal : ")
			io.putstring (fd.formatted (d))
			io.new_line
			fd.separate_after_decimal
			io.putstring ("Separation after decimal   : ")
			io.putstring (fd.formatted (d))
			io.new_line
			fd.remove_separator
			io.putstring ("No separator               : ")
			io.putstring (fd.formatted (d))
			io.new_line
		end

feature -- Input

	get_number is
		do
			io.putstring ("Enter a number between 1 and 100: ")
			
			from
				io.read_integer
			until
				1 <= io.lastint and io.lastint <= 100
			loop
				io.putstring ("That number is not between 1 and 100%N")
				io.read_integer
			end
			item := io.lastint
		end

feature -- Implementation

	random : RANDOM is
		once
			create Result.make
		end

	item: INTEGER

end -- FORMATTING

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://www.eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

