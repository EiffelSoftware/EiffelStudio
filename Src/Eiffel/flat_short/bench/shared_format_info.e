indexing
	description: "Information shared for formatting."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class SHARED_FORMAT_INFO

feature -- Properties

	is_short: BOOLEAN is
			-- Is Current doing a flat-short? (False implies flat)
		do
			Result := is_short_bool.item
		end

	in_bench_mode: BOOLEAN is
			-- Are all instruction calls clickable?
		do
			Result := in_bench_mode_bool.item
		end

	in_assertion: BOOLEAN is
			-- Are we in an assertion?
		do
			Result := in_assertion_bool.item
		end

	order_same_as_text: BOOLEAN is
			-- Keep the same order as in text?
		do
			Result := order_same_as_text_bool.item
		end

	is_with_breakable: BOOLEAN is
			-- Do we show breakable position in class format?
		do
			Result := is_with_breakable_bool.item
		end

feature -- Setting

	set_in_bench_mode is
			-- Set in_bench_mode to True
		do
			in_bench_mode_bool.set_item (True)
		ensure
			in_bench_mode: in_bench_mode
		end

	set_is_short is
			-- Set is_short to True.
		do
			is_short_bool.set_item (True)
		ensure
			is_short: is_short
		end

	set_order_same_as_text is
			-- Set order_same_as_text to True.
		do
			order_same_as_text_bool.set_item (True)
		ensure
			order_same_as_text: order_same_as_text
		end

	set_in_assertion is
			-- Set in_assertion to True.
		do
			in_assertion_bool.set_item (True)
		ensure
			in_assertion: in_assertion
		end

	set_not_in_assertion is
			-- Set in_assertion to False
		do
			in_assertion_bool.set_item (False)
		ensure
			not_in_assertion: not in_assertion
		end

	set_is_with_breakable is
			-- Set is_with_breakable to True
		do
			is_with_breakable_bool.set_item (True)
		ensure
			is_with_breakable: is_with_breakable
		end

	set_is_without_breakable is
			-- Set is_with_breakable to False
		do
			is_with_breakable_bool.set_item (False)
		ensure
			is_without_breakable: not is_with_breakable
		end

	reset_format_booleans is
			-- Reset all booleans to false.
		do
			is_short_bool.set_item (False)
			in_bench_mode_bool.set_item (False)
			in_assertion_bool.set_item (False)
			order_same_as_text_bool.set_item (False)
		ensure
			not is_short
			not in_bench_mode
			not in_assertion
			not order_same_as_text
		end

feature {NONE}

	is_short_bool: BOOLEAN_REF is
			-- Cell to store `is_short' flag
		once
			create Result
		end

	in_bench_mode_bool: BOOLEAN_REF is
			-- Cell to store `in_bench_mode' flag
		once
			create Result
		end

	in_assertion_bool: BOOLEAN_REF is
			-- Cell to store `in_assertion' flag
		once
			create Result
		end

	order_same_as_text_bool: BOOLEAN_REF is
			-- Cell to store `order_same_as_text' flag
		once
			create Result
		end

	is_with_breakable_bool: BOOLEAN_REF is
			-- Cell to store `is_with_breakable' flag
		once
			create Result
		end

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

end -- class SHARED_FORMAT_INFO
