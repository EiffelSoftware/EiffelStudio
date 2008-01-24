indexing
	description: "Argument switch for optimization flags"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OPTIMIZED_ARGUMENT_SWITCH

inherit
	ARGUMENT_FLAG_SWITCH
		redefine
			create_option,
			create_value_option
		end

create
	make,
	make_hidden

feature -- Status report

feature {ARGUMENT_PARSER} -- Factory functions

	create_option: OPTIMIZED_ARGUMENT_OPTION
			-- Creates a new argument option for switch
		do
			create Result.make ("", create {ARRAYED_LIST [CHARACTER_8]}.make (0), case_sensitive_flags, Current)
		end

	create_value_option (a_value: STRING_8): OPTIMIZED_ARGUMENT_OPTION
			-- Creates a new argument option given a value `a_value'
		local
			l_flags: ARRAYED_LIST [CHARACTER_8]
		do
			create l_flags.make (a_value.count)
			a_value.linear_representation.do_all (agent (a_item: CHARACTER_8; a_flags: ARRAYED_LIST [CHARACTER_8])
				require
					not_a_item_is_null: a_item /= '%U'
					a_flags_attached: a_flags /= Void
				do
					a_flags.extend (a_item)
				end (?, l_flags))
			create Result.make (a_value, l_flags, case_sensitive_flags, Current)
		end

feature -- Flags

	keep_flag: CHARACTER_8 = 'k';
			-- Flag used to keep assertions

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {OPTIMIZED_ARGUMENT_SWITCH}
