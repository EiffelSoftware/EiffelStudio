note
	description: "Warning for a non-empty body of an attribute that is of a self-initializing type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class VWAB

inherit
	FEATURE_ERROR
		undefine
			error_string
		end

	WARNING
		undefine
			has_associated_file
		end

create
	make

feature {NONE} -- Initialization

	make (l: LOCATION_AS; c: AST_CONTEXT)
			-- Warning object for unused attribute body at location `l' in context `c'.
		require
			l_attached: attached l
			c_attached: attached c
			current_feature_attached: attached c.current_feature
		do
			c.init_error (Current)
			set_location (l)
		ensure
			class_c_attached: attached class_c
			e_feature_attached: attached e_feature
			location_set: line = l.line and column = l.column
		end

feature -- Properties

	code: STRING = "VWAB"
			-- <Precursor>

invariant
	class_c_attached: attached class_c
	e_feature_attached: attached e_feature

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
