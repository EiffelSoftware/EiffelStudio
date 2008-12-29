note
	description: "Error for the formal generic part of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VTGC3

inherit
	VTGC
		redefine
			build_explain,
			subcode
		end

create
	default_create

feature -- Properties

	subcode: INTEGER_32 = 3

	error_info: MC_FEATURE_INFO
			-- List of types with same feature.
			-- This is used to provide the user with a specific list of classes which contain the same feature.

	constraints: TYPE_SET_A
			-- Unmatched constraints.

	feature_name: STRING
			-- Feature name.
			-- This is the name of the feature whch occured multiple times.

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
			--
			-- `a_text_formatter' is used to print the error message.
		do
			Precursor (a_text_formatter)
			error_info.append_error_report (a_text_formatter)
		end

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (a_feature_name: STRING_8)
			-- Set feature_name to `a_feature_name'
		do
			feature_name := a_feature_name
		ensure
			set: feature_name = a_feature_name
		end

	set_error_info (a_error_info: like error_info)
			-- Set classes_with_same_feature to `a_list'
		require
			a_error_info_not_void: a_error_info /= Void
		do
			error_info := a_error_info
		ensure
			is_set: a_error_info = error_info
		end

	set_constraints (a_type_set: TYPE_SET_A)
			-- Set classes_with_same_feature to `a_list'
		require
			a_type_set_not_void: a_type_set /= Void
		do
			constraints := a_type_set
		ensure
			is_set: constraints = a_type_set
		end

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
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
