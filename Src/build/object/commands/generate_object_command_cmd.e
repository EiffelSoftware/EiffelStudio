indexing
	description: "Generate object command."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	GENERATE_OBJECT_COMMAND_CMD

inherit

	EB_UNDOABLE

	SHARED_CLASS_IMPORTER

feature

	work (arg: ANY) is
			-- Generate a command.
		do
			if object_command_generator.routine_list.selected_count > 0 then
				application_class := object_command_generator.edited_class
				application_routine ?= object_command_generator.routine_list.selected_item
				generate_command
			end
		ensure then
			application_routine_not_void: application_routine /= Void
		end

	undo is
		do
		end

	redo is
		do
		end

	failed: BOOLEAN is
		do
		end

	name: STRING is
		do
			!! Result.make (0)
			Result.append (Command_names.Generate_command_cmd_name)
			Result.append (" ")
			if application_class /= Void and application_routine /= Void then
				Result.append (application_class.class_name)
				Result.append (".")
				Result.append (application_routine.routine_name)
			end
		end

feature -- Command generation

	generate_command is
			-- Generate the command
		do
			!! generated_command.make
			generated_command.set_internal_name ("")
			generated_command.set_eiffel_text (generated_eiffel_text)
			generated_command.set_visual_name (visual_command_name)
			generated_command.overwrite_text
			command_catalog.add_to_page (generated_command, command_catalog.generated_commands)
		end

	visual_command_name: STRING is
			-- Visual name of the command.
		local
			cl_name: STRING
		do
			cl_name := clone (application_class.class_name)
			cl_name.to_lower
			!! Result.make (0)
			Result.append (cl_name)
			Result.append ("_")
			Result.append (application_routine.routine_name)
			Result.append ("_cmd")
		end

	generated_eiffel_text: STRING is
			-- Generated Eiffel text of the command.
		do
			!! Result.make (0)
			Result.append (indexing_clause)
			Result.append (class_declaration)
			Result.append (initialization_clause)
			Result.append (access_clause)
			Result.append (element_change_clause)
			Result.append (status_report_clause)
			Result.append (basic_operation_clause)
			Result.append (invariant_clause)
			Result.append (end_class_clause)
		end

	indexing_clause: STRING is
			-- Indexing clause in the generated code.
		local
			class_name, routine_name: STRING
		do
			class_name := clone (application_class.class_name)
			routine_name := clone (application_routine.routine_name)
			!! Result.make (0)
			Result.append ("indexing%N")
			Result.append ("%Tdescription: %"Command calling the feature `")
			Result.append (routine_name)
			Result.append ("' of an object %%%N%T%T%% of type ")
			Result.append (class_name)
			Result.append (".%"%N")
			Result.append ("%Tvisual_name: %"")
			Result.append (visual_command_name)
			Result.append ("%"%N%N")
		end

	class_declaration: STRING is
			-- Declaration of the class.
		local
			class_name: STRING
		do
			class_name := clone (generated_command.eiffel_type)
			class_name.to_upper
			!! Result.make (0)
			Result.append ("class%N%N%T")
			Result.append (class_name)
			Result.append ("%N%Ninherit%N%N%TGENERATED_COMMAND [")
			Result.append (application_class.class_name)
			Result.append ("]%N%Ncreation%N%N%Tmake%N%N")
		end

	initialization_clause: STRING is
			-- Initialization.
		do
			!! Result.make (0)
			Result.append ("feature -- Initialization%N%N%Tmake is%N%T%Tdo%N%T%Tend%N%N")
		end

	access_clause: STRING is
			-- Access clause.
		local
			i: INTEGER
			arg_list: LINKED_LIST [APPLICATION_ARGUMENT]
		do
			!! Result.make (0)
			Result.append ("feature -- Access%N%N%Ttarget: ")
			Result.append (application_class.class_name)
			Result.append ("%N%T%T%T-- Target of next execution%N%N")
			arg_list := application_routine.argument_list
			from
				arg_list.start
				i := 1
			until
				arg_list.after
			loop
				Result.append ("%Tapp_argument")
				Result.append_integer (i)
				Result.append (": ")
				Result.append (arg_list.item.argument_type)
				Result.append ("%N%N")
				arg_list.forth
				i := i + 1
			end
		end

	element_change_clause: STRING is
			-- Element change clause.
		local
			arg_list: LINKED_LIST [APPLICATION_ARGUMENT]
			i: INTEGER
		do
			!! Result.make (0)
			Result.append ("feature -- Element change%N%N%Tset_arguments ")
			arg_list := application_routine.argument_list
			if not arg_list.empty then
				Result.append ("(")
				from
					arg_list.start
				until
					arg_list.after
				loop
					Result.append ("arg")
					Result.append_integer (i)
					Result.append (": ")
					Result.append (arg_list.item.argument_type)
					Result.append ("; ")
					arg_list.forth
					i := i + 1
				end
				Result.remove (Result.count)
				Result.remove (Result.count)
				Result.append (") ")
			end
			Result.append ("is%N%T%Tdo%N")
			if not arg_list.empty then
				from
					arg_list.start
					i := 1
				until
					arg_list.after
				loop
					Result.append ("%T%T%Tapp_argument")
					Result.append_integer (i)
					Result.append (" := ")
					Result.append ("arg")
					Result.append_integer (i)
					Result.append ("%N")
					arg_list.forth
					i := i + 1
				end
			end
			Result.append ("%T%Tend%N%N")
		end

	status_report_clause: STRING is
			-- Status report clause.
		do
			!! Result.make (0)
			Result.append ("feature -- Status report%N%N%Ttarget_set: BOOLEAN%N%T%T%T-- Has target been explicitly set?%N%N")
		end

	basic_operation_clause: STRING is
			-- Basic operation clause.
		local
			arg_list: LINKED_LIST [APPLICATION_ARGUMENT]
			i: INTEGER
		do
			arg_list := application_routine.argument_list
			!! Result.make (0)
			Result.append ("feature -- Basic operations%N%N%Texecute is%N%T%Trequire%N%T%T%Ttarget_set: target_set%N%T%Tdo%N%T%T%Tif target /= Void then%N%T%T%T%Ttarget.")
			Result.append (application_routine.routine_name)
			if not arg_list.empty then
				Result.append (" (")
				from 
					arg_list.start
					i := 0
				until
					arg_list.after
				loop
					Result.append ("app_argument")
					Result.append_integer (i)
					Result.append (", ")
					arg_list.forth
					i := i + 1
				end
				Result.remove (Result.count)
				Result.remove (Result.count)
				Result.append (")")
			end
			Result.append ("%N%T%T%Tend%N%T%Tend%N%N")
		end

	invariant_clause: STRING is
			-- Invariant clause.
		do
			!! Result.make (0)
			Result.append ("invariant%N%N%Ttarget_exist_if_set: target_set implies (target /= Void)%N%N")
		end

	end_class_clause: STRING is
			-- End of class
		do
			!! Result.make (0)
			Result.append ("end -- class ")
			Result.append (generated_command.eiffel_type)
			Result.append ("%N")
		end
			
feature -- Attributes

	application_class: APPLICATION_CLASS
			-- Class from which a command has been generated

	application_routine: APPLICATION_ROUTINE
			-- Routine from which a command has been generated

	generated_command: USER_CMD
			-- Generated command
			
end -- class GENERATE_OBJECT_COMMAND_CMD
