indexing
	description: "Class that provides interface to Eiffel `emitter'"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_EMITTER

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create new instance of IL_EMITTER
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

feature -- Retrieval

	retrieve_assembly_info (an_assembly: STRING) is
			-- Retrieve data about assembly stored at `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		do
			check
				False
			end
		end

feature -- XML generation

	consume_local_assembly (an_assembly, a_destination: STRING) is
			-- Consume local assembly `an_assembly' and all of its local dependencies
			-- into 'a_destination'.
			-- GAC dependencies will be put into the EAC
		require
			exists: exists
			non_void_path: an_assembly /= Void
			non_empty_path: not an_assembly.is_empty
			non_void_dest: a_destination /= Void
			assembly_exists: (create {RAW_FILE}.make (an_assembly.string)).exists
			dest_exists: (create {DIRECTORY}.make (a_destination.string)).exists
		do
			check
				False
			end
		end
		

	consume_gac_assembly (a_name, a_version, a_culture, a_key: STRING) is
			-- consume an assembly into the EAC from the gac defined by
			-- "'a_name', Version='a_version', Culture='a_culture', PublicKeyToken='a_key'"
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
	
end -- class IL_EMITTER

