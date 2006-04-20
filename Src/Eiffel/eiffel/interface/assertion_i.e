indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	ASSERTION_I

create
	make_no,
	make_require,
	make_ensure,
	make_loop,
	make_check,
	make_invariant,
	make_all

feature {NONE} -- Initialization

	make_no is
			-- Create an assertion level which does not check assertions.
		do
			level := 0
		ensure
			level_is_zero: level = 0
		end

	make_require is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_require
		ensure
			level_set: level = ck_require
		end

	make_ensure is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_ensure
		ensure
			level_set: level = ck_ensure
		end

	make_check is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_check
		ensure
			level_set: level = ck_check
		end

	make_loop is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_loop
		ensure
			level_set: level = ck_loop
		end

	make_invariant is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_invariant
		ensure
			level_set: level = ck_invariant
		end

	make_all is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_require | ck_ensure | ck_check | ck_loop | ck_invariant
		ensure
			level_set: level = (ck_require | ck_ensure | ck_check | ck_loop | ck_invariant)
		end

feature -- Access

	level: INTEGER
			-- Coded assertion being checked.

feature -- Update

	enable_check is
			-- Enable check.
		do
			level := level | ck_check
		end

	enable_loop is
			-- Enable loop.
		do
			level := level | ck_loop
		end

	enable_invariant is
			-- Enable Invariant.
		do
			level := level | ck_invariant
		end

	enable_ensure is
			-- Enable ensure.
		do
			level := level | ck_ensure
		end

	enable_require is
			-- Enable require.
		do
			level := level | ck_require
		end

feature -- Status

	check_precond: BOOLEAN is
			-- Must preconditions be checked ?
		do
			Result := (level & ck_require) = ck_require
		end

	check_postcond: BOOLEAN is
			-- Must postconditions be checked ?
		do
			Result := (level & ck_ensure) = ck_ensure
		end

	check_invariant: BOOLEAN is
			-- must invariant be checked ?
		do
			Result := (level & ck_invariant) = ck_invariant
		end

	check_loop: BOOLEAN is
			-- Must loop assertions be checked ?
		do
			Result := (level & ck_loop) = ck_loop
		end

	check_check: BOOLEAN is
			-- Must check clauses be checked ?
		do
			Result := (level & ck_check) = ck_check
		end

	check_all: BOOLEAN is
			-- Must check all clauses?
		do
			Result := check_precond and check_postcond and check_invariant
				and check_loop and check_check
		end

feature -- Generation

	generate (buffer: GENERATION_BUFFER) is
			-- Generate assertion level in `file'.
		require
			good_argument: buffer /= Void
		do
			buffer.put_string ("(int16) ")
			buffer.put_integer (level)
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code representation of the assertion
		do
			ba.append_short_integer (level)
		end

feature -- Constants

	ck_require: INTEGER is 0x1
	ck_ensure: INTEGER is 0x2
	ck_check: INTEGER is 0x4
	ck_loop: INTEGER is 0x8
	ck_invariant: INTEGER is 0x10;
			-- Value used during C generation to define assertion level.
			-- See values in `eif_option.h'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
