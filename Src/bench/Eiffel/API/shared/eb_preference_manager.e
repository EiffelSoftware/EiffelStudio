indexing
	description: "Preferences manager for EiffelStudio preferencs.  Extends the default preference with new preferences preference%
		%types specific to EiffelStudio."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCE_MANAGER

inherit
	PREFERENCE_MANAGER

	GRAPHICAL_PREFERENCE_FACTORY

	EV_SHARED_SCALE_FACTORY
		undefine
			default_create
		end

create
	make

feature -- Status Setting

	new_identified_font_preference_value (a_name: STRING; a_value: EV_IDENTIFIED_FONT): IDENTIFIED_FONT_PREFERENCE is
			-- Add a new identified font preference with name `a_name' and `a_value'.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_value /= Void
			not_has_preference: not known_preference (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [EV_IDENTIFIED_FONT, IDENTIFIED_FONT_PREFERENCE]}).
			new_preference (preferences, Current, a_name, a_value)
			font_factory.register_font (Result.value)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: preferences.has_preference (a_name)
		end

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

end -- class EB_PREFERENCE_MANAGER
