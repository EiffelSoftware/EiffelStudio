note
	description: "Error for the formal generic part of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VTGD2

inherit
	VTGD
		redefine
			build_explain,
			subcode
		end

create
	default_create

feature -- Properties

	subcode: INTEGER_32 = 2

	type: TYPE_A
		-- Type which should have been conform to `constraints'.

	constraint: TYPE_SET_A
		-- Constraint which was not met by `type'.

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Type:	")
			type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Unaccomplished constraint: ")
			constraint.ext_append_to (a_text_formatter, class_c)
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_type (a_type: TYPE_A)
			-- Set type to `a_type'.		
		require
			a_type_not_void: a_type /= Void
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

	set_constraint (a_type_set: TYPE_SET_A)
			-- Set `constraint' to `a_type_set'.		
		require
			a_type_set_not_void: a_type_set /= Void
		do
			constraint := a_type_set
		ensure
			constraints_set: constraint = a_type_set
		end

	set_feature_name (a_feature_name: STRING_8)
			-- Set feature_name to `a_feature_name'
		do
			feature_name := a_feature_name
		ensure
			set: feature_name = a_feature_name
		end

	proper_feature_name: STRING
			-- Proper feature name, be it from feature, feature_name or just invariant.
		do
			if e_feature /= Void then
				Result := e_feature.name
			elseif feature_name /= Void then
				Result := feature_name
			else
				Result := "invariant"
			end
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

end -- class VTGD2

