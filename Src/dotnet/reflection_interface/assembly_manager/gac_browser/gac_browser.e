indexing
	description: "GAC Browser"
	external_name: "ISE.AssemblyManager.GACBrowser"

class
	GAC_BROWSER

inherit
	ISE_REFLECTION_CONVERSIONSUPPORT
	
feature -- Access

	shared_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
		indexing
			description: "Assemblies in the GAC"
			external_name: "SharedAssemblies"
		local
			assembly_path: STRING
			assemblies, subdirectories: ARRAY [SYSTEM_IO_DIRECTORYINFO]
			wde: WINDOWS_DIRECTORY_EXTRACTOR
			dir_info: SYSTEM_IO_DIRECTORYINFO
			versions: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
		do
			create Result.make
			create wde.make
			assembly_path := wde.windows_directory_name
			assembly_path := assembly_path.concat_string_string (assembly_path.remove (assembly_path.get_length - 1, 1), Gac_path)
			create dir_info.make_directoryinfo (assembly_path)
			assemblies := dir_info.get_directories
			from
				i := 0
			until
				i >= assemblies.count
			loop
				versions := assembly_versions (assemblies.item (i))
				Result.add_range (versions)
				i := i + 1
			end
		ensure
		    Result_exists: Result /= Void
		end 

	Gac_path: STRING is "\Assembly\GAC"
		indexing
			description: "Relative path to the GAC"
			external_name: "GacPath"
		end
		
feature {NONE} -- Implementation

	assembly_versions (dir: SYSTEM_IO_DIRECTORYINFO): SYSTEM_COLLECTIONS_ARRAYLIST is
		indexing
			description: "Versions of assembly in `dir'"
			external_name: "AssemblyVersions"
		require
			dir_not_void: dir /= Void
		local
			version_dirs: ARRAY [SYSTEM_IO_DIRECTORYINFO]
			desc: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			assembly: SYSTEM_REFLECTION_ASSEMBLYNAME
			name, version, culture, public_key: STRING
			files: ARRAY [SYSTEM_IO_FILEINFO]
			i, j, n: INTEGER
		do
			create Result.make
			version_dirs := dir.get_directories
			from
				i := 0
			until
				i >= version_dirs.count
			loop
				files := version_dirs.item (i).get_files
				from
					j := 0
				until
					j >= files.count
				loop
					assembly := load_from_file (files.item (j).get_full_name)
					if assembly /= Void then
						desc := assembly_descriptor_from_name (assembly)
						n := Result.add (desc)
					end
					j := j + 1
				end
				i := i + 1
			end
		ensure
			Result_exists: Result /= Void
		end

	load_from_file (file: STRING): SYSTEM_REFLECTION_ASSEMBLYNAME is
		indexing
			description: "Assembly stored in `file' (Void if `file' format is invalid)"
			external_name: "LoadFromFile"
		require
			file_not_void: file /= Void
		local
			rescued: BOOLEAN
		do
			if not rescued then
				create Result.make
				Result := Result.get_assembly_name (file)
			else 
				Result := Void
			end
		rescue
			rescued := True
			retry
		end

end -- class GAC_BROWSER
