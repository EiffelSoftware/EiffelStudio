note
	description: "Error for not supported construction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class NOT_SUPPORTED

inherit
	FEATURE_ERROR
		redefine
			build_explain
		end

create
	make,
	make_from_string

feature {NONE} -- Creation

	make (d: like description; c: AST_CONTEXT; l: LOCATION_AS)
			-- Initialize an error object with the given message `d` describing the issue at position `l` in the context `c`.
		do
			description := d
			c.init_error (Current)
			set_location (l)
		ensure
			description_set: description = d
			class_c_set: class_c = c.current_class
			written_class_set: written_class = c.written_class
			e_feature_unset: not attached c.current_feature implies not attached e_feature
			e_feature_set: attached c.current_feature as f implies f.e_feature ~ e_feature
			column_set: column = l.column
			line_set: line = l.line
		end

	make_from_string (d: STRING_32; c: AST_CONTEXT; l: LOCATION_AS)
			-- Initialize an error object with the given plain string message `d` describing the issue at position `l` in the context `c`.
			-- See also: `make`.
		do
			make (agent {TEXT_FORMATTER}.add (d), c, l)
		ensure
			class_c_set: class_c = c.current_class
			written_class_set: written_class = c.written_class
			e_feature_unset: not attached c.current_feature implies not attached e_feature
			e_feature_set: attached c.current_feature as f implies f.e_feature ~ e_feature
			column_set: column = l.column
			line_set: line = l.line
		end

feature -- Access

	description: PROCEDURE [TEXT_FORMATTER]
			-- Message describing the issue.

	code: STRING = "NOT_SUPPORTED"
			-- Error code.

feature -- Output

	build_explain (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements
				(t,
				locale.translation_in_context ("Error message: {1}%N", "compiler.error"),
				<<description>>)
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
