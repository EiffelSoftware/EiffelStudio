indexing
	description: "GAC Browser"
	external_name: "AssemblyManager.GACBrowser"

class
	GAC_BROWSER

feature -- Access

	shared_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
	        -- Assemblies in GAC.
		indexing
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
			assembly_path := assembly_path.concat_string_string (assembly_path.remove (assembly_path.length - 1, 1), "\Assembly\GAC")
			create dir_info.make_directoryinfo (assembly_path)
			assemblies := dir_info.getdirectories
			from
				i := 0
			until
				i >= assemblies.count
			loop
				versions := assembly_versions (assemblies.item (i))
				Result.addrange (versions)
				i := i + 1
			end
		ensure
		    Result_exists: Result /= Void
		end 

	Neutral_culture: STRING is "neutral"
			-- Neutral culture as a string
		indexing
			external_name: "NeutralCulture"
		end
		
feature {NONE} -- Implementation

	assembly_versions (dir: SYSTEM_IO_DIRECTORYINFO): SYSTEM_COLLECTIONS_ARRAYLIST is
			-- Versions of assembly in `dir'.
		indexing
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
			version_dirs := dir.getdirectories
			from
				i := 0
			until
				i >= version_dirs.count
			loop
				files := version_dirs.item (i).getfiles
				from
					j := 0
				until
					j >= files.count
				loop
					assembly := load_from_file (files.item (j).fullname)
					if assembly /= Void then
						name := assembly.name
						version := assembly.version.tostring
						culture := assembly.cultureinfo.name
						if culture /= Void then
							if culture.length = 0 then
								culture := Neutral_culture
							end
						end
						public_key := decode_key (assembly.getpublickeytoken)
						create desc.make1
						desc.make (name, version, culture, public_key)
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
			-- Assembly stored in `file'.
			-- Void if `file' format is invalid.
		indexing
			external_name: "LoadFromFile"
		require
			file_not_void: file /= Void
		local
			rescued: BOOLEAN
		do
			if not rescued then
				create Result.make
				Result := Result.getassemblyname (file)
			else 
				Result := Void
			end
		rescue
			rescued := True
			retry
		end

	decode_key (a_key: ARRAY [INTEGER_8]): STRING is
			-- Printable representation of `a_key'.
		indexing
			external_name: "DecodeKey"
		require
			a_key_not_void: a_key /= Void
		local
			i: INTEGER
			hex_rep: STRING
		do
			Result := ""
			from
				i := 0
			until
				i >= a_key.count
			loop
				hex_rep := a_key.item (i).tostring_string ("X").tolower
				if hex_rep.length < 2 then
					hex_rep := hex_rep.concat_string_string ("0", hex_rep)
				end
				Result := Result.concat_string_string (Result, hex_rep)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

end -- class GAC_BROWSER
