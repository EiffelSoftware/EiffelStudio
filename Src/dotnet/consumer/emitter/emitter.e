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
							Remove_short, Nice_switch>>)
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
				ass := feature {ASSEMBLY}.load_from (target_path.to_cil)
				if not cr.is_initialized then
					set_error (Eac_not_initialized, Void)
				elseif ass = Void then
					set_error (Invalid_assembly, Void)
				elseif put_in_eac and ass.get_name.get_public_key_token = Void then
					set_error (Non_signed_assembly, Void)
				end
				if successful then
					if put_in_eac then
						consume_in_eac (ass)						
					elseif remove then
						remove_from_eac (ass)
					else
						assembly_consumer.consume (ass)
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
					destination_path := switch_value
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
			end
		end

	process_non_switch (non_switch_value: STRING) is
		do
			if (create {RAW_FILE}.make (non_switch_value)).exists then
				target_path := non_switch_value
			else
				set_error (Invalid_target_path, non_switch_value)
			end
		end

	post_process is
			-- Post argument parsing processing.
		do
			if not (list_assemblies or init or usage_display) and target_path = Void then
				set_error (No_target, Void)
			elseif put_in_eac and destination_path /= Void then
				set_error (No_destination_if_put_in_eac, Void)
			elseif not (list_assemblies or init or usage_display) and destination_path = Void then
				destination_path := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			end
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
			io.put_string (" <assembly>.dll|.exe [/d:destination | /a | /r] [/n] [/nologo] [/nice]%N")
			io.put_string ("       " + System_name)
			io.put_string (" /l [/nologo]%N")
			io.put_string ("       " + System_name)
			io.put_string (" /init [/n] [/nologo] [/nice]%N%N")
			io.put_string (" - Options -%N%N")
			io.put_string ("/dest:destination%N   Generate XML in directory 'destination'. Short form is '/d'.%N%N")
			io.put_string ("/add%N   Put assembly in Eiffel Assembly Cache. Short form is '/a'.%N%N")
			io.put_string ("/remove%N   Remove assembly from Eiffel Assembly Cache. Short form is '/r'.%N%N")
			io.put_string ("/nooutput%N   Prevent progress information display. Short form is '/n'.%N%N")
			io.put_string ("/nologo%N   Prevent display of copyright notice.%N%N")
			io.put_string ("/init%N   Initialize Eiffel Assembly Cache (can only be run once).%N%N")
			io.put_string ("/list%N   List assemblies in EAC. Short form is '/l'.%N%N")
			io.put_string ("/nice%N   XML output is indented.%N%N")
			io.put_string (" - Arguments -%N%N")
			io.put_string ("<assembly>%N   Name of assembly containing types to generate XML for.%N%N")
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
					display_status ("Consuming " + create {STRING}.make_from_cil (ass.get_name.get_full_name))
					writer.set_status_printer (agent display_status)
				end
				writer.set_error_printer (agent process_error)
				writer.add_assembly (ass.get_name)
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
					display_status ("Removing " + create {STRING}.make_from_cil (ass.get_name.get_full_name))
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
	
end -- class EMITTER
