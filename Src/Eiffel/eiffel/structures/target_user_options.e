indexing
	description: "User specific options for a given target."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_USER_OPTIONS

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Initialize user specific option for target `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

feature -- Access

	name: STRING
			-- Name for current target.

	last_location: STRING is
			-- EIFGENs location for `a_target'.
		local
			l_list: like locations
		do
			l_list := locations
			if l_list /= Void then
				Result := l_list.first
			end
		end

	locations: ARRAYED_LIST [STRING]
			-- Set of EIFGENs location for `a_target'.

feature -- Debugging settings

	use_arguments: BOOLEAN is
			-- Use arguments?
		do
			Result := last_profile_index > 0
		end

	arguments: ARRAYED_LIST [like last_argument]
			-- List of arguments used by current project.
			-- Obsolete

	last_profile: TUPLE [title:STRING_32; cwd:STRING; args:STRING; env:HASH_TABLE [STRING_32, STRING_32]] is
			-- List of profiles used by current project.
		do
			if last_profile_index > 0 then
				Result := profiles [last_profile_index]
			end
		end

	last_profile_index: INTEGER
			-- Index of last profile from profiles
			-- a negative value means no profile is selected

	last_argument: STRING is
			-- Last used argument.
		do
			if last_profile_index > 0 then
				Result := last_profile.args
			end
		end

	working_directory: STRING is
			-- Working directory.
		do
			if last_profile_index > 0 then
				Result := last_profile.cwd
			end
		end

	dbg_environment: HASH_TABLE [STRING_32, STRING_32] is
			-- Environment for debugging.
		do
			if last_profile_index > 0 then
				Result := last_profile.env
			end
		end

	profiles: ARRAYED_LIST [like last_profile]
			-- Last used profile.

	favorites: STRING
			-- String representation of the favorites.

feature -- Update

	set_last_location (a_location: like last_location) is
			-- Set `last_location' to `a_location'.
		require
			a_location_not_void: a_location /= Void
		local
			l_list: like locations
		do
			l_list := locations
			if l_list = Void then
				create l_list.make (5)
				l_list.compare_objects
				locations := l_list
			end
				-- Always put `a_location' first in the list.
			l_list.start
			l_list.search (a_location)
			if not l_list.exhausted then
				l_list.remove
			end
			l_list.put_front (a_location)
		ensure
			last_location_set: last_location /= Void and then last_location.is_equal (a_location)
		end

	set_profiles (a_profiles: like profiles) is
			-- Set `profiles' to `a_profiles'.
		do
			profiles := a_profiles
		ensure
			profiles_set: profiles = a_profiles
		end

	set_last_profile (a_profile: like last_profile) is
			-- Set `last_profile' to `a_profile'.
		require
			valid_profile: a_profile = Void or else profiles.has (a_profile)
		do
			if a_profile /= Void then
				last_profile_index := profiles.index_of (a_profile, 1)
			else
				last_profile_index := -1
			end
		ensure
			last_profile_set: last_profile = a_profile
		end

	set_arguments (an_arguments: like arguments) is
			-- Set `arguments' to `an_arguments'.
		do
			arguments := an_arguments
		ensure
			arguments_set: arguments = an_arguments
		end

	set_favorites (a_favorites: like favorites) is
			-- Set `favorites' to `a_favorites'.
		do
			favorites := a_favorites
		ensure
			favorites_set: favorites = a_favorites
		end

invariant
	name_not_void: name /= Void

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
end
