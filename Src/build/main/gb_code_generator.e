note
	description: "Objects that generate an Eiffel class text based on the%
		%current system built by the user."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CODE_GENERATOR

	-- We currently only support two or less project locations per ace file.

inherit

	GB_XML_UTILITIES
		export
			{NONE} all
		end

	GB_EVENT_UTILITIES
		export
			{NONE} all
		end

	INTERNAL
		export
			{NONE} all
		end

	GB_FILE_CONSTANTS
		export
			{NONE} all
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

	GB_NAMING_UTILITIES
		export
			{NONE} all
		end

	GB_GENERAL_UTILITIES
		export
			{NONE} all
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

	GB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	ANY

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS)
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			reset_generation_constants
			create read_only_files.make (5)
			default_create
		ensure
			components_set: components = a_components
		end

feature -- Basic operation

	generate_single_window (window_name: STRING)
			-- Generate code for top level object named `window_name' only.
			-- No other files are generated.
		require
			window_name_not_void: window_name /= Void
		do
			window_to_generate := window_name
			generate
			window_to_generate := Void
		end

	window_to_generate: STRING
		-- Name of window to generate if a single window is being generated,
		-- Void otherwise.

	generating_single_window: BOOLEAN
			-- Is a single window being generated?
		do
			Result := window_to_generate /= Void
		end

	generate
			-- Generate the project as per settings in `project_settings'.
		local
			directory: DIRECTORY
			root_element: XM_ELEMENT
			warning_dialog: EV_WARNING_DIALOG
			error_message: STRING_32
			window_file_name: PATH
			rescued: BOOLEAN
		do
			if not rescued then
				last_generation_successful := True

					-- Note that the generation of the XML file used internally,
					-- is not performed until `build_main_window_implementation' is called.
				create directory.make_with_path (generated_path)
					-- If the directory for the generated code does not already exist then
					-- we must create it.
				if not directory.exists then
					directory.create_dir
				end

					-- We must build an XML file representing the project, and
					-- then for every window found in that file, generate a new window.
				generate_xml_for_project

				window_counter := 0
				total_windows := components.tools.widget_selector.objects.count

					-- We only generate an ace file and an EV_APPLICATION if the user
					-- has selected to generate a complete project from the system settings.
				if project_settings.complete_project and not generating_single_window then
						-- Generate an ace file for the project.
					build_ace_file
						-- Generate an EV_APPLICATION for the project
					build_application_file
				end

				if not (generating_single_window or components.constants.all_constants.is_empty) then
					build_constants_file
					if project_settings.load_constants then
						build_constants_load_file
					end
				end

				root_element ?= current_document.first
				create class_ids.make (20)
				create class_directories.make (20)
				parse_directories (root_element, create {ARRAYED_LIST [STRING]}.make (4))
				check
					counts_consistent: class_ids.count = class_directories.count
				end

					-- Now perform generation of all classes.
				from
					class_ids.start
					class_directories.start
				until
					class_ids.off
				loop
					reset_generation_constants_for_class
					window_file_name := class_directories.item
					build_main_window_implementation (document_info.generated_info_by_id.item (class_ids.item), window_file_name)
					build_main_window (document_info.generated_info_by_id.item (class_ids.item), window_file_name)
					class_ids.forth
					class_directories.forth
				end

					-- Now display error dialog if one or more templates could not be found.
				if missing_files /= Void then
					error_message := {STRING_32} "EiffelBuild was unable to locate the following files required for generation:%N%N"
					from
						missing_files.start
					until
						missing_files.off
					loop
						error_message.append (missing_files.item.name)
						error_message.append ("%N")
						missing_files.forth
					end
					error_message := error_message + "%NCode generation has failed.%NPlease ensure that your installation of EiffelBuild has not been corrupted."
					create warning_dialog.make_with_text (error_message)
					warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
					warning_dialog.show_modal_to_window (parent_window (progress_bar))
					last_generation_successful := False
				end

					-- Now display an error dialog if one or more files could not be written.
				if not read_only_files.is_empty then
					error_message := {STRING_32} "EiffelBuild was unable to open the following files:%N%N"
					from
						read_only_files.start
					until
						read_only_files.off
					loop
						error_message.append (read_only_files.item.name)
						error_message.append ("%N")
						read_only_files.forth
					end
					error_message := error_message + "%NCode generation has been unable to complete succesfully.%NPlease check file permissions and try again."
					create warning_dialog.make_with_text (error_message)
					warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
					warning_dialog.show_modal_to_window (parent_window (progress_bar))
					last_generation_successful := False
				end
			end
		rescue
			if not directory.exists then
				create warning_dialog.make_with_text (invalid_generation_directory)
				warning_dialog.show_modal_to_window (components.tools.main_window)
				last_generation_successful := False
				rescued := True
				retry
			end
		end

	last_generation_successful: BOOLEAN
		-- Was last call to `generate' or `generate_window' successful?

	parse_directories (an_element: XM_ELEMENT; parent_directories: ARRAYED_LIST [STRING])
			-- Parse `an_element' and build windows and directories found. `parent_directories' holds
			-- the current position in the directory structure where the data for `an_element_resides'.
		require
			an_element_not_void: an_element /= Void
			parent_directories_not_void: parent_directories /= Void
		local
			current_element, window_element: XM_ELEMENT
			current_name, current_type: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			directory_name: PATH
			directory: DIRECTORY
		do
			from
				an_element.start
			until
				an_element.off
			loop
				current_element ?= an_element.item_for_iteration
				if current_element /= Void then
				current_name := current_element.name
					if current_name.same_string (Item_string) then
						current_type := current_element.attribute_by_name (type_string).value
						if current_type.same_string (directory_string) then
							from
								current_element.start
							until
								current_element.off
							loop
								window_element ?= current_element.item_for_iteration
								if window_element /= Void then
									current_name := window_element.name
									if current_name.same_string (Internal_properties_string) then
										full_information := get_unique_full_info (window_element)
										element_info := full_information @ (name_string)

										parent_directories.extend (element_info.data)
										if preferences.code_generation_data.generate_empty_directories then
											create_directory_from_path (parent_directories)
										end
									end
								end
								current_element.forth
							end
							parse_directories (current_element, parent_directories)
							parent_directories.prune_all (parent_directories.last)
						elseif current_type.same_string (Constants_string) then

						else
							reset_generation_constants_for_class
							prepass_xml (current_element, document_info, 1)
							if window_to_generate = Void or else document_info.name.as_lower.same_string (window_to_generate.as_lower) then
								directory_name := generated_path
								from
									parent_directories.start
								until
									parent_directories.off
								loop
									directory_name := directory_name.extended (parent_directories.item)
									create directory.make_with_path (directory_name)
									if not directory.exists then
										directory.create_dir
									end
									parent_directories.forth
								end
								class_ids.extend (document_info.id)
								class_directories.extend (directory_name)
							end
						end
					end

				end
				an_element.forth
			end
		end

	class_ids: ARRAYED_LIST [INTEGER]
		-- Ids of all classes that must be generated as returned by `parse_directories'.

	class_directories: ARRAYED_LIST [PATH]
		-- Directory paths for all classes that must be generated as returned by `parse_directories'.

	create_directory_from_path (a_path: ARRAYED_LIST [STRING])
			-- Create the directory corresponding to `a_path' from the root of the
			-- current project, only if it does not already exist.
		require
			a_path_not_void: a_path /= Void
		local
			directory_name: PATH
			directory: DIRECTORY
		do
			directory_name := generated_path
			from
				a_path.start
			until
				a_path.off
			loop
				directory_name := directory_name.extended (a_path.item)
				a_path.forth
			end
				-- Only create the directory if it is not empty.
			create directory.make_with_path (directory_name)
			if not directory.exists then
				directory.create_dir
			end
		end

feature {GB_CODE_GENERATION_DIALOG, GB_GENERATION_COMMAND} -- Implementation

	set_progress_bar (bar: EV_PROGRESS_BAR)
			-- Assign `bar' to `progress_bar'
		require
			progress_bar_not_void: bar /= Void
		do
			progress_bar := bar
		ensure
			progress_bar_set: progress_bar = bar
		end

feature {NONE} -- Implementation

	generate_xml_for_project
			-- Generate XML for the current project into `current_document'.
			-- This XML document will be used to generate the source code.
		local
			store: GB_XML_STORE
			generation_settings: GB_GENERATION_SETTINGS
		do
			create store.make_with_components (components)
				-- Generate an XML representation of the current project.
				-- We will build our class text directly from this XML.
			create generation_settings
			generation_settings.enable_generate_names
			store.register_object_written_agent (agent report_progress_from_store)
			store.generate_document (generation_settings)
			current_document := store.document
			check
				current_document_not_void: current_document/= Void
			end
		end

	report_progress_from_store (total, stored: INTEGER)
			-- Report progress from XML store, represented by percentage
			-- of `stored' against `total'.
		do
			set_progress (progress_switch * (stored / total).truncated_to_real)
		end

	reset_generation_constants
			-- Reset all constants and attributes required before a generation.
			-- Only called once per generation.
		do
			reset_generation_constants_for_class
		end

	reset_generation_constants_for_class
	 		-- Reset all constants required to be reset before a class generation.
			-- This will be called multiple times, once for each set of classes
			-- that is generated.
		do
			create document_info.make_root
			event_connection_string := ""
			create_string := ""
			local_string := Void
			attribute_string := Void
			build_string := ""
			set_string := ""
			event_implementation_string := ""
			event_declaration_string := ""
			Generated_names.wipe_out
			create locals.make (20)
			create exported_attributes.make (20)
			create non_exported_attributes.make (20)
		end

	generated_path: PATH
			-- `Result' is generated directory for current project.
		do
			create Result.make_from_string (components.system_status.current_project_settings.actual_generation_location)
		ensure
			result_not_void: Result /= Void
		end

	build_ace_file
			-- Generate the ace file for the project
			-- dependent in information in `system_status'.
			-- Note that For Visual Studio, we need to
			-- generate a debug and a release ace file.
		do
			generate_ace_file (ecf_file_name, ecf_name)
		end

	generate_ace_file (template_file_name: PATH; file_name: STRING)
			-- Generate a new ace file from template `template_file_name', and save it
			-- as `file_name'. `template_file_name' is full path, but `file_name' is
			-- just name of ace file.
		local
			ace_file_name: PATH
			ace_template_file, ace_output_file: PLAIN_TEXT_FILE
			l_uuid: UUID_GENERATOR
		do
			ace_template_file := open_text_file_for_read (template_file_name)
			if ace_template_file /= Void then
					-- Only perform generation if the template file was readable.
				create ace_text.make (ace_template_file.count)
				ace_template_file.start
				ace_template_file.read_stream (ace_template_file.count)
				ace_text := ace_template_file.last_string
				ace_template_file.close

					-- | FIXME
					-- This code only supports two project location tags per ace file.
					-- This should be made more general.
				ace_text.replace_substring_all (project_location_tag, generated_path.out)

				create l_uuid
				ace_text.replace_substring_all (uuid_tag, l_uuid.generate_uuid.out)

					-- Now add the project_name.
				ace_text.replace_substring_all (project_name_tag, project_settings.project_name.as_lower)

					-- Now add the application class name.
				ace_text.replace_substring_all (application_tag, project_settings.application_class_name.as_upper)

				ace_file_name := generated_path.extended (file_name)
						-- Store `ace_text'.
				create ace_output_file.make_with_path (ace_file_name)
				if not ace_output_file.exists or project_settings.rebuild_ace_file then
					if ace_output_file.exists  and not ace_output_file.is_access_writable then
						read_only_files.extend (ace_file_name)
					else
						ace_output_file.open_write
						ace_output_file.start
						ace_output_file.putstring (ace_text)
						ace_output_file.close
					end
				end
			end
		end

	build_constants_file
			-- Build class file containing all generated constants.
		local
			constants_file_name: PATH
			constants_file: PLAIN_TEXT_FILE
			constants_content: STRING
			generated_constants_string: STRING
			all_constants: STRING_TABLE [GB_CONSTANT]
			constant: GB_CONSTANT
			integer_constant: GB_INTEGER_CONSTANT
			string_constant: GB_STRING_CONSTANT
			pixmap_constant: GB_PIXMAP_CONSTANT
			directory_constant: GB_DIRECTORY_CONSTANT
			color_constant: GB_COLOR_CONSTANT
			font_constant: GB_FONT_CONSTANT
			l_string: STRING
			constant_resetting_string: STRING
		do
				--Firstly read the contents of the file.
			constants_file := open_text_file_for_read (constants_template_imp_file_name)

			if constants_file /= Void then
				constants_file.read_stream (constants_file.count)
				constants_file.close
				constants_content := constants_file.last_string

					-- Now generate string representing all constants.
				all_constants := components.constants.all_constants
				generated_constants_string := ""
				constant_resetting_string := ""
				from
					all_constants.start
				until
					all_constants.off
				loop
					constant := all_constants.item_for_iteration
					integer_constant ?= constant
					if integer_constant /= Void then
						if project_settings.load_constants then
							l_string := "integer_constant_by_name (%"" + integer_constant.name + "%")"
							if not constant_resetting_string.is_empty then
								constant_resetting_string := constant_resetting_string + indent
							end
							constant_resetting_string := constant_resetting_string + integer_constant.name + "_cell.put(" + l_string + ")"
						else
							l_string := integer_constant.value_as_string
						end
						generated_constants_string := generated_constants_string + Indent_less_two + integer_constant.name + ": INTEGER" +
							indent + "-- `Result' is INTEGER constant named `" + integer_constant.name + "'." +
							indent_less_one + "do" + indent + "Result := " + integer_constant.name + "_cell.item" + Indent_less_one + "end" + "%N" +
							indent_less_two + integer_constant.name + "_cell" + ": CELL [INTEGER]" + indent + "--`Result' is once access to a cell holding vale of `" + integer_constant.name + "'." +
							indent_less_one + "once" + indent + "create Result.put (" + l_string + ")" + indent_less_one + "end" + "%N"
					end
					string_constant ?= constant
					if string_constant /= Void then
						if project_settings.load_constants then
							l_string := "string_constant_by_name (%"" + string_constant.name + "%")"
							if not constant_resetting_string.is_empty then
								constant_resetting_string := constant_resetting_string + indent
							end
							constant_resetting_string := constant_resetting_string + string_constant.name + "_cell.put(" + l_string + ")"
						else
							l_string := "%"" + escape_special_characters (string_constant.value_as_string) + "%""
						end
						generated_constants_string := generated_constants_string + Indent_less_two + string_constant.name + ": STRING_32" +
							indent + "-- `Result' is STRING_32 constant named `" + string_constant.name + "'." +
							indent_less_one + "do" + indent + "Result := " + string_constant.name + "_cell.item" + Indent_less_one + "end" + "%N" +
							indent_less_two + string_constant.name + "_cell" + ": CELL [STRING_32]" + indent + "--`Result' is once access to a cell holding vale of `" + string_constant.name + "'." +
							indent_less_one + "once" + indent + "create Result.put (" + l_string + ")" + indent_less_one + "end" + "%N"
					end
					pixmap_constant ?= constant
					if pixmap_constant /= Void then
						if pixmap_constant.is_absolute then
							generated_constants_string := generated_constants_string + Indent_less_two + pixmap_constant.name + ": EV_PIXMAP" + Indent_less_one +
							"once" + Indent + "Result := " + pixmap_constant.name + "_cell.item" + indent_less_one + "end" + "%N" +
							indent_less_two + pixmap_constant.name + "_cell" + ": CELL [EV_PIXMAP]" + indent + "--`Result' is once access to a cell holding vale of `" + pixmap_constant.name + "'." +
							indent_less_one + "once" + indent + "create Result.put (create {EV_PIXMAP})" + Indent + "Result.item.set_with_named_file (%"" + pixmap_constant.value + "%")" + Indent_less_one + "end" + "%N"
						else
							generated_constants_string := generated_constants_string + Indent_less_two + pixmap_constant.name + ": EV_PIXMAP" +
							indent + "-- `Result' is EV_PIXMAP constant named `" + pixmap_constant.name + "'." + Indent_less_one +
							"do" + Indent + "Result := " + pixmap_constant.name + "_cell.item" + indent_less_one + "end" + "%N" +
							indent_less_two + pixmap_constant.name + "_cell" + ": CELL [EV_PIXMAP]" + indent + "--`Result' is once access to a cell holding vale of `" + pixmap_constant.name + "'." +
							Indent_less_one + "local" + indent + "a_file_name: PATH" + indent_less_one + "once" + Indent + "create Result.put (create {EV_PIXMAP})" + indent +
							"create a_file_name.make_from_string (" + pixmap_constant.directory + ")" + Indent + "a_file_name := a_file_name.extended (%"" + pixmap_constant.filename +"%")" +
							indent + "set_with_named_path (Result.item, a_file_name)" + Indent_less_one + "end" + "%N"
						end
					end
					directory_constant ?= constant
					if directory_constant/= Void then
						generated_constants_string := generated_constants_string + Indent_less_two + directory_constant.name + ": STRING" +
							indent + "-- `Result' is DIRECTORY constant named `" + directory_constant.name + "'." +
							indent_less_one + "do" + indent + "Result := " + directory_constant.name + "_cell.item" + Indent_less_one + "end" + "%N" +
							indent_less_two + directory_constant.name + "_cell" + ": CELL [STRING]" + indent + "--`Result' is once access to a cell holding vale of `" + directory_constant.name + "'." +
							indent_less_one + "once" + indent + "create Result.put (%"" + directory_constant.value_as_string + "%")" + Indent_less_one + "end" + "%N"
					end
					color_constant ?= constant
					if color_constant /= Void then
						generated_constants_string := generated_constants_string + Indent_less_two + color_constant.name + ": EV_COLOR" +
							indent + "-- `Result' is EV_COLOR constant named `" + color_constant.name + "'." +
							indent_less_one + "do" + indent + "Result := " + color_constant.name + "_cell.item" + Indent_less_one + "end" + "%N" +
							indent_less_two + color_constant.name + "_cell" + ": CELL [EV_COLOR]" + indent + "--`Result' is once access to a cell holding vale of `" + color_constant.name + "'." +
							indent_less_one + "once" + indent + "create Result.put (create {EV_COLOR}.make_with_8_bit_rgb (" + color_constant.value.red_8_bit.out + ", " + color_constant.value.green_8_bit.out + ", " + color_constant.value.blue_8_bit.out + "))" + indent_less_one + "end" + "%N"
					end
					font_constant ?= constant
					if font_constant /= Void then
							generated_constants_string := generated_constants_string + Indent_less_two + font_constant.name + ": EV_FONT" +
							indent + "-- `Result' is EV_FONT constant named `" + font_constant.name + "'." +
							indent_less_one + "do" + indent + "Result := " + font_constant.name + "_cell.item" + Indent_less_one + "end" + "%N" +
							indent_less_two + font_constant.name + "_cell" + ": CELL [EV_FONT]" + indent + "--`Result' is once access to a cell holding vale of `" + font_constant.name + "'." +
							indent_less_one + "once" +	indent + "create Result.put (create {EV_FONT})" + Indent +
							"Result.item.set_family ({EV_FONT_CONSTANTS}."

							inspect font_constant.value.family
							when {EV_FONT_CONSTANTS}.Family_screen then
								generated_constants_string.append ("Family_screen)")
							when {EV_FONT_CONSTANTS}.Family_roman then
								generated_constants_string.append ("Family_roman)")
							when {EV_FONT_CONSTANTS}.Family_sans then
								generated_constants_string.append ("Family_sans)")
							when {EV_FONT_CONSTANTS}.Family_typewriter then
								generated_constants_string.append ("Family_typewriter)")
							when {EV_FONT_CONSTANTS}.Family_modern then
								generated_constants_string.append ("Family_modern)")
							else
								check
									Invalid_value: False
								end
							end
							generated_constants_string.append (indent)
							generated_constants_string.append ("Result.item.set_weight ({EV_FONT_CONSTANTS}.")

							inspect font_constant.value.weight
							when {EV_FONT_CONSTANTS}.weight_thin then
								generated_constants_string.append ("Weight_thin)")
							when {EV_FONT_CONSTANTS}.weight_regular then
								generated_constants_string.append ("Weight_regular)")
							when {EV_FONT_CONSTANTS}.weight_bold then
								generated_constants_string.append ("Weight_bold)")
							when {EV_FONT_CONSTANTS}.weight_black then
								generated_constants_string.append ("Weight_black)")
							else
								check
									Invalid_value: False
								end
							end
							generated_constants_string.append (indent)
							generated_constants_string.append ("Result.item.set_shape ({EV_FONT_CONSTANTS}.")
							inspect font_constant.value.shape

							when {EV_FONT_CONSTANTS}.shape_regular then
								generated_constants_string.append ("Shape_regular)")
							when {EV_FONT_CONSTANTS}.shape_italic then
								generated_constants_string.append ("Shape_italic)")
							else
								check
									Invalid_value: False
								end
							end
							generated_constants_string := generated_constants_string + Indent + "Result.item.set_height_in_points (" + font_constant.value.height_in_points.out + ")"
							if not font_constant.value.preferred_families.is_empty then
								generated_constants_string := generated_constants_string + Indent + "Result.item.preferred_families.extend (%"" + font_constant.value.preferred_families.i_th (1) + "%")"
							end
							generated_constants_string := generated_constants_string + Indent_less_one + "end" + "%N"
					end
					all_constants.forth
				end

					-- First replace the name of the class.
				Constants_content.replace_substring_all (class_name_tag, project_settings.constants_class_name.as_upper + Class_implementation_extension)

				add_generated_string (constants_content, generated_constants_string, constants_tag)

				add_generated_string (constants_content, constant_resetting_string, constant_resetting_tag)

					-- Now write the new constants file to disk.
				constants_file_name := generated_path.extended (project_settings.constants_class_name.as_lower + Class_implementation_extension.as_lower + ".e")
				create constants_file.make_with_path (constants_file_name)

				if constants_file.exists and not constants_file.is_access_writable then
					read_only_files.extend (constants_file_name)
				else
					constants_file.create_read_write
					constants_file.start
					constants_file.putstring (constants_content)
					constants_file.close
				end

						-- Now generate the interface class name for constants.

						--Firstly read the contents of the file.
				constants_file := open_text_file_for_read (constants_template_file_name)

				if constants_file /= Void then
					constants_file.read_stream (constants_file.count)
					constants_file.close
					constants_content := constants_file.last_string

					Constants_content.replace_substring_all (class_name_tag, project_settings.constants_class_name.as_upper)
					Constants_content.replace_substring_all (Inherited_class_name_tag, project_settings.constants_class_name.as_upper + Class_implementation_extension)


						-- Now write the new constants file to disk.
					constants_file_name := generated_path.extended (project_settings.constants_class_name.as_lower + ".e")
					create constants_file.make_with_path (constants_file_name)
					if not constants_file.exists then
						constants_file.open_write
						constants_file.start
						constants_file.putstring (constants_content)
						constants_file.close
					end
				end
			end
		end


	build_constants_load_file
			-- Build text file containing constants to be loaded.
		local
			constants_file_name: PATH
			constants_file: PLAIN_TEXT_FILE
			generated_constants_string: STRING
			all_constants: STRING_TABLE [GB_CONSTANT]
			constant: GB_CONSTANT
			integer_constant: GB_INTEGER_CONSTANT
			string_constant: GB_STRING_CONSTANT
		do
			all_constants := components.constants.all_constants
			generated_constants_string := " -- Constants generated by EiffelBuild%N"
			from
				all_constants.start
			until
				all_constants.off
			loop
				constant := all_constants.item_for_iteration
				integer_constant ?= constant
				if integer_constant /= Void then
					generated_constants_string := generated_constants_string + Integer_constant_type + "        " + "%"" + integer_constant.name +
					"%"        %"" + integer_constant.value_as_string + "%"%N"
				end
				string_constant ?= constant
				if string_constant /= Void then
					generated_constants_string := generated_constants_string + String_constant_type + "        " + "%"" + string_constant.name +
					"%"        %"" + string_constant.value_as_string + "%"%N"
				end
				all_constants.forth
			end
				-- Now write the new constants file to disk.
			constants_file_name := generated_path.extended ("constants.txt")
			create constants_file.make_with_path (constants_file_name)
			constants_file.open_write
			constants_file.start
			constants_file.putstring (generated_constants_string)
			constants_file.close
		end

	build_application_file
			-- Generate an application class for the project.
		local
			application_template_file, application_output_file: PLAIN_TEXT_FILE
			application_file_name, application_template: PATH
			application_class_name: STRING
			change_pos: INTEGER
		do
			application_template := application_template_file_name

			application_template_file := open_text_file_for_read (application_template)
			if application_template_file /= Void then
				create application_text.make (application_template_file.count)
				application_template_file.start
				application_template_file.read_stream (application_template_file.count)
				application_text := application_template_file.last_string
				application_template_file.close

					-- Now add the main window class type
				add_generated_string (application_text, components.object_handler.root_window_object.name.as_upper, main_window_tag)

					-- Now add the application class name. 0ne at start
					-- and one at end of file, so do this twice.
				application_class_name := project_settings.application_class_name.as_upper
				change_pos := application_text.substring_index (application_tag, 1)
				application_text.replace_substring (application_class_name, change_pos, change_pos + application_tag.count - 1)

				application_file_name := generated_path.extended (application_class_name.as_lower + eiffel_class_extension)
				create application_output_file.make_with_path (application_file_name)
				if application_output_file.exists and not application_output_file.is_access_writable then
					read_only_files.extend (application_file_name)
				else
					application_output_file.create_read_write
					application_output_file.start
					application_output_file.putstring (application_text)
					application_output_file.close
				end
			end
		end

	build_main_window_implementation (info: GB_GENERATED_INFO; directory_name: PATH)
			-- Generate a main window for the project.
		require
			info_not_void: info /= Void
			info_named: info.name /= Void
			directory_name_not_void: directory_name /= Void
		local
			window_template_file, window_output_file: PLAIN_TEXT_FILE
			window_template, file_name: PATH
			a_class_name, temp_string: STRING
		do
			window_counter := window_counter + 1
			set_progress ((progress_switch + ((1 - progress_switch) * (window_counter / total_windows).truncated_to_real)).min (1))
				-- Build the file name for generation
			a_class_name := info.name.as_upper + Class_implementation_extension
			file_name := directory_name.extended (a_class_name.as_lower + ".e")

				-- Retrieve the template for a class file to generate.
			window_template := window_template_imp_file_name

			window_template_file := open_text_file_for_read (window_template)
			if window_template_file /= Void then
				create class_text.make (window_template_file.count)
				window_template_file.start
				window_template_file.read_stream (window_template_file.count)
				class_text := window_template_file.last_string
				window_template_file.close

					-- Now that we have loaded the class file template, we must
					-- replace all instances of EV_TITLED_WINDOW with EV_DIALOG
					-- if we are generating a dialog.
				if info.type.same_string ("EV_DIALOG") then
					class_text.replace_substring_all ("EV_TITLED_WINDOW", "EV_DIALOG")
				end

					-- We must now perform the generation into `class_text'.
					-- First replace the name of the class
				set_class_name (a_class_name)

					-- Add code which implements `show' if necessary, when using EV_WINDOW
					-- as client. Also export `initialize' as necessary. If client, then it
					-- must be exported to {ANY}.
				if info.generate_as_client then
					if info.type.same_string (ev_titled_window_string) or info.type.same_string (ev_dialog_string) then
						add_generated_string (class_text, "%Nfeature -- Basic operation%N" + show_window_feature, custom_feature_tag)
					elseif info.type.substring_index ("ITEM", 1) = 0 then
						add_generated_string (class_text, "%Nfeature -- Basic operation%N" + show_widget_feature, custom_feature_tag)
					else
						add_generated_string (class_text, Void, custom_feature_tag)
					end
				else
					add_generated_string (class_text, Void, custom_feature_tag)
				end

					-- Generate the widget declarations and creation lines.
				generate_declarations (info)

					-- Create storage for all generated feature names.
				create all_generated_events.make (0)
				all_generated_events.compare_objects

					-- Generate the widget building code.
				generate_structure (info)

					-- Generate the widget setting code.
				generate_setting (info)

					-- Generate the event code.
				generate_events (info)


					-- Now we must check the status of the prepass, and remove the
					-- "internal_pixmap" and `"internal_font" which is in the template,
					-- if they are not necessary
				if info.fonts_set.is_empty then
					remove_line_containing ("internal_font", class_text)
				end
				if info.pixmaps_set.is_empty then
					remove_line_containing ("internal_pixmap", class_text)
					remove_line_containing ("internal_pixmap", class_text)
				end

					-- Now remove the local declaration if necessary.
				process_locals

				if info.fonts_set.is_empty and info.pixmaps_set.is_empty and
				local_string = Void then
					remove_line_containing (local_tag, class_text)
				end

				if local_string = Void and (not info.fonts_set.is_empty
					or not info.pixmaps_set.is_empty) then
					add_generated_string (class_text, "local", local_tag)
				end

					-- Add code for widget attribute settings to `class_text'.
				add_generated_string (class_text, set_string, set_tag)

				if local_string /= Void then
					add_generated_string (class_text, local_string, local_tag)
				end
				if attribute_string /= Void then
					add_generated_string (class_text, attribute_string, attribute_tag)
				else
					class_text.replace_substring_all (attribute_tag + "%N", "")
				end

					-- Add code for inheritance structure to `class_text'.
				if info.generate_as_client then
					if components.constants.all_constants.is_empty then
							-- Do not inherit from the constants class if there are no constants.
						temp_string := "feature -- Access%N" + indent_less_two
					else
						temp_string := "inherit" + Indent_less_two + project_settings.constants_class_name.as_upper + "%N%Nfeature -- Access%N" + indent_less_two
					end
					if info.type.same_string (ev_titled_window_string) or info.type.same_string (ev_dialog_string) then
						temp_string.append (client_window_string)
					else
						temp_string.append (client_widget_string)
					end
					temp_string.append (": ")
					temp_string.append (info.type)
					temp_string.append (indent_less_one + "-- `Result' is widget with which `Current' is implemented")

--| FIXME check this is really no longer needed and update code generation accordingly.						
--			-- String used to define window when we are a client of window.
--		once
--			Result := "inherit" + Indent_less_two + "CONSTANTS%N%Nfeature -- Access%N" + indent_less_two +
--			"window: " + Ev_titled_window_string + indent_less_one + "-- `Result' is window with which `Current' is implemented"
--		end
--						if document_info.type.is_equal (ev_titled_window_string) or document_info.type.is_equal (ev_dialog_string) then
--							temp_string := window_access.twin
--						else
--							temp_string := widget_access.twin
--						end
--						if not document_info.type.is_equal (Ev_titled_window_string)  then
--								-- Ensure that the inheritance references the correct type.
--							temp_string := Window_access_as_dialog_part1.twin + project_settings.constants_class_name.as_upper + Window_access_as_dialog_part2.twin
--							temp_string.replace_substring_all (Ev_titled_window_string, document_info.type)
--								-- Replace "window" from `window_access' with "dialog" only in comment.
--								--| FIXME This is a hack and should probably be improved as the code generation
--								--| is developed.
--						end
					add_generated_string (class_text, temp_string,  inheritance_tag)
				else
					if components.constants.all_constants.is_empty then
							-- As there are no constants, we do not generate the inheritence from the constants class.
						temp_string := window_inheritance_no_constant.twin
					else
						temp_string := Window_inheritance_part1.twin + project_settings.constants_class_name.as_upper + Window_inheritance_part2.twin
					end
					if not info.type.same_string (Ev_titled_window_string)  then
						temp_string.replace_substring_all (Ev_titled_window_string, info.type)
					end
					add_generated_string (class_text, temp_string, inheritance_tag)
				end

					-- Add code for Precursor call in `intialize'.

				if info.generate_as_client then
					if components.constants.all_constants.is_empty then
						remove_line_containing (precursor_tag, class_text)
					else
						add_generated_string (class_text, "initialize_constants", precursor_tag)
					end
				else
					if components.constants.all_constants.is_empty then
						add_generated_string (class_text, "Precursor {" + info.type + "}", precursor_tag)
					else
						add_generated_string (class_text, "Precursor {" + info.type + "}" + Indent + "initialize_constants", precursor_tag)
					end
				end

					-- Add code for creation of widgets to `class_text'.
				add_generated_string (class_text, create_string, create_tag)

					-- Add code for construction of widget hierarchy to `class_text'.
				add_generated_string (class_text, build_string, build_tag)

					-- Add code connecting events to features to `class_text'.
				add_generated_string (class_text, event_connection_string, event_connection_tag)

					-- Add declaration of features as deferred to `class_text'.
				add_generated_string (class_text, event_declaration_string, event_declaration_tag)

					-- Tidy up `document_info' ready for next generation.
				document_info.reset_after_generation

					-- Store `class_text'.				
				create window_output_file.make_with_path (file_name)
				if window_output_file.exists and not window_output_file.is_access_writable then
					read_only_files.extend (file_name)
				else
					window_output_file.create_read_write
					window_output_file.start
					window_output_file.putstring (class_text)
					window_output_file.close
				end
			end
		end

	build_main_window (info: GB_GENERATED_INFO; directory_name: PATH)
			-- Generate interface of our window.
		require
			info_not_void: info /= Void
			info_named: info.name /= Void
		local
			window_template_file, window_output_file: PLAIN_TEXT_FILE
			file_name, window_template: PATH
			temp_string, a_class_name: STRING
		do
			a_class_name := info.name.as_upper
			file_name := directory_name.extended (a_class_name.as_lower + ".e")
			window_template := window_template_file_name
			window_template_file := open_text_file_for_read (window_template)

			if window_template_file /= Void then
				create class_text.make (window_template_file.count)
				window_template_file.start
				window_template_file.read_stream (window_template_file.count)
				class_text := window_template_file.last_string
				window_template_file.close

					-- Now that we have loaded the class file template, we must
					-- replace all instances of EV_TITLED_WINDOW with EV_DIALOG
					-- if we are generating a dialog.
				if info.type.same_string ("EV_DIALOG") then
					class_text.replace_substring_all ("EV_TITLED_WINDOW", "EV_DIALOG")
				end

					-- We must now perform the generation into `class_text'.
					-- First replace the name of the class
				set_class_name (a_class_name)

				temp_string := a_class_name + Class_implementation_extension
				if info.generate_as_client then
						-- Add redefinition of `default_create' if we are client.
					temp_string := temp_string + default_create_redefinition
				end
					-- Generate the inheritance from the window implementation.
				set_inherited_class_name (temp_string)

				if info.generate_as_client then
						-- There are different sets of setting code for windows and dialogs, or widgets.
					if info.type.same_string (ev_titled_window_string) or info.type.same_string (ev_dialog_string) then
						temp_string := redefined_window_creation
					else
						temp_string := redefined_creation
					end
				else
					temp_string := Void
				end
				add_generated_string (class_text, temp_string, creation_tag)

				add_generated_string (class_text, event_implementation_string, event_declaration_tag)

					-- Store `class_text'.				
				create window_output_file.make_with_path (file_name)
				if not window_output_file.exists then
					window_output_file.open_write
					window_output_file.start
					window_output_file.putstring (class_text)
					window_output_file.close
				end
			end
		end

	add_generated_string (a_class_text, new, tag: STRING)
			-- Replace `tag' in `class_text' with `new'.
			-- If `new' is Void then add "".
		require
			strings_not_void: a_class_text /= Void and tag /= Void
			tag_contained: a_class_text.has_substring (tag)
		local
			temp_index: INTEGER
		do
			if new /= Void and not new.is_empty then
				temp_index := a_class_text.substring_index (tag, 1)
				a_class_text.replace_substring_all (tag, "")
				a_class_text.insert_string (new, temp_index)
			else
				temp_index := a_class_text.substring_index (tag, 1)
				a_class_text.replace_substring_all (tag, "")
					-- Prune the "%N" following the tag, as we do not want
					-- a new line added anymore.
					-- FIXME remove all tab characters before the new line as well to retain formatting of the
					-- next line correctly.
				a_class_text.remove_substring (temp_index, temp_index)
				from
					temp_index := temp_index - 1
				until
					a_class_text.item (temp_index) /= '%T'
				loop
					a_class_text.remove (temp_index)
					temp_index := temp_index - 1
				end
			end
		end

	set_class_name (a_name: STRING)
			-- Replace all occurances of `class_name_tag' with
			-- `a_name' within `class_text'.
		require
			a_name_not_void: a_name /= Void
		do
			a_name.to_upper
			class_text.replace_substring_all (class_name_tag, a_name)
		end

	set_inherited_class_name (a_name: STRING)
			-- Replace all occurances of `inherited_class_name_tag' with
			-- `a_name' within `class_text'.
		require
			a_name_not_void: a_name /= Void
		do
			class_text.replace_substring_all (inherited_class_name_tag, a_name)
		end

	prepass_xml (element: XM_ELEMENT; info: GB_GENERATED_INFO; depth: INTEGER)
			-- With information in element, build information into `info'.
		require
			element_not_void: element /= Void
			info_not_void: info /= Void
			depth_positive: depth > 0
		local
			current_element: XM_ELEMENT
			current_name, current_type: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			current_data_element: XM_CHARACTER_DATA
			action_sequence_info: GB_ACTION_SEQUENCE_INFO
			new_name: STRING
			in_reference: BOOLEAN
		do
			info.set_element (element)
			if element.has_attribute_by_name (type_string) then
				current_type := element.attribute_by_name (type_string).value
				info.set_type (current_type)
			end
			in_reference := False
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.same_string (Item_string) then
						if not in_reference then
							prepass_xml (current_element, info.new_child, depth + 1)
						end
					else
						if current_name.same_string (Internal_properties_string) then
							full_information := get_unique_full_info (current_element)
							element_info := full_information @ (name_string)
							if element_info /= Void then
								info.set_name (element_info.data)
							else
								-- We must now assign a name, as the current object was not named.
								new_name := unique_name_from_array (generated_names, Local_object_name_prepend_string + info.type)
								info.set_name (new_name)
								info.enable_generated_name
								generated_names.force (new_name)
							end

								-- We check for root level depth to ensure if we are a root object or not.							
							if depth = 1 then
								info.set_as_root_object
							end
							element_info := full_information @ (reference_id_string)

							if element_info /= Void then
								info.set_associated_root_object_id (element_info.data.to_integer)
								in_reference := True
							end

							element_info := full_information @ client_string
							if element_info /= Void then
								info.enable_generate_as_client
							end

							element_info := full_information @ (id_string)
							info.set_id (element_info.data.to_integer)
							info.generated_info_by_id.force (info, info.id)
							info.names_by_id.force (info.name, info.id)
						elseif current_name.same_string (Events_string) then
							prepass_xml (current_element, info, depth + 1)
								-- We must now loop through the element, and retrieve all the events.
						elseif current_name.same_string (Event_string) then
								-- Now record all events for the current object.
							from
								current_element.start
							until
								current_element.off
							loop
								current_data_element ?= current_element.item_for_iteration
								if current_data_element /= Void then
									action_sequence_info := string_to_action_sequence_info (current_data_element.content)
									info.add_new_event (action_sequence_info)
								end
								current_element.forth
							end
						else
							info.add_supported_types (current_name, current_element)
						end
					end
				end
				element.forth
			end
		end

	generate_declarations (info: GB_GENERATED_INFO)
			-- With information in `element', generate code which includes the
			-- attribute declarations and creation of all components in system.
		require
			info_not_void: info /= Void
		local
			generated_info: GB_GENERATED_INFO
			children: ARRAYED_LIST [GB_GENERATED_INFO]
		do
			create children.make (10)
			info.all_children_recursive (children)
			children.extend (info)
			from
				children.start
			until
				children.off
			loop
				generated_info := document_info.generated_info_by_id.item (children.item.id)
				check
						-- If this always passes, then the "if" statements below can be reduced.
					name_valid: generated_info.name /= Void and then not generated_info.name.is_empty
				end
				if generated_info.name /= Void and then not generated_info.name.is_empty and then
					generated_info.name /= Client_window_string then
					-- If the name is equal to `client_window_string' then we must be the window
					-- in a client based system. This has a special attribute clauses added in the
					-- file, so we do not add it in the same fashion as other attributes.
					add_local_declaration (generated_info)
					create_local (generated_info)
				else
					check
						never_executed: False
					end
				end
				children.forth
			end
		end

	generate_structure (info: GB_GENERATED_INFO)
			-- With information in `document_info', generate code which will
			-- parent all objects.
		require
			info_not_void: info /= Void
		local
			new_object : GB_OBJECT
			menu_bar_object: GB_MENU_BAR_OBJECT
			generated_info: GB_GENERATED_INFO
			code_for_insert: STRING
			children: ARRAYED_LIST [GB_GENERATED_INFO]
		do
			create children.make (10)
			info.all_children_recursive (children)
			children.extend (info)
			from
				children.start
			until
				children.off
			loop
				generated_info := info.generated_info_by_id.item (children.item.id)
					-- Fixme, why assign id here? Try generating, and then see new ids after...
				new_object := components.object_handler.build_object_from_string (generated_info.type)
				code_for_insert := generated_info.name.twin
				if generated_info.associated_root_object_id > 0 and components.object_handler.object_from_id (generated_info.associated_root_object_id).generate_as_client then
					if generated_info.type.same_string (ev_titled_window_string) or generated_info.type.same_string (ev_dialog_string) then
						code_for_insert.append ("." + client_window_string)
					else
						code_for_insert.append ("." + client_widget_string)
					end
				end
				if generated_info.parent /= Void and then generated_info.parent.type /= Void and then generated_info.parent.is_root_object then
					menu_bar_object ?= new_object
					if menu_bar_object /= Void then
						if info.generate_as_client then
							add_build (client_window_string + ".set_menu_bar (" + generated_info.name + ")")
						else
							add_build ("set_menu_bar (" + generated_info.name + ")")
						end
					else
						if info.generate_as_client then
							if generated_info.parent.type.same_string (ev_titled_window_string) or generated_info.parent.type.same_string (ev_dialog_string) then
								add_build (client_window_string +  "." + new_object.extend_xml_representation (code_for_insert))
							else
								add_build (client_widget_string + "." + new_object.extend_xml_representation (code_for_insert))
							end
						else
							add_build (new_object.extend_xml_representation (code_for_insert))
						end
					end
						-- If name is Void, the we are at the root element of the info.
						-- This does not represent a widget at all, so do nothing
				elseif not generated_info.is_root_object then
					-- Tables need to use put, but this is done in conjunction with the placement.
					-- So here, we do not add the children of the table, as it will be done later.
					if generated_info.parent /= Void and then generated_info.parent.type /= Void and then not generated_info.parent.type.same_string (Ev_table_string) then
						add_build (generated_info.parent.name + "." + new_object.extend_xml_representation (code_for_insert))
					end
				end
				children.forth
			end
		end

	generate_setting (info: GB_GENERATED_INFO)
			-- With information in `document_info', generate code which will
			-- set_all_objects.
		require
			info_not_void: info /= Void
		local
			gb_ev_any: GB_EV_ANY
			generated_info: GB_GENERATED_INFO
			supported_types, current_settings: ARRAYED_LIST [STRING]
			children: ARRAYED_LIST [GB_GENERATED_INFO]
		do
			create children.make (10)
			info.all_children_recursive (children)
			children.extend (info)
			from
				children.start
			until
				children.off
			loop
				generated_info := info.generated_info_by_id.item (children.item.id)
				supported_types := generated_info.supported_types
				from
					supported_types.start
				until
						-- Here we check that the current object does not represent a root object, as
						-- if so, there is nothing to do here.
					supported_types.off or generated_info.associated_root_object_id > 0
				loop
					gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + supported_types.item))
							-- Call default_create on `gb_ev_any'
					gb_ev_any.set_components (components)
					gb_ev_any.default_create
						-- Ensure that the new class exists.
					check
						new_instance_exists: gb_ev_any /= Void
					end
					current_settings := gb_ev_any.generate_code (generated_info.supported_type_elements @ (supported_types.index), generated_info)
					from
						current_settings.start
					until
						current_settings.off
					loop
						add_set (current_settings.item)
						current_settings.forth
					end
					supported_types.forth
				end

				children.forth
			end
		end

	generate_events (info: GB_GENERATED_INFO)
			-- Using `document_info' which was generated in `prepass_xml',
			-- generate source code corresponding to selected events.
		require
			info_not_void: info /= Void
		local
			generated_info: GB_GENERATED_INFO
			events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
			action_sequence_info: GB_ACTION_SEQUENCE_INFO
			action_sequence: GB_EV_ACTION_SEQUENCE
			renamed_action_sequence_name: STRING
			local_name: STRING
			comment_object_name: STRING
			parameters: STRING
			feature_implementation: STRING
			children: ARRAYED_LIST [GB_GENERATED_INFO]
			l_generate_close_actions: BOOLEAN
		do
			create children.make (10)
			info.all_children_recursive (children)
			children.extend (info)
			l_generate_close_actions := True
			from
				children.start
			until
				children.off
			loop
				generated_info := info.generated_info_by_id.item (children.item.id)
				if generated_info.associated_root_object_id = 0 then
					events := generated_info.events
					from
						events.start
					until
						events.off
					loop
						action_sequence_info := events.item
						action_sequence ?= new_instance_of (dynamic_type_from_string ("GB_" + action_sequence_info.type))
						check
							action_sequence_not_void: action_sequence /= Void
						end
								-- We must handle a root object as a special case, as there
							-- is no need for a dot call, unless we are using the window as a client.
						if generated_info.is_root_object then
							local_name := ""
							if info.generate_as_client then
								if generated_info.type.same_string (ev_titled_window_string) or generated_info.type.same_string (ev_dialog_string) then
									local_name := Client_window_string + "."
								else
									local_name := client_widget_string + "."
								end
							end
						else
							local_name := generated_info.name + "."
						end

							-- Adjust event names that have been renamed in Vision2 interface
						renamed_action_sequence_name := modified_action_sequence_name (generated_info.type, action_sequence_info)
						if action_sequence_info.name.same_string ("close_request_actions") then
							l_generate_close_actions := False
						end

							-- If there are no arguments to the action sequence then generate no open arguments.
						if action_sequence.count = 0 then
							add_event_connection (local_name + renamed_action_sequence_name + ".extend (agent " + action_sequence_info.feature_name + ")")
						else
							add_event_connection (local_name + renamed_action_sequence_name + ".extend (agent " + action_sequence_info.feature_name + " (" + action_sequence.open_arguments + "))")
						end

							-- We must not generate the feature names again, if we have multiple events connected
							-- to a single action sequence and we have already generated the feature.
						if not all_generated_events.has (action_sequence_info.feature_name.as_lower) then
							all_generated_events.extend (action_sequence_info.feature_name.as_lower)
								-- Use `Current' in comment if the event is connected to the window.
							if generated_info.type.same_string (Ev_titled_window_string) then
								comment_object_name := "Current"
							else
								comment_object_name := generated_info.name
							end


								-- No parameters if zero arguments.
							if action_sequence.count = 0 then
								parameters := ""
							else
								parameters := " (" +action_sequence.parameter_list + ")"
							end

								-- If the user has selected that they wish to generate debugging output,
								-- then we build a representation in `feature_implementation' otherwise,
								-- the feature implementation will be empty.
							if project_settings.debugging_output then
								if action_sequence.count = 0 then
									feature_implementation := indent + "io.putstring (%"" + action_sequence_info.feature_name + " executed%%N%%N%%N%")"
								else
									feature_implementation := indent + "io.putstring (%"" + action_sequence_info.feature_name + " executed%%N%")" + indent + action_sequence.debugging_info
								end
							else
								feature_implementation := ""
							end

								-- Now we must generate the event declarations.
							add_event_declaration (action_sequence_info.feature_name + parameters +
							indent + "-- Called by `" + action_sequence_info.name + "' of `" + comment_object_name + "'." +
							indent_less_one + "deferred" + indent_less_one + "end" + indent_less_two)

							add_event_implementation (action_sequence_info.feature_name + parameters +
							indent + "-- Called by `" + action_sequence_info.name + "' of `" + comment_object_name + "'." +
							indent_less_one + "do" + feature_implementation + indent_less_one + "end" + "%N%N")
						end
						events.forth
					end
				end
				children.forth
			end

			if
				l_generate_close_actions and then
				(generated_info.type.same_string (ev_window_string) or
				generated_info.type.same_string (ev_titled_window_string))
			then
					-- Now we must connect the close event of the window if no `close_actions' have been added by user
					-- and we are handling a window.
				add_event_connection ("%T-- Close the application when an interface close")
				add_event_connection ("%T-- request is received on `Current'. i.e. the cross is clicked.")
				if info.generate_as_client then
					add_event_connection (Client_window_string + ".close_request_actions.extend (agent " + Client_window_string + ".destroy_and_exit_if_last)")
				else
					add_event_connection ("close_request_actions.extend (agent destroy_and_exit_if_last)")
				end
			end
		end

	locals: HASH_TABLE [ARRAYED_LIST [STRING], STRING]
		-- A list of all locals of a particular type found during parsing,
		-- hashed by their type.

	exported_attributes: HASH_TABLE [ARRAYED_LIST [STRING], STRING]
		-- A list of all exported attributes of a particular type found during parsing,
		-- hashed by their type.

	non_exported_attributes: HASH_TABLE [ARRAYED_LIST [STRING], STRING]
		-- A list of all non exported attributes of a particular type found during parsing,
		-- hashed by their type.

	add_item_to_hash_table (item, key: STRING; hash_table: HASH_TABLE [ARRAYED_LIST [STRING], STRING])
			-- Add `item' to list in `hash_table' with key `key'.
		require
			item_not_void: item /= Void
			key_not_void: key /= Void
			hash_table_not_void: hash_table /= Void
		local
			current_item: ARRAYED_LIST [STRING]
		do
			current_item := hash_table.item (key)
			if current_item = Void then
				create current_item.make (4)
				current_item.extend (item)
				hash_table.put (current_item, key)
			else
				current_item.extend (item)
			end
		end

	add_local_declaration (generated_info: GB_GENERATED_INFO)
			-- Add code representation of new local named `name' of type
			-- `local_type' to `local_string'.
			-- Each new local will be grouped with other locals of same type. e.g.
			-- button1, button2: EV_BUTTON.
		require
			generated_info_not_void: generated_info /= Void
		local
			local_type, name: STRING
		do
			if not generated_info.is_root_object then
				if generated_info.associated_root_object_id > 0 then
					local_type := generated_info.generated_info_by_id.item (generated_info.associated_root_object_id).name.as_upper
				else
					local_type := generated_info.type
				end
				name := generated_info.name

					-- Need to generate slightly different code dependent
					-- on whether the atrributes are local or not.
				if project_settings.attributes_local.same_string (True_string) then

					add_item_to_hash_table (name, local_type, locals)
				elseif project_settings.attributes_local.same_string (false_string) or
					(project_settings.attributes_local.same_string (False_optimal_string) and not generated_info.generated_name) then

					add_item_to_hash_table (name, local_type, exported_attributes)
				elseif (project_settings.attributes_local.same_string (False_optimal_string) and generated_info.generated_name)
				or project_settings.attributes_local.same_string (false_non_exported_string) then
					add_item_to_hash_table (name, local_type, non_exported_attributes)
				else
					check
						false_logic: false
					end
				end
			end
		end

	process_attributes (a_string, indent_string: STRING; attributes: HASH_TABLE [ARRAYED_LIST [STRING], STRING])
			-- Add declarations for all attributes held within `attributes' using `indent_string' between lines
			-- to `a_string'. If `project_settings.grouped_locals' then group each declaration of identical types.
		require
			a_string_not_void: a_string /= Void
			indent_string_not_void: indent_string /= Void
			attributes_not_void: attributes /= Void
		local
			current_item: ARRAYED_LIST [STRING]
			line_counter: INTEGER
		do
			from
				attributes.start
			until
				attributes.off
			loop
				current_item := attributes.item_for_iteration
				from
					current_item.start
				until
					current_item.off
				loop
					if not project_settings.grouped_locals then
						a_string.append (indent_string + current_item.item + ": " + attributes.key_for_iteration)
					else
						if current_item.index = 1 then
								-- Only add the indent on the first iteration.
							a_string.append (indent_string)
						end
						a_string.append (current_item.item)
							-- Note that the "+ 2" is for the ", " appended.
						line_counter := line_counter + current_item.item.count + 2
						if current_item.index < current_item.count then
							if line_counter > 80 then
								a_string.append (",")
									-- Also add an indent if the line width has been reached.
								a_string.append (indent_string)
								line_counter := 0
							else
								a_string.append (", ")
							end
						end
						if current_item.index = current_item.count then
								-- As we have now found the final item, append the type
							a_string.append (": " + attributes.key_for_iteration)
						end
					end
					current_item.forth
				end
				attributes.forth
			end
		end

	process_locals
			-- Perform processing for generation of attribute and local strings.
		require
			locals_not_void: locals /= Void
			exported_attributes_not_void: exported_attributes /= Void
			non_exported_attributes_not_void: non_exported_attributes /= Void
		do
			if not locals.is_empty then
				local_string := ""
			end
			if not exported_attributes.is_empty or not non_exported_attributes.is_empty then
				attribute_string := ""
			end
			if not locals.is_empty then
				local_string.append ("local")
				process_attributes (local_string, indent, locals)
			end
			if not exported_attributes.is_empty then
				attribute_string.append ("feature -- Access%N")
				process_attributes (attribute_string, indent_less_two, exported_attributes)
			end
			if not non_exported_attributes.is_empty then
				if not attribute_string.is_empty then
					attribute_string.append ("%N%N")
				end
				attribute_string.append ("feature {NONE} -- Implementation%N")
				process_attributes (attribute_string, indent_less_two, non_exported_attributes)
			end
		end

	remove_line_containing (string: STRING; body: STRING)
			-- Remove the line of text from `body' containing `string'.
			-- The "%N" following `string' is the one removed. The start of
			-- the line is determined by the previous "%N".
		require
			strings_not_void: string /= Void and body /= Void
		local
			index: INTEGER
			next_index: INTEGER
			tab_index: INTEGER
			temp_string: STRING
		do
			index := body.substring_index (string, 1)
			next_index := body.substring_index ("%N", index)
			temp_string := body.substring (1, index)
			tab_index := temp_string.last_index_of ('%N', temp_string.count)
			body.remove_substring (tab_index + 1, next_index)
		end

	create_local (generated_info: GB_GENERATED_INFO)
			-- Add code representation of the creation of local based on `generated_info'
			-- to `create_string'.
		require
			generated_info_not_void: generated_info /= Void
		local
			temp_string: STRING
		do
			if not generated_info.is_root_object then
				temp_string := indent + Create_command_string + generated_info.name
				if create_string.is_empty then
					create_string := create_widgets_comment + temp_string
				else
					create_string := create_string + temp_string
				end
			end
		end

	add_build (constructor: STRING)
			-- Add `constructor' to `build_string'.
		require
			constructor_not_void: constructor /= Void
		local
			temp_string: STRING
		do
			temp_string := indent + constructor
			if build_string.is_empty then
				build_string := build_widgets_comment + temp_string
			else
				build_string := build_string + temp_string
			end
		end

	add_event_connection (event: STRING)
			-- Add `indent' and `event' to `event_connection_string'.
			-- Create `event_connection_string' if empty.
		require
			event_not_void: event /= Void
		do
			if event_connection_string.is_empty then
				event_connection_string := connect_events_comment
			end
			event_connection_string := event_connection_string + indent + event
		end

	add_event_declaration (event: STRING)
			-- Add `indent' and `event' to `event_declaration_string'.
			-- Create `event_declaration_string' if empty.
		require
			event_not_void: event /= Void
		do
			event_declaration_string := event_declaration_string + indent_less_two + event
		end

	add_event_implementation (event: STRING)
			-- Add `indent' and `event' to `event_implementation_string.
			-- Create `event_implementation_string' if empty.
		require
			event_not_void: event /= Void
		do
			event_implementation_string := event_implementation_string + indent_less_two + event
		end

	add_set (set: STRING)
			-- Add a setting represention, `set' to
			-- `set_string'.
		require
			set_not_void: set /= Void
		local
			temp_string: STRING
			non_void_set: STRING
		do
			non_void_set := set
			if non_void_set = Void then
				non_void_set := ""
			end

			if set_string.is_empty then
				temp_string := non_void_set
			else
				if not non_void_set.is_empty then
					temp_string := indent + non_void_set
				end
			end

			if temp_string /= Void then
				set_string := set_string + temp_string
			end
		end

	window_counter: INTEGER
		-- Counts the number of windows that have been generated

	total_windows: INTEGER
		-- The total number of windows that muat be generated.

	set_progress (value: REAL)
			-- Assign `value' to proportion of `progress_bar'
			-- if `progress_bar' /= Void
		require
			valid_range: value >=0 and value <= 1
		local
			env: EV_ENVIRONMENT
		do
			if progress_bar /= Void then
				create env
				progress_bar.set_proportion (value)
				env.application.process_graphical_events
			end
		end

	document_info: GB_GENERATED_INFO
		-- Representation of XML file after `prepass_xml'.

	project_settings: GB_PROJECT_SETTINGS
			-- Short access to system_status.current_project_settings.
			-- Cannot be a once, as the settings may change.
		do
			Result := components.system_status.current_project_settings
		end

	all_generated_events: ARRAYED_LIST [STRING]
		-- A list of all event feature names that have been generated. This is necessary, so
		-- that when there are multiple events connected to one feature, then we do not
		-- repeatedly generate the feature, just the connection of the feature to
		-- the action sequence.

	current_document: XM_DOCUMENT
		-- An XML document representing the current layout built
		-- by the user. We generate the class text from the information
		-- held within.

	class_text: STRING
		-- The current representation of the class we are generating.

	application_text: STRING
		-- The current representation of the application we are generating.

	ace_text: STRING
		-- The current representation of the ace file we are generating.

	local_string: STRING
		-- String representation of all local declarations built
		-- by `Current'. This is inserted into the template when complete.

	attribute_string: STRING
		-- String representation of all attribute declarations built by `Current'.

	create_string: STRING
		-- String representation of all creation statements built by
		-- `Current'. This is inserted into the template when complete.

	build_string: STRING
		-- String representation of all widget parenting statements built
		-- by `Current'. This is inserted into the template when complete.

	set_string: STRING
		-- String representation of all attribute setting statements built
		-- by `Current'. This is inserted into the template when complete.

	event_connection_string: STRING
		-- String representation of all event connection statements built by
		-- `Current'. This is inserted into the template when completed.

	event_declaration_string: STRING
		-- String representation of all event declaration statements built by
		-- `Current'. This is inserted into the template when completed.

	event_implementation_string: STRING
		-- String representation of all event implementation statements built by
		-- `Current'. This is inserted into the template when completed.

	progress_bar: EV_PROGRESS_BAR
		-- A progress bar that will be updated during generation.

	progress_switch: REAL = 0.6
		-- Progress level for end of xml storing, and start of generation.
		-- As they are performed independently, we need the progress of each to
		-- work as a whole

	missing_files: ARRAYED_LIST [PATH]
		-- All files that could not be located during generation.

	read_only_files: ARRAYED_LIST [PATH]
			-- All files that could not be accessed during generation.

	open_text_file_for_read (file_name: PATH): PLAIN_TEXT_FILE
			-- Open file plain text file named `file_name',
			-- and return it if it exists, otherwise return Void.
		require
			file_name_not_void: file_name /= Void
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make_with_path (file_name)
			if file.exists then
				file.open_read
				Result := file
			else
				if missing_files = Void then
					create missing_files.make (1)
				end
				missing_files.extend (file_name)
			end
		end

	generated_names: ARRAYED_LIST [STRING]
			-- All names generated automatically.
		once
			create Result.make (0)
		ensure
			result_not_void: Result /= Void
		end

invariant
	event_connection_string_not_void: event_connection_string /= Void
	create_string_not_void: create_string /= Void
	build_string_not_void: build_string /= Void
	set_string_not_void: set_string /= Void
	event_implementation_string_not_void: event_implementation_string /= Void
	event_declaration_string_not_void: event_declaration_string /= Void

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


end -- class GB_CODE_GENERATOR
