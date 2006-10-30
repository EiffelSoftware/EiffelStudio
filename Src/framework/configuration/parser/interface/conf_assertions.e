indexing
	description: "Assertion settings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ASSERTIONS

create {CONF_PARSE_FACTORY}
	default_create

feature -- Access, stored in configuration file

	is_precondition: BOOLEAN is
			-- Check preconditions
		do
			Result := level & ck_require = ck_require
		end

	is_supplier_precondition: BOOLEAN is
			-- Check supplier preconditions
		do
			Result := level & ck_sup_require = ck_sup_require
		end

	is_postcondition: BOOLEAN is
			-- Check postconditions
		do
			Result := level & ck_ensure = ck_ensure
		end

	is_check: BOOLEAN is
			-- Check assertions
		do
			Result := level & ck_check = ck_check
		end

	is_invariant: BOOLEAN is
			-- Check invariants
		do
			Result := level & ck_invariant = ck_invariant
		end

	is_loop: BOOLEAN is
			-- Check loop assertions
		do
			Result := level & ck_loop = ck_loop
		end

	has_assertions: BOOLEAN is
			-- Are any assertions enabled?
		do
			Result := level /= 0
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	enable_precondition is
			-- Enable precondition.
		do
			level := level | ck_require
		ensure
			is_precondition: is_precondition
			is_supplier_precondition_unchanged: is_supplier_precondition = old is_supplier_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	enable_supplier_precondition is
			-- Enable supplier precondition.
		do
			level := level | ck_sup_require
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_supplier_precondition: is_supplier_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	enable_postcondition is
			-- Enable postcondition.
		do
			level := level | ck_ensure
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_supplier_precondition_unchanged: is_supplier_precondition = old is_supplier_precondition
			is_postcondition: is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	enable_check is
			-- Enable check.
		do
			level := level | ck_check
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_supplier_precondition_unchanged: is_supplier_precondition = old is_supplier_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check: is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	enable_invariant is
			-- Enable invariant.
		do
			level := level | ck_invariant
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_supplier_precondition_unchanged: is_supplier_precondition = old is_supplier_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant: is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	enable_loop is
			-- Enable loop.
		do
			level := level | ck_loop
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_supplier_precondition_unchanged: is_supplier_precondition = old is_supplier_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop: is_loop
		end

	disable_precondition is
			-- Enable precondition.
		do
			level := level & ck_require.bit_not
		ensure
			not_is_precondition: not is_precondition
			is_supplier_precondition_unchanged: is_supplier_precondition = old is_supplier_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	disable_supplier_precondition is
			-- Disable supplier precondition.
		do
			level := level & ck_sup_require.bit_not
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			not_is_supplier_precondition: not is_supplier_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	disable_postcondition is
			-- Disable postcondition.
		do
			level := level & ck_ensure.bit_not
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_supplier_precondition_unchanged: is_supplier_precondition = old is_supplier_precondition
			not_is_postcondition: not is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	disable_check is
			-- Disable check.
		do
			level := level & ck_check.bit_not
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_supplier_precondition_unchanged: is_supplier_precondition = old is_supplier_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			not_is_check: not is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	disable_invariant is
			-- Disable invariant.
		do
			level := level & ck_invariant.bit_not
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_supplier_precondition_unchanged: is_supplier_precondition = old is_supplier_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			not_is_invariant: not is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	disable_loop is
			-- Disable loop.
		do
			level := level & ck_loop.bit_not
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_supplier_precondition_unchanged: is_supplier_precondition = old is_supplier_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			not_is_loop: not is_loop
		end

feature -- Constants

	ck_require: INTEGER is 0x01
	ck_ensure: INTEGER is 0x02
	ck_check: INTEGER is 0x04
	ck_loop: INTEGER is 0x08
	ck_invariant: INTEGER is 0x10
	ck_sup_require: INTEGER is 0x20
			-- Value used during C generation to define assertion level.
			-- See values in `eif_option.h'.

feature -- Implementation, attributes stored in configuration file

	level: INTEGER;
			-- The assertion values, encoded into an integer.

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
