indexing
	description	: "Emitter's root class"
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
		
creation
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			parser_make (<<Dest_path_switch, Dest_path_short, Help_switch,
							Help_spelled_switch, No_logo_switch, List_assemblies_switch,
							List_assemblies_short, Init_switch, No_output_switch,
							No_output_short, Eac_switch, Eac_short, Remove_switch,
							Remove_short, Nice_switch, Force_switch, Force_short, No_references_switch, Consume_from_fullname_switch, Consume_from_fullname_short>>)
			parse
			
			if not successful then
				process_error (error_message)
			else
				create consumed_assemblies.make
				consumed_assemblies.compare_objects
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

	put_in_eac: BOOLEAN
			-- Should assembly be put in EAC?
	
	remove: BOOLEAN
			-- Should assembly be removed from EAC?
			
	force_local_generation: BOOLEAN
			-- Should a local assembly's GAC dependancies be forced into the EAC?
			
	no_dependancies: BOOLEAN
			-- Should no dependancies be generated?
			
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
		do
			if not no_copyright_display then
				display_copyright		
			end
			if init then
				create cr
				if cr.is_initialized then
					process_error ("Cache already initialized!")
				else
					(create {EIFFEL_XML_SERIALIZER}).serialize (create {CACHE_INFO}.make, cr.Absolute_info_path)
					from
						i := 1
					until
						i > initial_assemblies.count
					loop
						ass := feature {ASSEMBLY}.load_from (initial_assemblies.item(i).to_cil)
						consume_in_eac (ass)
						i := i + 1
					end
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
				create cr
				if consume_from_fullname then
					ass := feature {ASSEMBLY}.load_string (target_path.to_cil)
				else
					ass := feature {ASSEMBLY}.load_from (target_path.to_cil)					
				end
				if not cr.is_initialized then
					set_error (Eac_not_initialized, Void)
				elseif ass = Void then
					set_error (Invalid_assembly, target_path)
				elseif put_in_eac and ass.get_name.get_public_key_token = Void then
					set_error (Non_signed_assembly, target_path)
				end
				if successful then
					if put_in_eac then
						consume_in_eac (ass)						
					elseif remove then
						remove_from_eac (ass)
					else
						consume_into_path (ass)
					end
				else
					process_error (error_message)
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
				put_in_eac := True
			elseif switch.is_equal (Remove_switch) or switch.is_equal (Remove_short) then
				remove := True
			elseif switch.is_equal (Nice_switch) then
				has_indented_output.set_item (True)
			elseif switch.is_equal (Force_switch) or switch.is_equal (Force_short) then
				force_local_generation := True
			elseif switch.is_equal (Consume_from_fullname_switch) or switch.is_equal (Consume_from_fullname_short) then
				consume_from_fullname := True
			elseif target_path = Void or target_path.is_empty then
				set_error (Invalid_target_path, "None Set!")
			elseif switch.is_equal (No_references_switch) then
				no_dependancies := True
			end
		end

	process_non_switch (non_switch_value: STRING) is
			-- process the args with no swtiches
		do
			target_path := non_switch_value
		end

	post_process is
			-- Post argument parsing processing.
		local
			assembly: ASSEMBLY
			retried: BOOLEAN
		do
			if not retried then
				if not (list_assemblies or init or usage_display) and target_path = Void then
					set_error (No_target, Void)
				elseif put_in_eac and destination_path /= Void then
					set_error (No_destination_if_put_in_eac, Void)
				elseif put_in_eac and force_local_generation then
					set_error (Cannot_force_local_and_eac, Void)
				elseif put_in_eac and no_dependancies then
					set_error (Dependancies_must_be_generated, Void)
				elseif force_local_generation and no_dependancies then
					set_error (Cannot_force_and_exclude_references, Void)
				elseif not (list_assemblies or init or usage_display) and destination_path = Void then
					destination_path := (create {EXECUTION_ENVIRONMENT}).current_working_directory
				end
				
				if not (list_assemblies or init or usage_display) then
					if consume_from_fullname then
						assembly := feature {ASSEMBLY}.load_string (target_path.to_cil)
					else
						assembly := feature {ASSEMBLY}.load_from (target_path.to_cil)
					end
				end
			else
				set_error (Invalid_target_path, target_path)
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
			io.put_string (" <assembly> [/g] [/a | /r] [/n] [/nologo] [/nice]%N")
			io.put_string ("       " + System_name)
			io.put_string (" <assembly> [/g] [/d:destination] [/n] [/nologo] [/nice] [/f | /noref]%N")
			io.put_string ("       " + System_name)
			io.put_string (" /l [/nologo]%N")
			io.put_string ("       " + System_name)
			io.put_string (" /init [/n] [/nologo] [/nice]%N%N")
			io.put_string (" - Options -%N%N")
			io.put_string ("/fullname%N   Consume an assembly using its fullname. Short form is '/fn'.%N%N")
			io.put_string ("/dest:destination%N   Generate XML in directory 'destination'. Short form is '/d'.%N%N")
			io.put_string ("/add%N   Put assembly in Eiffel Assembly Cache. Short form is '/a'.%N%N")
			io.put_string ("/remove%N   Remove assembly from Eiffel Assembly Cache. Short form is '/r'.%N%N")
			io.put_string ("/nooutput%N   Prevent progress information display. Short form is '/n'.%N%N")
			io.put_string ("/nologo%N   Prevent display of copyright notice.%N%N")
			io.put_string ("/init%N   Initialize Eiffel Assembly Cache (can only be run once).%N%N")
			io.put_string ("/list%N   List assemblies in EAC. Short form is '/l'.%N%N")
			io.put_string ("/nice%N   XML output is indented.%N%N")
			io.put_string ("/force%N   Consume a local assembly's GAC dependancies into same location. Short form is '/f'.%N%N")
			io.put_string ("/noref%N   Do not generated assembly dependancies..%N%N")
			io.put_string (" - Arguments -%N%N")
			io.put_string ("<assembly>%N   Name of assembly containing types to generate XML for. <assembly> can%N")
			io.put_string ("   be either a path to a local assembly or an assembly's fully quantified name ONLY when '/fn' is used%N")
			io.put_string ("   e.g. - %"System.Xml, Version=1.0.3300.0, Culture=neutral, PublicKeyToken=b77a5c561934e089%".%N%N")
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
			writer: CACHE_WRITER
		do
			if ass/= Void then
				create writer
				if not no_output then
					display_status ("Consuming " + create {STRING}.make_from_cil (ass.get_name.full_name))
					writer.set_status_printer (agent display_status)
				end
				writer.set_error_printer (agent process_error)
				writer.add_assembly (ass.get_name)
				
				consumed_assemblies.extend (create {STRING}.make_from_cil (ass.full_name))
			end
		end
		
	consume_into_path (ass: ASSEMBLY) is
			-- Consume 'ass' and place in the destination path specified in the command line
		require
			non_void_assembly: ass /= Void
			non_void_destination: destination_path /= Void
			non_void_consumed_assemblies: consumed_assemblies /= Void
		local
			output_destination_path: STRING
			references: NATIVE_ARRAY [ASSEMBLY_NAME]
			n: INTEGER
			name: ASSEMBLY_NAME
			assembly: ASSEMBLY
			consume_folder: DIRECTORY			
			reconsume: BOOLEAN
			
			local_info: LOCAL_CACHE_INFO
			des: EIFFEL_XML_DESERIALIZER
			local_info_path: STRING
		do
			reconsume := True
			local_info_path := destination_path.clone (destination_path)
			if local_info_path.item (local_info_path.count) /= '\' then
				local_info_path.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			end
			local_info_path.append (info_path)
			
			output_destination_path := destination_path.clone (destination_path)
			if output_destination_path.item (output_destination_path.count) /= '\' then
				output_destination_path.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			end
			output_destination_path.append (relative_assembly_path (ass.get_name))
		
			if not no_output then
				display_status ("Consuming " + create {STRING}.make_from_cil (ass.get_name.full_name))
			end
			
			-- only consume the assembly if it needs to be consumed
			if assembly_consumer.is_assembly_modified (ass, output_destination_path) then
				create des
				des.deserialize (local_info_path)
				if des.successful then
					local_info ?= des.deserialized_object
				end
				
				create consume_folder.make (output_destination_path.substring (1, output_destination_path.count - 1))
				if consume_folder.exists then
					consume_folder.recursive_delete					
				end
				
				assembly_consumer.set_destination_path (output_destination_path)				
				assembly_consumer.consume (ass)
				if local_info = Void then
					create local_info.make (destination_path)					
				end
				local_info.add_assembly (Assembly_consumer.Consumed_assembly_factory.consumed_assembly (ass))

				(create {EIFFEL_XML_SERIALIZER}).serialize (local_info, local_info_path)
			else
				if not no_output then
					display_status ("Up-to-date check: '" + create {STRING}.make_from_cil (ass.get_name.full_name) + "' has not been modified since last consumption.%N")
				end
			end
			
			consumed_assemblies.extend (create {STRING}.make_from_cil (ass.full_name))
			
			if not no_dependancies then
				references := ass.get_referenced_assemblies			
				if references /= Void then
					from 
						n := references.lower
					until
						n > references.upper
					loop
						name := references.item (n)
						
						-- do not consume mscorlib, as it isnt loaded from the GAC but from the %SystemRoot%\Microsoft.Net\Framework\<version>\ directory.
						if not name.name.equals (("mscorlib").to_cil) then
							assembly := feature {ASSEMBLY}.load_assembly_name (name)
							if assembly /= Void then
								if not consumed_assemblies.has (create {STRING}.make_from_cil (assembly.full_name)) then
									if assembly.global_assembly_cache and not force_local_generation then
										consume_in_eac (assembly)
									else
										consume_into_path (assembly)
									end
								end
							else
								set_error (Invalid_assembly, create {STRING}.make_from_cil (name.full_name))
							end
						end
						n := n + 1
					end	
				end
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
				writer.remove_assembly (ass.get_name)
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
	
	target_path: STRING
			-- Path to target assembly

	destination_path: STRING
			-- Path where to generate XML

	System_name: STRING is "emitter"
			-- Name of executable

	Version: STRING is "2.0"

	initial_assemblies: ARRAY [STRING] is
			-- Assemblies that will be imported when EAC is initialized
--		local
--			il_env: IL_ENVIRONMENT
		once
--			create il_env
--			Result := <<il_env.dotnet_framework_path + "mscorlib.dll">>
			if (create {RAW_FILE}.make ("C:\WINDOWS\Microsoft.NET\Framework\v1.0.3705\mscorlib.dll")).exists then
				Result := <<"C:\WINDOWS\Microsoft.NET\Framework\v1.0.3705\mscorlib.dll">>
			else
				Result := <<"C:\WINNT\Microsoft.NET\Framework\v1.0.3705\mscorlib.dll">>				
			end
		end
		
	dummy: CACHE_REFLECTION
	consumed_assemblies: LINKED_LIST [STRING]
	
end -- class EMITTER
