indexing
	description: "Constants used by C++ encapsulation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_IL_CONSTANTS

feature -- Property

	valid_type (a_type: INTEGER): BOOLEAN is
			-- Does `a_type' belong to list of predefined constants.
		do
			inspect
				a_type
			when
				normal_type, creator_type, field_type,
				static_field_type, set_field_type,
				set_static_field_type, static_type,
				get_property_type, set_property_type,
				deferred_type, operator_type, creator_call_type,
				enum_field_type
			then
				Result := True
			else
				Result := False
			end
		end

	need_current (a_type: INTEGER): BOOLEAN is
			-- Does `a_type' correspond to either a static method
			-- or a static field access.
		require
			valid_type: valid_type (a_type)
		do
			Result := a_type /= static_type and
						a_type /= set_static_field_type and
						a_type /= static_field_type and
						a_type /= enum_field_type
		ensure
			current_needed: not Result implies
				(a_type = static_type or a_type = set_static_field_type or
				a_type = static_field_type or a_type = enum_field_type)
		end

feature -- Constants

	normal_type: INTEGER is 1
	creator_type: INTEGER is 2
	field_type: INTEGER is 3
	static_field_type: INTEGER is 4
	set_field_type: INTEGER is 5
	set_static_field_type: INTEGER is 6
	static_type: INTEGER is 7
	get_property_type: INTEGER is 8
	set_property_type: INTEGER is 9
	deferred_type: INTEGER is 10
	operator_type: INTEGER is 11
	creator_call_type: INTEGER is 12
	enum_field_type: INTEGER is 13
			-- Constants used to differentiate all type of IL externals.

	msil_language: INTEGER is 1
	java_language: INTEGER is 2;
			-- Constants used to determine language of externals


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

end -- class SHARED_IL_CONSTANTS
