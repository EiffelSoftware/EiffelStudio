note
	description: "[
		Automated debug information added, otherwise same functionality as {XEL_FEATURE_ELEMENT}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_DEBUG_FEATURE_ELEMENT

inherit
	XEL_FEATURE_ELEMENT
		redefine
			append_local,
			append_expression,
			append_expression_to_start,
			append_expression_to_end,
			append_require,
			append_ensure,
			append_expression_object,
			make
		end

create
	make

feature -- Initialization

	make (a_signature: STRING)
			-- <Precursor>
		do
			Precursor (a_signature)
			current_debug_information := "no debug information"
		end


feature {NONE} -- Access

	current_debug_information: STRING
			-- The current debug information of the expressions added.

feature -- Access

	set_debug_information (a_debug_info: STRING)
			-- Sets the debug information.
		require
			a_debug_info_attached: attached a_debug_info
		do
			current_debug_information := a_debug_info
		ensure
			debug_info_set: current_debug_information.is_equal (a_debug_info)
		end

	append_local (name, type: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (name, type)
		end

	append_expression (a_expression: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end

	append_expression_to_start (a_expression: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end

	append_expression_to_end (a_expression: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end

	append_require (a_expression: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end

	append_expression_object (a_expression: XEL_EXPRESSION)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end

	append_ensure (a_expression: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
