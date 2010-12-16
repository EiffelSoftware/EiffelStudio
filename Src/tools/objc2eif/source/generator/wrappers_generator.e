note
	description: "A generator of wrapper classes for Objective-C."
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPPERS_GENERATOR

inherit
	SHARED_CONFIGURATION

	OBJC_NAMES_CONVERSION

create
	make

feature {NONE} -- Initialization

	make (a_classes: HASH_TABLE [OBJC_CLASS_DECL, STRING]; a_protocols: HASH_TABLE [OBJC_PROTOCOL_DECL, STRING])
			-- Initialize Current with `a_classes' and `a_protocols'
		do
			create aliases.make (0)
			classes := a_classes
			protocols := a_protocols
			create struct_classes.make (0)
			create struct_types.make (0)
		ensure
			classes_set: classes = a_classes
			protocols_set: protocols = a_protocols
		end

feature -- Queries

	eiffel_class_exists (objc_type_identifier: STRING): BOOLEAN
			-- Does the eiffel class corresponding to `objc_type_identifier' exist in the parsed system?
		do
			if attached struct_classes.item (objc_class_name_to_eiffel_style (objc_type_identifier)) then
				Result := True
			end
			if attached classes.item (objc_type_identifier) then
				Result := True
			end
			across aliases as cursor loop
				if cursor.item.is_equal (objc_class_name_to_eiffel_style (objc_type_identifier)) then
					Result := True
				end
			end
		end

feature -- Generation

	generate_wrappers
			-- Generate the wrappers for the Objective-C `classes' and `protocols'.
			-- The Objective-C class names are automatically converted to Eiffel-style names
			-- and the output files are grouped by their framework in different folders.
		do
			create_project_directory
			generate_struct_classes
			generate_classes
			generate_classes_categories
			generate_utils_classes
			generate_protocols
			prepare_wrapper_project

			-- Debug aliases
			from
				aliases.start
			until
				aliases.after
			loop
				print ("Generated alias %"" + aliases.item_for_iteration + "%" for type %"" + aliases.key_for_iteration + "%"%N")
				aliases.forth
			end

			create_ecf_file
		end

feature {NONE} -- Implementation

	create_project_directory
			-- Create project directory
		local
			directory: DIRECTORY
		do
			create directory.make (configuration.wrapper_name)
			if not directory.exists then
				directory.create_dir
			end
		end

	prepare_wrapper_project
			-- Create the wrapper project's main folder and other auxiliary folders and files.
		local
			directory: DIRECTORY
			destination_file, source_file: RAW_FILE
			wrapper_name: STRING
			clib_folder: STRING
			contents: STRING
			auxiliary_folder_path: STRING
			temp, temp2, temp3: STRING
			i: INTEGER
			a_struct: OBJC_STRUCT_TYPE_DECL
			struct_name_to_use: STRING
			ignore_struct: BOOLEAN
		do
			wrapper_name := configuration.wrapper_name
				-- Create auxiliary folder
			auxiliary_folder_path := wrapper_name + "/" + configuration.auxiliary_folder_name
			create directory.make (auxiliary_folder_path)
			if not directory.exists then
				directory.create_dir
			end
				-- Copy 'objc_names_conversion.e' to auxiliary folder
			source_file := configuration.objc_names_conversion_file
			create destination_file.make_open_write (auxiliary_folder_path + "/" + source_file.name.split ('/').last)
			source_file.copy_to (destination_file)
			destination_file.close
				-- Copy 'classes_mapper.e' to auxiliary folder
			source_file := configuration.classes_mapper_file
			source_file.read_stream (source_file.count)
			contents := source_file.last_string
			contents.replace_substring_all ("$PARSED_CLASSES_COUNT", classes.count.out)
			create temp.make_empty
			from
				classes.start
				i := 0
			until
				classes.after
			loop
				temp.append ("%T%T%T%Tparsed_classes[" + i.out + "] = objc_getClass(%"" + classes.key_for_iteration + "%");%N")
				classes.forth
				i := i + 1
			end
			if temp.count >= 1 then
				temp.remove_tail (1)
			end
			contents.replace_substring_all ("$PARSED_CLASSES_INITIALIZATION", temp)
			create destination_file.make_create_read_write (auxiliary_folder_path + "/" + source_file.name.split ('/').last)
			destination_file.put_string (contents)
			destination_file.close
				-- Copy 'ns_any.e' to auxiliary folder
			source_file := configuration.ns_any_file
			create destination_file.make_open_write (auxiliary_folder_path + "/" + source_file.name.split ('/').last)
			source_file.copy_to (destination_file)
			destination_file.close
				-- Copy 'ns_common.e' to auxiliary folder
			source_file := configuration.ns_common_file
			source_file.read_stream (source_file.count)
			contents := source_file.last_string
			temp := ""
			temp2 := ""
			temp3 := ""
			across struct_types as cursor loop
				a_struct := cursor.item
				create struct_name_to_use.make_empty
				if a_struct.fields.count > 0 then
					if a_struct.struct_name.is_equal ("?") then
						if not a_struct.name.is_equal ("?") then
							struct_name_to_use.append (a_struct.name)
						else
							ignore_struct := True
						end
					else
						struct_name_to_use.append (a_struct.struct_name)
					end
					if not ignore_struct then
						temp.append ("%T%T%Telseif attached {TYPE [detachable " + objc_class_name_to_eiffel_style (struct_name_to_use) + "]} eiffel_type then%N")
						check attached a_struct.encoding as attached_encoding then
							temp.append ("%T%T%T%TResult.append (%"" + attached_encoding + "%")%N")
						end
						temp2.append ("%T%T%T%T%T%Telseif attached {TYPE [detachable " + objc_class_name_to_eiffel_style (struct_name_to_use) + "]} argument_type then%N")
						temp2.append ("%T%T%T%T%T%T%Tcreate {" + objc_class_name_to_eiffel_style (struct_name_to_use) + "} a_struct.make%N")
						temp2.append ("%T%T%T%T%T%T%Tinitialize_" + objc_class_name_to_eiffel_style (struct_name_to_use).as_lower + "_struct (argument, a_struct.item)%N")
						temp2.append ("%T%T%T%T%T%T%Targuments_tuple.put (a_struct, arguments_types_index)%N")
						temp2.append ("%T%T%T%T%T%T%Targument.memory_free%N")
						temp3.append ("%Tinitialize_" + objc_class_name_to_eiffel_style (struct_name_to_use).as_lower + "_struct (an_item: POINTER; struct_pointer: POINTER)%N")
						temp3.append ("%T%T%T-- Auto generated Objective-C wrapper.%N")
						temp3.append ("%T%Texternal%N")
						temp3.append ("%T%T%T%"C inline%"%N")
						temp3.append ("%T%Talias%N")
						temp3.append ("%T%T%T%"*(" + struct_name_to_use + " *)$struct_pointer = *(" + struct_name_to_use + " *)$an_item%"%N")
						temp3.append ("%T%Tend%N%N")
					end
				end
			end
			contents.replace_substring_all ("$STRUCTS_TESTS1", temp)
			contents.replace_substring_all ("$STRUCTS_TESTS2", temp2)
			contents.replace_substring_all ("$STRUCTS_INITIALIZERS", temp3)
			create destination_file.make_create_read_write (auxiliary_folder_path + "/" + source_file.name.split ('/').last)
			destination_file.put_string (contents)
			destination_file.close
				-- Copy 'ns_category_common.e' to auxiliary folder
			source_file := configuration.ns_category_common_file
			create destination_file.make_open_write (auxiliary_folder_path + "/" + source_file.name.split ('/').last)
			source_file.copy_to (destination_file)
			destination_file.close
				-- Copy 'ns_named_class.e' to auxiliary folder
			source_file := configuration.ns_named_class
			create destination_file.make_open_write (auxiliary_folder_path + "/" + source_file.name.split ('/').last)
			source_file.copy_to (destination_file)
			destination_file.close
				-- Copy 'objc_class.e' to auxiliary folder
			source_file := configuration.objc_class_file
			create destination_file.make_open_write (auxiliary_folder_path + "/" + source_file.name.split ('/').last)
			source_file.copy_to (destination_file)
			destination_file.close
				-- Copy 'objc_selector.e' to auxiliary folder
			source_file := configuration.objc_selector_file
			create destination_file.make_open_write (auxiliary_folder_path + "/" + source_file.name.split ('/').last)
			source_file.copy_to (destination_file)
			destination_file.close
				-- Create 'Clib' folder
			create directory.make (wrapper_name + "/" + configuration.clib_folder_name)
			if not directory.exists then
				directory.create_dir
			end
			clib_folder := wrapper_name + "/" + configuration.clib_folder_name
				-- Copy 'objc_callbacks.h' to the Clib folder
			source_file := configuration.objc_callbacks_h_file
			create destination_file.make_open_write (clib_folder + "/" + source_file.name.split ('/').last)
			source_file.copy_to (destination_file)
			destination_file.close
				-- Copy 'objc_callbacks.m' to the Clib folder
			source_file := configuration.objc_callbacks_m_file
			source_file.read_stream (source_file.count)
			contents := source_file.last_string
			temp := ""
			across struct_types as cursor loop
				a_struct := cursor.item
				create struct_name_to_use.make_empty
				if a_struct.fields.count > 0 then
					if a_struct.struct_name.is_equal ("?") then
						if not a_struct.name.is_equal ("?") then
							struct_name_to_use.append (a_struct.name)
						else
							ignore_struct := True
						end
					else
						struct_name_to_use.append (a_struct.struct_name)
					end
					if not ignore_struct then
						temp.append ("%T%Tif (strcmp(argumentType, @encode(" + struct_name_to_use + ")) == 0) {%N")
						temp.append ("%T%T%T" + struct_name_to_use + " *value_pointer = malloc(sizeof(" + struct_name_to_use + ")); // Freeing is done in eiffel code.%N")
						temp.append ("%T%T%T*value_pointer = va_arg(variableArguments, " + struct_name_to_use + ");%N")
						temp.append ("%T%T%Targuments[i - 2] = value_pointer;%N")
						temp.append ("%T%T%TargumentRead = YES;%N")
						temp.append ("%T%T}%N")
					end
				end
			end
			contents.replace_substring_all ("$STRUCTS_TESTS", temp)
			create destination_file.make_create_read_write (clib_folder + "/" + source_file.name.split ('/').last)
			destination_file.put_string (contents)
			destination_file.close
				-- Copy 'Makefile.SH' to the Clib folder
			source_file := configuration.makefile
			create destination_file.make_open_write (clib_folder + "/" + source_file.name.split ('/').last)
			source_file.copy_to (destination_file)
			destination_file.close

		end

	generate_struct_classes
			-- Generate wrapper classes for Objective-C structs
		local
			struct_wrapper_generator: STRUCT_WRAPPER_GENERATOR
		do
			create struct_wrapper_generator.make (aliases, struct_types)
			from
				classes.start
			until
				classes.after
			loop
				classes.item_for_iteration.accept (struct_wrapper_generator)
				classes.forth
			end
			from
				protocols.start
			until
				protocols.after
			loop
				protocols.item_for_iteration.accept (struct_wrapper_generator)
				protocols.forth
			end
			struct_wrapper_generator.generate_wrappers
			if configuration.generate_structs then
				struct_classes := struct_wrapper_generator.struct_classes
				from
					struct_classes.start
				until
					struct_classes.after
				loop
					create_class_file (struct_classes.item_for_iteration)
					struct_classes.forth
				end
			end
		end

	generate_classes
			-- Generate wrapper classes for Objective-C classes.
		local
			class_wrapper_generator: CLASS_WRAPPER_GENERATOR
			generated_classes: HASH_TABLE [EIFFEL_CLASS_DECL, STRING]
		do
			create class_wrapper_generator.make (Current)
			from
				classes.start
			until
				classes.after
			loop
				classes.item_for_iteration.accept (class_wrapper_generator)
				classes.forth
			end
			generated_classes := class_wrapper_generator.classes
			from
				generated_classes.start
			until
				generated_classes.after
			loop
				create_class_file (generated_classes.item_for_iteration)
				generated_classes.forth
			end
		end

	generate_classes_categories
			-- Generate wrapper classes for Objective-C categories.
		local
			category_wrapper_generator: CATEGORY_WRAPPER_GENERATOR
			generated_classes: HASH_TABLE [EIFFEL_CLASS_DECL, STRING]
		do
			create category_wrapper_generator.make (Current)
			from
				classes.start
			until
				classes.after
			loop
				classes.item_for_iteration.accept (category_wrapper_generator)
				classes.forth
			end
			generated_classes := category_wrapper_generator.classes
			from
				generated_classes.start
			until
				generated_classes.after
			loop
				create_class_file (generated_classes.item_for_iteration)
				generated_classes.forth
			end
		end

	generate_utils_classes
			-- Generate wrapper utils classes for Objective-C classes.
		local
			utils_class_wrapper_generator: CLASS_METHODS_WRAPPER_GENERATOR
			generated_classes: HASH_TABLE [EIFFEL_CLASS_DECL, STRING]
		do
			create utils_class_wrapper_generator.make (Current)
			from
				classes.start
			until
				classes.after
			loop
				classes.item_for_iteration.accept (utils_class_wrapper_generator)
				classes.forth
			end
			generated_classes := utils_class_wrapper_generator.classes
			from
				generated_classes.start
			until
				generated_classes.after
			loop
				create_class_file (generated_classes.item_for_iteration)
				generated_classes.forth
			end
		end

	generate_protocols
			-- Generate eiffel classes to wrap Objective-C protocols
		local
			protocols_generator: PROTOCOLS_GENERATOR
			generated_classes: HASH_TABLE [EIFFEL_CLASS_DECL, STRING]
		do
			create protocols_generator.make (Current)
			from
				protocols.start
			until
				protocols.after
			loop
				protocols.item_for_iteration.accept (protocols_generator)
				protocols.forth
			end
			generated_classes := protocols_generator.classes
			from
				generated_classes.start
			until
				generated_classes.after
			loop
				create_class_file (generated_classes.item_for_iteration)
				generated_classes.forth
			end
		end

	create_ecf_file
			-- Create the ecf file for the wrapper.
		local
			wrapper_name: STRING
			source_file: RAW_FILE
			destination_file: RAW_FILE
			contents: STRING
			aliases_string: STRING
			referenced_frameworks_string: STRING
			referenced_frameworks: ARRAYED_LIST [STRING]
			visitor: REFERENCED_FRAMEWORKS_VISITOR
		do
			wrapper_name := configuration.wrapper_name
			source_file := configuration.ecf_file_template
			source_file.read_stream (source_file.count)
			contents := source_file.last_string
			contents.replace_substring_all ("$WRAPPER_NAME", wrapper_name)
			create aliases_string.make_empty
			from
				aliases.start
			until
				aliases.after
			loop
				aliases_string.append ("%T%T%T<mapping old_name=%"" + aliases.key_for_iteration + "%" new_name=%"" + aliases.item_for_iteration + "%"/>%N")
				aliases.forth
			end
			if aliases.count > 0 then
				aliases_string.remove_tail (1)
			end
			contents.replace_substring_all ("$ALIASES", aliases_string)
			create visitor.make
			from
				classes.start
			until
				classes.after
			loop
				classes.item_for_iteration.accept (visitor)
				classes.forth
			end
			from
				protocols.start
			until
				protocols.after
			loop
				protocols.item_for_iteration.accept (visitor)
				protocols.forth
			end
			referenced_frameworks := visitor.referenced_frameworks
			from
				create referenced_frameworks_string.make_empty
				referenced_frameworks.start
			until
				referenced_frameworks.after
			loop
				referenced_frameworks_string.append ("%T%T<external_object location=%"-framework " + referenced_frameworks.item + "%"/>%N")
				referenced_frameworks.forth
			end
			if referenced_frameworks.count > 0 then
				referenced_frameworks_string.remove_tail (1)
			end
			contents.replace_substring_all ("$FRAMEWORKS", referenced_frameworks_string)
			create destination_file.make_create_read_write (wrapper_name + "/" + wrapper_name + ".ecf")
			destination_file.put_string (contents)
			destination_file.close
		end

	classes: HASH_TABLE [OBJC_CLASS_DECL, STRING]
			-- A representation of classes indexed by their names.

	protocols: HASH_TABLE [OBJC_PROTOCOL_DECL, STRING]
			-- A representation of protocols indexed by their names.

	aliases: HASH_TABLE [STRING, STRING]
			-- A table of type aliases indexed by the pointed type.
			-- E.g. Key: CG_RECT, Value: NS_RECT (alias).

	struct_classes: HASH_TABLE [EIFFEL_CLASS_DECL, STRING]
			-- A table of eiffel class declarations representing Objective-C structss.

	struct_types: HASH_TABLE [OBJC_STRUCT_TYPE_DECL, STRING]
			-- A table of structs types that have been visited indexed by their name.

feature {NONE} -- Utilities

	create_class_file (a_class: EIFFEL_CLASS_DECL)
			-- Create a new file named `a_class.name'.e containing `a_class.debug_output' in
			-- a folder named `a_class.framework'. If the folder does not exist, it is created.
		local
			directory: DIRECTORY
			file: RAW_FILE
			base_path: STRING
		do
			base_path := configuration.wrapper_name + "/" + a_class.framework.as_lower
			create directory.make (base_path)
			if not directory.exists then
				directory.create_dir
			end
			create file.make_open_write (base_path + "/" + a_class.name.as_lower + ".e")
			file.put_string (a_class.debug_output)
			file.close
		end

end
