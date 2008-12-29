note
	description: "Class that provides interface to Eiffel `emitter'"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_EMITTER

create
	make

feature {NONE} -- Initialization

	make (a_path, a_runtime_version: STRING)
			-- Create new instance of IL_EMITTER
		require
			a_path_not_void: a_path /= Void
			a_path_not_empty: not a_path.is_empty
			a_runtime_version_not_void: a_runtime_version /= Void
			a_runtime_version_not_empty: not a_runtime_version.is_empty
		do
			implementation := (create {EMITTER_FACTORY}).new_emitter (a_runtime_version)
			if implementation /= Void then
				implementation.initialize_with_path (create {UNI_STRING}.make (a_path))
			end
		end

feature -- Status report

	exists: BOOLEAN
		do
			Result := implementation /= Void
		end

	is_initialized: BOOLEAN
			-- Is consumer initialized for given path?
		require
			exists: exists
		do
			Result := implementation.is_initialized
		end

	last_com_code: INTEGER
			-- Last value of the COM error if any.
		require
			exists: exists
		do
			Result := implementation.last_call_success
		end

feature -- Clean up

	unload
			-- unload all used resources
		do
			implementation.unload
		end

feature -- XML generation

	consume_assembly_from_path (a_path: STRING; a_info_only: BOOLEAN; a_references: STRING)
			-- Consume local assembly `a_assembly' and all of its dependencies into EAC
		require
			exists: exists
			non_void_path: a_path /= Void
			non_empty_path: not a_path.is_empty
		local
			l_refs: UNI_STRING
		do
			if a_references /= Void then
				create l_refs.make (a_references)
			end
			implementation.consume_assembly_from_path (
				create {UNI_STRING}.make (a_path),
				a_info_only,
				l_refs)
		end

	consume_assembly (a_name, a_version, a_culture, a_key: STRING; a_info_only: BOOLEAN)
			-- consume an assembly into the EAC from assemblyy defined by
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			exists: exists
			non_void_name: a_name /= Void
			non_void_version: a_version /= Void
			non_void_culture: a_culture /= Void
			non_void_key: a_key /= Void
			non_empty_name: not a_name.is_empty
			non_empty_version: not a_version.is_empty
			non_empty_culture: not a_culture.is_empty
			non_empty_key: not a_key.is_empty
		do
			implementation.consume_assembly (
				create {UNI_STRING}.make (a_name),
				create {UNI_STRING}.make (a_version),
				create {UNI_STRING}.make (a_culture),
				create {UNI_STRING}.make (a_key),
				a_info_only)
		end

feature {NONE} -- Implementation

	implementation: COM_CACHE_MANAGER;
			-- Com object to get information about assemblies and emitting them.

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

end -- class IL_EMITTER
