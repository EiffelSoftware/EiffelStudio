note
	description: "Error in loop variable declaration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LOOP_VARIABLE_ERROR

inherit
	FEATURE_ERROR
		redefine
			build_explain,
			help_file_name
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Creation

	make (c: AST_CONTEXT; n: ID_AS)
			-- Create error object for loop variable named `n' in the context `c'.
		require
			c_attached: c /= Void
			n_attached: n /= Void
		do
			c.init_error (Current)
			set_variable_name (n.name_id)
			set_location (n)
		ensure
			variable_name_set: variable_name /= Void
		end

feature -- Error properties

	code: STRING = "Loop variable error"
			-- Error code

	help_file_name: STRING_8 = "Loop_variable_error"
			-- Help file name

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			a_text_formatter.add ("Loop variable: ")
			a_text_formatter.add (variable_name)
			a_text_formatter.add_new_line
		end

feature {NONE} -- Access

	variable_name: STRING
			-- Loop variable name

feature {NONE} -- Modification

	set_variable_name (id: INTEGER)
			-- Assign name extracted from name ID `id' to `variable_name'.
		require
			valid_id: id >= 1
		do
			variable_name := Names_heap.item (id)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
