indexing
	description	: "Emitter's root class"
	assembly_attribute:
		create {COM_VISIBLE_ATTRIBUTE}.make (False) end,
		create {ASSEMBLY_COMPANY_ATTRIBUTE}.make ("Eiffel Software") end,
		create {ASSEMBLY_COPYRIGHT_ATTRIBUTE}.make ("Copyright Eiffel Software 1985-2003") end
	date: "$Date$"
	revision: "$Revision$"

class
	EMITTER

inherit
	ARGUMENT_PARSER
		rename
			make as parser_make
		end

	SHARED_XML_OUTPUT
		export
			{NONE} all
		end

	CACHE_PATH
		export
			{NONE} all
		end
	
create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			parser_make (<<Dest_path_switch, Dest_path_short, Help_switch,
							Help_spelled_switch, No_logo_switch, List_assemblies_switch,
							List_assemblies_short, Init_switch, No_output_switch,
							No_output_short, Eac_switch, Eac_short, Remove_switch,
							Remove_short, Nice_switch, Force_switch, Force_short, No_references_switch, 
							Consume_from_fullname_switch, Consume_from_fullname_short, Eiffel_var_switch>>)
			parse

			if not successful then
				process_error (error_message)
			else
				start
			end
		end

feature -- Access

	Dest_path_switch: STRING is "dest"
			-- Switch used to specify destination path

	Dest_path_short: STRING is "d"
			-- Shortcut equivalent of `Dest_path_switch'

	Help_switch: STRING is "?"
			-- Switch used to display usage

	Help_spelled_switch: STRING is "help"
			-- Switch used to display usage

	No_logo_switch: STRING is "nologo"
			-- Switch used to prevent copyright notice display

	List_assemblies_switch: STRING is "list"
			-- Switch used to list assemblies in EAC

	List_assemblies_short: STRING is "l"
			-- Switch used to list assemblies in EAC

	Init_switch: STRING is "init"
			-- Switch used to initialize EAC

	No_output_switch: STRING is "nooutput"
			-- Switch used to prevent information display

	No_output_short: STRING is "n"
			-- Shortcut equivalent of `No_output_switch'

	Eac_switch: STRING is "add"
			-- Switch used to put assembly in EAC

	Eac_short: STRING is "a"
			-- Shortcut equivaleent of `Eac_switch'

	Remove_switch: STRING is "remove"
			-- Switch used to put assembly in EAC

	Remove_short: STRING is "r"
			-- Shortcut equivaleent of `Eac_switch'

	Nice_switch: STRING is "nice"

	Force_switch: STRING is "force"
			-- Force GAC dependancies from local assembliesto be consumed into the local destination

	Force_short: STRING is "f"
			-- Shortcut force GAC dependancies from local assembliesto be consumed into the local destination

	No_references_switch: STRING is "noref"
			-- Stop the emitter from generating a local assembly's references

	Consume_from_fullname_switch: STRING is "fullname"
			-- consume an assembly from the GAC

	Consume_from_fullname_short: STRING is "fn"
			-- consume an assembly from the GAC

	Eiffel_var_switch: STRING is "eiffel_var"
			-- Swtich to specify alternative ISE_EIFFEL variable

feature -- Status report

	no_copyright_display: BOOLEAN
			-- Should copyright notice not be displayed?

	usage_display: BOOLEAN
			-- Should usage be displayed?

	list_assemblies: BOOLEAN
			-- Should EAC assemblies list be displayed?

	init: BOOLEAN
			-- Should EAC be intialized?

	no_output: BOOLEAN
			-- Should emitter not display output?

	remove: BOOLEAN
			-- Should assembly be removed from EAC?

	force_local_generation: BOOLEAN
			-- Should a local assembly's GAC dependancies be forced into the EAC?

	consume_from_fullname: BOOLEAN
			-- should the specified assembly be consumed from the GAC?

feature {NONE} -- Implementation

	start is
			-- Execute emitter according to options
		local
			ct: CONSUMED_TYPE
			assemblies: ARRAY [CONSUMED_ASSEMBLY]
			i: INTEGER
			dir: DIRECTORY
			ass: ASSEMBLY
			cr: CACHE_READER
			l_exe_env: EXECUTION_ENVIRONMENT
		do
			clean_eiffel_assembly_cache

			if not no_copyright_display then
				display_copyright		
			end
			create cr
			if not cr.is_initialized then
				cr.initialize
			end
			if init then
				from
					i := 1
				until
					i > initial_assemblies.count
				loop
					ass := feature {ASSEMBLY}.load_from (initial_assemblies.item(i).to_cil)
					consume_in_eac (ass)
					i := i + 1
				end
			elseif list_assemblies then
				assemblies := (create {CACHE_READER}).consumed_assemblies
				if assemblies = Void then
					process_error ("EAC not initialized")
				else
					from
						i := 1
					until
						i > assemblies.count
					loop
						io.put_string (i.out)
						io.put_string (": ")
						io.put_string (assemblies.item (i).out)
						io.put_new_line
						i := i + 1
					end
				end
			elseif usage_display then
				display_usage
			elseif not successful then
				display_error
			else
				from
					assembly_locations.start
				until
					assembly_locations.after
				loop
					if consume_from_fullname then
						ass := feature {ASSEMBLY}.load_string (assembly_locations.item.to_cil)
					else
						if not feature {SYSTEM_FILE}.exists (assembly_locations.item.to_cil) then
							set_error (Invalid_assembly, assembly_locations.item)
						else
							ass := feature {ASSEMBLY}.load_from (assembly_locations.item.to_cil)
							if ass = Void then
								set_error (Load_assembly_failure, assembly_locations.item)
							end
						end
					end
					if successful then
						if remove then
							remove_from_eac (ass)
						else
							consume_in_eac (ass)				
						end
					else
						process_error (error_message)
					end

					assembly_locations.forth
				end
			end
		end

	process_switch (switch, switch_value: STRING) is
			-- Process switch `switch' associated with value `switch_value'.
		do
			if switch.is_equal (Dest_path_switch) or switch.is_equal (Dest_path_short) then
				if (create {DIRECTORY}.make (switch_value)).exists then
					destination_path := switch_value.clone (switch_value)
					destination_path.prune_all_trailing ('\')
				else
					set_error (Invalid_destination_path, switch_value)
				end
			elseif switch.is_equal (Help_switch) or switch.is_equal (Help_spelled_switch) then
				usage_display := True
			elseif switch.is_equal (No_logo_switch) then
				no_copyright_display := True
			elseif switch.is_equal (List_assemblies_switch) or switch.is_equal (List_assemblies_short) then
				list_assemblies := True
			elseif switch.is_equal (Init_switch) then
				init := True
			elseif switch.is_equal (No_output_switch) or switch.is_equal (No_output_short) then
				no_output := True
			elseif switch.is_equal (Eac_switch) or switch.is_equal (Eac_short) then
--				put_in_eac := True
			elseif switch.is_equal (Remove_switch) or switch.is_equal (Remove_short) then
				remove := True
			elseif switch.is_equal (Nice_switch) then
				has_indented_output.set_item (True)
			elseif switch.is_equal (Force_switch) or switch.is_equal (Force_short) then
				force_local_generation := True
			elseif switch.is_equal (Consume_from_fullname_switch) or switch.is_equal (Consume_from_fullname_short) then
				consume_from_fullname := True
			elseif switch.is_equal (Eiffel_var_switch) then
				set_internal_eiffel_path (switch_value)
--			elseif target_path = Void or target_path.is_empty then
--				set_error (Invalid_target_path, "None Set!")
			elseif switch.is_equal (No_references_switch) then
--				no_dependancies := True
			end
		end

	process_non_switch (non_switch_value: STRING) is
			-- process the args with no swtiches
		do
			assembly_locations.extend (non_switch_value)
		end

	post_process is
			-- Post argument parsing processing.
		local
			retried: BOOLEAN
		do
			if not retried then
				if not (list_assemblies or init or usage_display) and assembly_locations.count = 0 then
					set_error (No_target, Void)
				elseif destination_path /= Void then
					set_error (No_destination_if_put_in_eac, Void)
				elseif force_local_generation then
					set_error (Cannot_force_local_and_eac, Void)
				elseif force_local_generation then
					set_error (Cannot_force_and_exclude_references, Void)
				elseif not (list_assemblies or init or usage_display) and destination_path = Void then
					destination_path := (create {EXECUTION_ENVIRONMENT}).current_working_directory
				end
			end
		rescue
			retried := True
			retry
		end

	display_copyright is
			-- Display copyright notice
		do
			io.put_string ("%NISE Eiffel Metadata Consumer Version ")
			io.put_string (Version)
			io.put_string ("%NCopyright (C) Interactive Software Engineering Inc. All rights reserved.")
			io.put_string ("%N%N")
		end

	display_usage is
			-- Display tool usage
		do
			io.put_string ("Usage: ")
			io.put_string (System_name)
			io.put_string (" <assembly> [/g] [/a | /r] [/n] [/nologo] [/nice] [/eiffel_var:<path>]%N")
			io.put_string ("       " + System_name)
			io.put_string (" <assembly> [/g] [/d:destination] [/n] [/nologo] [/nice] [/f | /noref] [/eiffel_var:<path>]%N")
			io.put_string ("       " + System_name)
			io.put_string (" /l [/nologo] [/eiffel_var:<path>]%N")
			io.put_string ("       " + System_name)
			io.put_string (" /init [/n] [/nologo] [/nice] [/eiffel_var:<path>]%N%N")
			io.put_string (" - Options -%N%N")
			io.put_string ("/fullname%N   Consume an assembly using its fullname. Short form is '/fn'.%N%N")
			io.put_string ("/dest:<path>%N   Generate XML in directory '<path>'. Short form is '/d'.%N%N")
			io.put_string ("/add%N   Put assembly in Eiffel Assembly Cache. Short form is '/a'.%N%N")
			io.put_string ("/remove%N   Remove assembly from Eiffel Assembly Cache. Short form is '/r'.%N%N")
			io.put_string ("/nooutput%N   Prevent progress information display. Short form is '/n'.%N%N")
			io.put_string ("/nologo%N   Prevent display of copyright notice.%N%N")
			io.put_string ("/init%N   Initialize Eiffel Assembly Cache (can only be run once).%N%N")
			io.put_string ("/list%N   List assemblies in EAC. Short form is '/l'.%N%N")
			io.put_string ("/nice%N   XML output is indented.%N%N")
			io.put_string ("/force%N   Consume a local assembly's GAC dependancies into same location. Short form is '/f'.%N%N")
			io.put_string ("/noref%N   Do not generated assembly dependancies.%N%N")
			io.put_string ("/eiffel_var:<path>%N   Use alternative ISE_EIFFEL path '<path>'%N%N")
			io.put_string (" - Arguments -%N%N")
			io.put_string ("<assembly>%N   Name of assembly containing types to generate XML for. <assembly> can%N")
			io.put_string ("   be either a path to a local assembly or an assembly's fully quantified name ONLY when '/fn' is used%N")
			io.put_string ("   e.g. - %"System.Xml, Version=1.0.3300.0, Culture=neutral, PublicKeyToken=b77a5c561934e089%".%N%N")
			io.put_string ("<path>%N   Valid path to existing folder%N%N")
		end

	display_status (s: STRING) is
			-- Display progress status.
		do
			io.put_string (s)
			io.put_new_line
		end

	process_error (s: STRING) is
			-- Display error.
		do
			io.put_string ("%N" + "** Error: " + s + "%N%N")
			io.put_string ("Type 'emitter /?' for usage information.%N%N")
		end

	consume_in_eac (ass: ASSEMBLY) is
			-- Consume `ass' and put result in EAC
		require
			non_void_assembly: ass /= Void
			signed_assembly: ass.get_name.get_public_key_token /= Void
		local
			cr: CACHE_READER
			writer: CACHE_WRITER
		do
			if ass/= Void then
				create cr
				if not cr.is_initialized then
					cr.initialize
				end
				create writer
				if not no_output then
					display_status ("Consuming " + create {STRING}.make_from_cil (ass.get_name.full_name))
					writer.set_status_printer (agent display_status)
				end
				writer.set_error_printer (agent process_error)
				writer.add_assembly (ass)
			end
		end

	remove_from_eac (ass: ASSEMBLY) is
			-- Remove `ass' from EAC
		require
			non_void_assembly: ass /= Void
			signed_assembly: ass.get_name.get_public_key_token /= Void
		local
			writer: CACHE_WRITER
		do
			if ass/= Void then
				create writer
				if not no_output then
					display_status ("Removing " + create {STRING}.make_from_cil (ass.get_name.full_name))
					writer.set_status_printer (agent display_status)
				end
				writer.set_error_printer (agent process_error)
				writer.remove_assembly (create  {STRING}.make_from_cil (ass.location))
			end
		end
	
	assembly_consumer: ASSEMBLY_CONSUMER is
			-- Assembly consumer
		once
			create Result
			if not no_output then
				Result.set_status_printer (agent display_status)
			end
			Result.set_error_printer (agent process_error)
			Result.set_destination_path (destination_path)
		end

	destination_path: STRING
			-- Path where to generate XML

	System_name: STRING is "emitter"
			-- Name of executable

	Version: STRING is "2.0"

	initial_assemblies: ARRAY [STRING] is
			-- Assemblies that will be imported when EAC is initialized
		once
			if (create {RAW_FILE}.make ("C:\WINDOWS\Microsoft.NET\Framework\v1.0.3705\mscorlib.dll")).exists then
				Result := <<"C:\WINDOWS\Microsoft.NET\Framework\v1.0.3705\mscorlib.dll">>
			else
				Result := <<"C:\WINNT\Microsoft.NET\Framework\v1.0.3705\mscorlib.dll">>				
			end
		end

	clean_eiffel_assembly_cache is
			-- Verify that assembly referenced in EAC are still existing
			-- if not then remove it from EAC.
		local
			cr: CACHE_READER
			cw: CACHE_WRITER
			l_assemblies_info: ARRAY [CONSUMED_ASSEMBLY_INFO]
			i: INTEGER
			l_assembly_name: ASSEMBLY_NAME
			l_assembly_location: STRING
			l_same_assembly: BOOLEAN
		do
			create cr
			if cr.is_initialized then
				io.put_string ("%NCleaning Eiffel assembly cache.%N")
				remove_corrupted_xml

				l_assemblies_info := cr.consumed_assemblies_info
				from
					i := 1
					create cw
				until
					i > l_assemblies_info.count
				loop
					l_assembly_location := l_assemblies_info.item (i).location
					if not feature {SYSTEM_FILE}.exists (l_assembly_location.to_cil) then
						io.put_string ("Removing assembly: " + l_assembly_location + " because file does not exist anymore.%N")
						create cw
						cw.remove_assembly (l_assembly_location)
					else
						l_assembly_name := feature {ASSEMBLY_NAME}.get_assembly_name (l_assembly_location.to_cil)
							-- Verify that version, culture... are the same.
						if
							l_assemblies_info.item (i).assembly.out.is_equal (create {STRING}.make_from_cil (l_assembly_name.full_name))
						then
							l_same_assembly := True
						else
							l_same_assembly := False
						end

						if not l_same_assembly then
							io.put_string ("Removing assembly: " + l_assembly_location + " because file has been modified.%N")
							cw.remove_assembly (l_assembly_location)
						end
					end
					i := i + 1
				end
				io.put_string ("%N")
			end
		end

	remove_corrupted_xml is
			-- Remove all directories under assemblies\dotnet
			-- that do not contain a types.xml file.
		local
			cr: CACHE_READER
			l_dir: DIRECTORY_INFO
			l_sub_directories: NATIVE_ARRAY [SYSTEM_STRING]
			l_type_file: STRING
			i: INTEGER
		do
			create cr

			l_sub_directories := feature {SYSTEM_DIRECTORY}.get_directories ((Eiffel_path + cr.Eac_path).to_cil)
			from
				i := 0
			until
				i = l_sub_directories.count
			loop
				create l_type_file.make_from_cil (l_sub_directories.item (i))
				l_type_file := l_type_file + "\types.xml"
				if not feature {SYSTEM_FILE}.exists (l_type_file.to_cil) then
					create l_dir.make (l_sub_directories.item (i))
					l_dir.delete_boolean (True)
				end
				i := i + 1
			end
			
		end

end -- class EMITTER
