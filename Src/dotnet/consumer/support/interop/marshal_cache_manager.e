note
	description: "Marshalled interface for the Emitter"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	MARSHAL_CACHE_MANAGER

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			initialize_lifetime_service
		end

feature -- Access

	is_successful: BOOLEAN
			-- Was the consuming successful?
		do
			Result := implementation.is_successful
		end

	is_initialized: BOOLEAN
			-- Has current object been initialized?
		do
			Result := internal_is_initialized
		end

	last_error_message: SYSTEM_STRING
			-- Last error message
		do
			Result := implementation.last_error_message
		end

feature -- Basic Exportations

	initialize
			-- initialize the object using default path to EAC
		require
			not_already_initialized: not is_initialized
		do
			create implementation.make
			internal_is_initialized := True
		ensure
			current_initialized: is_initialized
		end

	initialize_with_path (a_path: SYSTEM_STRING)
			-- initialize object with path to specific EAC and initializes it if not already done.
		require
			not_already_initialized: not is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		do
			create implementation.make_with_path (a_path)
			internal_is_initialized := True
		ensure
			current_initialized: is_initialized
		end

	consume_assembly (a_name, a_version, a_culture, a_key: SYSTEM_STRING; a_info_only: BOOLEAN)
			-- consume an assembly using it's display name parts.
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			current_initialized: is_initialized
			non_void_name: a_name /= Void
			valid_name: a_name.length > 0
		do
			implementation.consume_assembly (a_name, a_version, a_culture, a_key, a_info_only)
		end

	consume_assembly_from_path (a_path: SYSTEM_STRING; a_info_only: BOOLEAN; a_references: SYSTEM_STRING)
			-- Consume assembly located `a_path'
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		do
			implementation.consume_assembly_from_path (a_path, a_info_only, a_references)
		end

	prepare_for_unload
			-- prepares all that in necessary be before running app domain in unloaded
		do
			implementation.unload
		end

feature -- Lifetime Services

	initialize_lifetime_service: SYSTEM_OBJECT
			-- Obtains a lifetime service object to control the lifetime policy for this instance
		local
			l_lease: ILEASE
		do
			l_lease ?= Precursor {MARSHAL_BY_REF_OBJECT}
			check l_lease_attached: l_lease /= Void end

			l_lease.initial_lease_time := {TIME_SPAN}.zero
			Result := l_lease
		ensure then
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	internal_is_initialized: BOOLEAN
			-- Storing for `is_initialized'.

	implementation: CACHE_MANAGER;
			-- Access to `CACHE_MANAGER'.

note
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


end -- class MARSHAL_CACHE_MANAGER
