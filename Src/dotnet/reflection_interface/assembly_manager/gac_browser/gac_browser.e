indexing
	description: "GAC Browser"
	external_name: "ISE.AssemblyManager.GACBrowser"

class
	GAC_BROWSER

inherit
	CONVERSION_SUPPORT
	
feature -- Access

	shared_assemblies: LINKED_LIST [ASSEMBLY_DESCRIPTOR] is
		indexing
			description: "Assemblies in the GAC"
			external_name: "SharedAssemblies"
		local
			assembly_path: STRING
			assemblies, subdirectories: NATIVE_ARRAY [DIRECTORY_INFO]
			wde: WINDOWS_DIRECTORY_EXTRACTOR
			dir_info: DIRECTORY_INFO
			versions: LINKED_LIST [ASSEMBLY_DESCRIPTOR]
			i: INTEGER
		do
			create Result.make
			create wde.make
			create assembly_path.make_from_cil (wde.windows_directory_name)
			assembly_path.remove (assembly_path.count)
			assembly_path.append (gac_path)
			create dir_info.make_directory_info (assembly_path.to_cil)
			assemblies := dir_info.get_directories
			from
				i := 0
			until
				i >= assemblies.count
			loop
				versions := assembly_versions (assemblies.item (i))
				Result.append (versions)
				i := i + 1
			end
		ensure
		    Result_exists: Result /= Void
		end 

	gac_path: STRING is "\Assembly\GAC"
		indexing
			description: "Relative path to the GAC"
			external_name: "GacPath"
		end
		
feature {NONE} -- Implementation

	assembly_versions (dir: DIRECTORY_INFO): LINKED_LIST [ASSEMBLY_DESCRIPTOR] is
		indexing
			description: "Versions of assembly in `dir'"
			external_name: "AssemblyVersions"
		require
			dir_not_void: dir /= Void
		local
			version_dirs: NATIVE_ARRAY [DIRECTORY_INFO]
			desc: ASSEMBLY_DESCRIPTOR
			assembly: ASSEMBLY_NAME
			name, version, culture, public_key: STRING
			files: NATIVE_ARRAY [FILE_INFO]
			i, j, n: INTEGER
			file: STRING
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
					create file.make_from_cil (files.item (j).get_full_name)
					assembly := load_from_file (file)
					if assembly /= Void then
						desc := assembly_descriptor_from_name (assembly)
						Result.extend (desc)							
					end
					j := j + 1
				end
				i := i + 1
			end
		ensure
			Result_exists: Result /= Void
		end
		
	load_from_file (file: STRING): ASSEMBLY_NAME is
		indexing
			description: "Assembly stored in `file' (Void if `file' format is invalid)"
			external_name: "LoadFromFile"
		require
			file_not_void: file /= Void
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if file.substring_index (current_assembly_path, 1) = 0 then
					create Result.make
					Result ?= Result.get_assembly_name (file.to_cil)
				else
					Result := Void
				end

			else 
				Result := Void
			end
		rescue
			rescued := True
			retry
		end
		
		
	current_assembly_path: STRING is
			-- a list of all the assembly file types
		local
			assembly: ASSEMBLY
			assembly_descriptor: ASSEMBLY_DESCRIPTOR
		once
				assembly_descriptor := assembly_descriptor_from_name (assembly.get_executing_assembly.get_name)
				Result := ""
				Result.append (assembly_descriptor.name)
				Result.append ("\")
				Result.append (assembly_descriptor.version)
				Result.append ("_")
				-- need to locate Netural keyword in dictionary
				if not assembly_descriptor.culture.is_equal("neutral") then
					Result.append (assembly_descriptor.culture)
				end
				Result.append ("_")
				Result.append (assembly_descriptor.public_key)
				Result.append ("_")
				Result.append ("\")
		end
		

end -- class GAC_BROWSER
