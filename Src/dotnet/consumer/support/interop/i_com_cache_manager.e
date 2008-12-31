note
	description: "COM interface for supported metadata consumer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	interface_metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE1AC-A8FB-44AE-9451-0D5595E8E620") end

deferred class
	I_COM_CACHE_MANAGER

feature -- Initialization

	initialize
			-- initialize the object using default path to EAC
		require
			not_already_initialized: not is_initialized
		deferred
		ensure
			current_initialized: is_initialized
		end

	initialize_with_path (a_path: SYSTEM_STRING)
			-- initialize object with path to specific EAC and initializes it if not already done.
		require
			not_already_initialized: not is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		deferred
		ensure
			eac_path_set: eac_path = a_path
			current_initialized: is_initialized
		end

feature -- Uninitialization

	unload
			-- unloads initialized app domain and cache releated objects to preserve resources
		deferred
		end

feature -- Access

	is_successful: BOOLEAN
			-- Was the consuming successful?
		deferred
		end

	is_initialized: BOOLEAN
			-- has COM object been initialized?
		deferred
		end

	last_error_message: SYSTEM_STRING
			-- Last error message
		deferred
		end

feature -- Basic Operations

	consume_assembly (a_name, a_version, a_culture, a_key: SYSTEM_STRING; a_info_only: BOOLEAN)
			-- consume an assembly using it's display name parts.
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			current_initialized: is_initialized
			non_void_name: a_name /= Void
			valid_name: a_name.length > 0
		deferred
		end

	consume_assembly_from_path (a_path: SYSTEM_STRING; a_info_only: BOOLEAN; a_references: SYSTEM_STRING)
			-- Consume assembly located `a_path'
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		deferred
		end

feature {NONE} -- Implementation

	eac_path: SYSTEM_STRING
			-- Location of EAC `Eiffel Assembly Cache'
		note
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		deferred
		end

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


end -- I_COM_CACHE_MANAGER
