indexing
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

	make (a_path, a_runtime_version: STRING) is
			-- Create new instance of IL_EMITTER
		require
			a_path_not_void: a_path /= Void
			a_path_not_empty: not a_path.is_empty
			a_runtime_version_not_void: a_runtime_version /= Void
			a_runtime_version_not_empty: not a_runtime_version.is_empty
		do
			check
				False
			end
		end

feature -- Status report

	exists: BOOLEAN is
		do
			Result := False
		end

	is_initialized: BOOLEAN is
			-- Is consumer initialized for given path?
		require
			exists: exists
		do
			check
				False
			end
		end

	assembly_found: BOOLEAN
			-- Was last research with `retrieve_assembly_info' successful?

feature -- Access

	name: STRING is
			-- Version of current assembly.
		require
			assembly_found: assembly_found
		do
			check
				False
			end
		end

	version: STRING is
			-- Version of current assembly.
		require
			assembly_found: assembly_found
		do
			check
				False
			end
		end

	culture: STRING is
			-- Culture of current assembly.
		require
			assembly_found: assembly_found
		do
			check
				False
			end
		end

	public_key_token: STRING is
			-- Culture of current assembly.
		require
			assembly_found: assembly_found
		do
			check
				False
			end
		end

	is_in_gac: BOOLEAN is
			-- Was assembly consumed in GAC
		require
			assembly_found: assembly_found
		do
			check
				False
			end
		end

	is_consumed: BOOLEAN is
			-- Has assembly been consumed
		require
			assembly_found: assembly_found
		do
			check
				False
			end
		end
		
	consumed_folder_name: STRING is
			-- Path to consumed assembly folder
		require
			assembly_found: assembly_found
		do
			check
				False
			end
		end	

feature -- Retrieval

	relative_folder_name (a_name, a_version, a_culture, a_key: STRING): STRING is
			-- returns the relative path to an assembly using at least `a_name'
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			check
				False
			end
		ensure
			non_void_result: Result /= Void
			non_empty_result: not Result.is_empty
		end
		
	relative_folder_name_from_path (a_path: STRING): STRING is
			-- Relative path to consumed assembly metadata given `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {RAW_FILE}.make (a_path)).exists
		do	
			check
				False
			end
		ensure
			non_void_result: Result /= Void
			non_empty_result: not Result.is_empty
		end

	retrieve_assembly_info (a_path: STRING) is
			-- Retrieve data about assembly stored at `an_assembly'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			check
				False
			end
		end

	unload is
			-- unload all used resources
		do
			check
				False
			end
		end

feature -- XML generation

	consume_assembly_from_path (a_path: STRING) is
			-- Consume local assembly `a_assembly' and all of its dependencies into EAC
		require
			exists: exists
			non_void_path: a_path /= Void
			non_empty_path: not a_path.is_empty
		do
			check
				False
			end
		end
		

	consume_assembly (a_name, a_version, a_culture, a_key: STRING) is
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
			check
				False
			end
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

end -- class IL_EMITTER

