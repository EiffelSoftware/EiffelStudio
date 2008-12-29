note
	description: "Detector of local scopes for implicative expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_SCOPE_IMPLICATIVE_EXPRESSION

inherit
	AST_SCOPE_EXPRESSION
		redefine
			process_bin_and_as,
			process_bin_and_then_as
		end

create
	make

feature {AST_EIFFEL} -- Visitor pattern

	process_bin_and_as (l_as: BIN_AND_AS)
		do
			l_as.left.process (Current)
			l_as.right.process (Current)
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS)
		do
			l_as.left.process (Current)
			l_as.right.process (Current)
		end

feature {NONE} -- Status

	is_negation_expected: BOOLEAN = False;
			-- Is negated value of a boolean expression expected?

note
	copyright:	"Copyright (c) 2007-2008, Eiffel Software"
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
