indexing
	description: "Ace file generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ACE_FILE_GENERATOR

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
			{ANY} client
			{ANY} server
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_FILE_NAMES
		export
			{NONE} all
		end

feature -- Access

	Partial_ace_file: STRING is
			-- Ace file used to precompile generated Eiffel system
		"root%N%
		%	ANY%N%N%
		%default%N%
		%	assertion (all)%N%
		%	multithreaded (no)%N%
		%	console_application (no)%N%
		%	dynamic_runtime (no)%N%
		%	dead_code_removal (yes)%N%
		%	profile (no)%N%
		%	line_generation (no)%N%
		%	debug  (no)%N%
		%	array_optimization (no)%N%
		%	inlining (no)%N%
		%	inlining_size (%"4%")%N%  
		%cluster%N%
		%	all client: %""

	Partial_ace_file_addition: STRING is 	"	all server: %""
			-- Add Server cluster.
		
	Partial_ace_file_part_two: STRING is
			-- Ace file used to precompile generated Eiffel system
		do
			create Result.make (10000)
			from
				Standard_clusters.start
			until
				Standard_clusters.after
			loop
				Result.append (Standard_clusters.item)
				Standard_clusters.forth
			end
			Result.append (
					"external%N%
					%	include_path:	%"$ISE_EIFFEL\library\wel\spec\windows\include%",%N%
					%			%"$ISE_EIFFEL\library\com\spec\windows\include%",%N")
		end

	End_ace_file: STRING is
			-- End of ace file used to precompile generated Eiffel system
		"	object: 	%"$(ISE_EIFFEL)\library\wel\spec\$(ISE_C_COMPILER)\lib\wel.lib%",%N%
		%			%"$(ISE_EIFFEL)\library\com\spec\$(ISE_C_COMPILER)\lib\com.lib%",%N%
		%			%"$(ISE_EIFFEL)\library\com\spec\$(ISE_C_COMPILER)\lib\com_runtime.lib%",%N"


	Visible: STRING is "visible"
			-- Lace `visible' keyword

	clusters_from_project: STRING is
			-- Clusters code from project Ace file
		local
			input_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
			str_buffer: STRING
			l_clusters: LIST [STRING]
			l_cluster: STRING
		do
			if l_retried then
				Result := ""
			else
				create original_cluster_info.make
				create Result.make (10000)

				create input_file.make_open_read (environment.ace_file_name)

				original_cluster_info.input_from_file (input_file)

				insert_visible_class

				l_clusters := original_cluster_info.clusters
				from
					l_clusters.start
				until
					l_clusters.after
				loop
					l_cluster := l_clusters.item
					if l_cluster.substring_index ("%".%"", 1) > 0 then
						str_buffer := environment.eiffel_project_name.twin
						str_buffer.keep_head (str_buffer.last_index_of ('\', str_buffer.count) - 1)
						str_buffer.prepend ("%"")
						str_buffer.append ("%"")
						l_cluster.replace_substring_all ("%".%"", str_buffer)		
					end
					Result.append (l_cluster)

					Result.append ("%N%T%T")
					l_clusters.forth
				end
			end
		rescue
			l_retried := True
			retry
		end

	Common_cluster: STRING is "all common"
			-- Common cluster

	original_cluster_info: EI_CLUSTER_DATA_INPUT
			-- Cluster information

	Ace_file_name: STRING is "Ace.ace"
			-- Ace file name

	ace_file_generated: BOOLEAN
			-- Was generated project ace file generated?

	Standard_clusters: LIST [STRING] is
			-- Standard clusters.
		once
			create {ARRAYED_LIST [STRING]} Result.make (4)
			Result.extend (
					"	-- BASE%N%
					%	all base:						%"$ISE_EIFFEL\library\base%"%N%
					%		exclude%N%
					%			%"table_eiffel3%";%N%
					%			%"desc%"%N%
					%		visible%N%
					%			INTEGER_REF;%N%
					%			CHARACTER_REF;%N%
					%			BOOLEAN_REF;%N%
					%			REAL_REF;%N%
					%			DOUBLE_REF;%N%
					%			CELL;%N%
					%			STRING;%N%
					%			ARRAY;%N%
					%		end;%N%N")

			Result.extend (
					"	-- WEL%N%
					%	all wel:						%"$ISE_EIFFEL\library\wel%"%N%N")

			Result.extend (
					"	-- TIME%N%
					%	all time: 						%"$ISE_EIFFEL\library\time%"%N%
					%		exclude%N%
					%			%"french%";%N%
					%			%"german%"%N%
					%		visible%N%
					%			DATE_TIME;%N%
					%		end;%N%N")

			Result.extend (
					"	-- COM%N%
					%	all ecom:						%"$ISE_EIFFEL\library\com%"%N%
					%		visible%N%
					%			ECOM_DECIMAL;%N%
					%			ECOM_CURRENCY;%N%
					%			ECOM_ARRAY;%N%
					%			ECOM_VARIANT;%N%
					%			ECOM_GUID;%N%
					%			ECOM_EXCEP_INFO;%N%
					%			ECOM_DISP_PARAMS;%N%
					%			ECOM_STATSTG;%N%
					%			ECOM_STREAM;%N%
					%			ECOM_STORAGE;%N%
					%			ECOM_ROOT_STORAGE;%N%
					%			ECOM_ENUM_STATSTG;%N%
					%			ECOM_HRESULT;%N%
					%			ECOM_WIDE_STRING;%N%
					%			ECOM_LARGE_INTEGER;%N%
					%			ECOM_ULARGE_INTEGER;%N%
					%			ECOM_UNKNOWN_INTERFACE;%N%
					%			ECOM_AUTOMATION_INTERFACE;%N%
					%			ECOM_STUB;%N%
					%			ECOM_QUERIABLE;%N%
					%		end;%N%N")

		end

	Default_keyword: STRING is "default"
			-- Lace `default' keyword
	
	Shared_library_option: STRING is
			-- Dll definition file for Ace file
		do
			create Result.make (1000)
			Result.append ("default%N%Tshared_library_definition (%"")
			Result.append (User_def_file_name)
			Result.append ("%")")
		end

	user_def_file_name: STRING is
			-- ".def" file name used for DLL compilation
		do
			create Result.make (100)
			Result.append (environment.project_name)
			Result.append (Def_file_extension)
		end
	
	Def_file_extension: STRING is ".def"
			-- DLL definition file extension

feature -- Basic operations

	generate (a_folder: STRING) is
			-- Generate server ace file in `a_folder'.
			-- Delete EIFGEN is already existing.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.is_equal (Client) or a_folder.is_equal (Server)
		local
			a_file: RAW_FILE
			a_file_name, a_string: STRING
		do
			create a_string.make (10000)
			if a_folder.is_equal (Server) then
				a_string.append (server_generated_ace_file)
			else
				a_string.append (client_generated_ace_file)
			end
			
			a_string.append (ecom_lib_location (Client))
			a_string.append (ecom_lib_location (Server))
			a_string.remove (a_string.count)
			a_string.append (Semicolon)
			a_string.append (New_line)
			a_string.append (End_keyword)

			create a_file_name.make (100)
			a_file_name.append (environment.destination_folder)
			a_file_name.append (a_folder)
			a_file_name.append_character (Directory_separator)
			a_file_name.append (Ace_file_name)
			create a_file.make_create_read_write (a_file_name)

			a_file.put_string (a_string)
			a_file.close
			ace_file_generated := True
		end

	ecom_lib_location (a_folder: STRING): STRING is
			-- Location of ecom.lib
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.is_equal (Client) or a_folder.is_equal (Server)
		do
			create Result.make (100)
			if not is_empty_clib_folder (a_folder) then
				Result.append (New_line_tab_tab_tab)
				Result.append (Double_quote)
				Result.append (environment.destination_folder)
				Result.append (a_folder)
				Result.append_character (Directory_separator)
				Result.append (Clib)
				Result.append_character (Directory_separator)
				Result.append ("$(ISE_C_COMPILER)")
				Result.append_character (Directory_separator)
				Result.append (Clib_name)
				Result.append (Lib_file_extension)
				Result.append (Double_quote)
				Result.append (Comma)
			end			
		ensure
			non_void_result: Result /= Void
			valid_result: not is_empty_clib_folder (a_folder) implies not Result.is_empty
		end
		
	is_empty_clib_folder (a_folder: STRING): BOOLEAN is
			-- Is folder `a_folder' is_empty?
		local
			a_directory: DIRECTORY
			a_working_directory: STRING
		do
			a_working_directory := environment.destination_folder.twin
			a_working_directory.append (a_folder)
			a_working_directory.append_character (Directory_separator)
			a_working_directory.append (Clib)
			create a_directory.make_open_read (a_working_directory)

			Result := a_directory.is_empty
		end

	server_generated_ace_file: STRING is
			-- Beginning of server generated Ace file
		local
			l_string: STRING
			l_index: INTEGER
		do
			Result := client_generated_ace_file			
			create l_string.make (1000)
			l_string.append (Registration_class_name)
			l_string.append (": %"make%"")
			if not system_descriptor.coclasses.is_empty then
				l_index := Result.substring_index ("ANY", 1)
				check
					has_any: l_index > 0
				end
				Result.replace_substring (l_string, l_index, l_index + 2)
				if environment.is_in_process then
					l_index := Result.substring_index ("default", 1)
					check
						has_default: l_index > 0
					end
					Result.replace_substring (Shared_library_option, l_index, l_index + 6)
				end
			end
		end

	client_generated_ace_file: STRING is
			-- Common part in Ace file for both server and client.
		local
			l_classes: LIST [WIZARD_WRITER_VISIBLE_CLAUSE]
			l_path: LIST [STRING]
		do
			create Result.make (10000)
			Result.append ("system%N%T%"")
			Result.append (environment.project_name)
			if environment.is_client then
				Result.append ("_client")
			end
			Result.append ("%"%N")
			Result.append (Partial_ace_file)
			Result.append (environment.destination_folder)
			Result.append ("Client%"%N%T%Tvisible%N")

			l_classes := system_descriptor.visible_classes_client
			from
				l_classes.start
			until
				l_classes.after
			loop
				Result.append (l_classes.item.generated_code)
				l_classes.forth
			end
			Result.append ("%N%T%Tend%N%Tall server: %"")
			Result.append (environment.destination_folder)
			Result.append ("Server%"%N%T%Tvisible%N%T%T%T")

			if not environment.is_client and not system_descriptor.coclasses.is_empty then
				Result.append (Registration_class_name)
				Result.append (";%N")
			end
			
			l_classes := system_descriptor.visible_classes_server
			from
				l_classes.start
			until
				l_classes.after
			loop
				Result.append (l_classes.item.generated_code)
				l_classes.forth
			end
			Result.append ("%N%T%Tend")

			if environment.is_eiffel_interface then
				Result.append ("%N%N%T")
				Result.append (clusters_from_project)
			end
			
			Result.append ("%N%N%Tall common:%T%T%T%T%T%T%"")
			Result.append (environment.destination_folder)
			Result.append ("Common%"%N%T%Tvisible%N%T%T%T")

			l_classes := system_descriptor.visible_classes_common
			from
				l_classes.start
			until
				l_classes.after
			loop
				Result.append (l_classes.item.generated_code)
				l_classes.forth
			end
			Result.append ("%N%T%Tend%N%N%N")
			Result.append (Partial_ace_file_part_two)
			Result.append ("%T%T%T")

			if original_cluster_info /= Void then
				l_path := original_cluster_info.include_path
				from
					l_path.start
				until
					l_path.after
				loop
					if not l_path.item.is_empty then
						Result.append (l_path.item)
						Result.append ("%N%T%T%T")
					end
					l_path.forth
				end
			end

			Result.append ("%"")
			Result.append (environment.destination_folder)
			Result.append ("Client")
			Result.append_character (Directory_separator)
			Result.append ("Include%",%N%T%T%T%"")
			Result.append (environment.destination_folder)
			Result.append ("Server")
			Result.append_character (Directory_separator)
			Result.append ("Include%",%N%T%T%T%"")
			Result.append (environment.destination_folder)
			Result.append ("Common")
			Result.append_character (Directory_separator)
			Result.append ("Include%";%N%N")
			Result.append (End_ace_file)

			if original_cluster_info /= Void then
				l_path := original_cluster_info.objects
				from
					l_path.start
				until
					l_path.after
				loop
					if not l_path.item.is_empty then
						Result.append ("%N%T%T%T")
						Result.append (l_path.item)
					end
					original_cluster_info.objects.forth
				end
			end
			Result.append ("%N")
		end

	if_class_cluster_insert_visible (a_cluster: STRING) is
			-- If `a_cluster' is `class_cluster_name' from WIZARD_ENVIRONMENT then
			-- insert into visible clause `eiffel_class_name'
		require
			non_void_cluster: a_cluster /= Void
			valid_cluster: not a_cluster.is_empty
		local
			l_cluster_name_index, l_colon_index, l_class_index, l_class_index_before, l_class_index_after: INTEGER
		do
			l_cluster_name_index := a_cluster.substring_index (environment.class_cluster_name, 1)
			l_colon_index := a_cluster.index_of (':', 1)
			if  (l_cluster_name_index> 0) and (l_cluster_name_index < l_colon_index) then
				if (a_cluster.substring_index ("visible", 1) > 0) then
					l_class_index := a_cluster.substring_index (environment.eiffel_class_name, 1)
					l_class_index_before := l_class_index - 1
					l_class_index_after := l_class_index + environment.eiffel_class_name.count
					if (l_class_index = 0) or else not
							(((a_cluster.item (l_class_index_before) = ' ' ) or 
							(a_cluster.item (l_class_index_before) = '%T')) and
							((a_cluster.item (l_class_index_after) = ' ') or 
							(a_cluster.item (l_class_index_after) = ';') or
							(a_cluster.item (l_class_index_after) = '%N'))) then
						a_cluster.insert_string ("%N%T%T%T" + environment.eiffel_class_name+ ";",
							a_cluster.substring_index ("visible", 1) + 7)
					end
				else
					a_cluster.prune (';')
					if a_cluster.substring_index ("end", 1) >= a_cluster.count - 3 then
						a_cluster.keep_head (a_cluster.substring_index ("end", 1) - 1)
					end
					a_cluster.append (
						"%N%T%Tvisible%N%
						%%T%T%T" + environment.eiffel_class_name + ";%N%
						%%T%Tend")
				end
			end
		end

	insert_visible_class is
			-- Insert visible clause into correct cluster.
		require
			non_void_cluster_info: original_cluster_info /= Void
			non_void_clusters: original_cluster_info.clusters /= Void
		do
			from
				standard_clusters.start
			until
				standard_clusters.after
			loop
				if_class_cluster_insert_visible (standard_clusters.item)
				standard_clusters.forth
			end

			from
				original_cluster_info.clusters.start
			until
				original_cluster_info.clusters.after
			loop
				if_class_cluster_insert_visible (original_cluster_info.clusters.item)
				original_cluster_info.clusters.forth
			end
		end

end -- class WIZARD_ACE_FILE_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
