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
		local
			mp: MOUSE_PTR
			precondition_t_b: TOGGLE_B
		do
			if object_command_generator.routine_list.selected_count > 0 then
				application_class := object_command_generator.edited_class
				application_routine ?= object_command_generator.routine_list.selected_item
				object_command_generator.generate_command	
				precondition_t_b ?= arg
				if precondition_t_b /= Void then
					check_precondition := precondition_t_b.state
				end
				!! mp
				mp.set_watch_shape
				generate_command
				mp.restore
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

feature {NONE} -- Command generation

	generate_command is
			-- Generate the command
		do
			!! generated_command.make
			generated_command.set_internal_name ("")
			generated_command.set_eiffel_text (generated_eiffel_text)
			generated_command.overwrite_text
			command_catalog.add_to_page (generated_command, command_catalog.generated_commands)
			generated_command.set_visual_name (visual_command_name)
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
			Result.append (basic_operation_clause)
			Result.append (invariant_clause)
			Result.append (end_class_clause)
		end

feature {NONE} -- Code generation

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
			Result.append ("feature -- Access%N%N")
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
					i := 1
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

	basic_operation_clause: STRING is
			-- Basic operation clause.
		local
			arg_list: LINKED_LIST [APPLICATION_ARGUMENT]
			i: INTEGER
			preconditions: LINKED_LIST [APPLICATION_PRECONDITION]
			formal_arguments: ARRAYED_LIST [STRING]
		do
			arg_list := application_routine.argument_list
			!! Result.make (0)
			Result.append ("feature -- Basic operations%N%N%Texecute is%N%T%Trequire else%N")
			Result.append ("%T%T%Ttarget_set: target_set%N")
			if check_precondition then
				Result.append ("%T%Tlocal%N")
				Result.append ("%T%T%Tprecondition: BOOLEAN%N")
			end
			Result.append ("%T%Tdo%N")
			if check_precondition then
				preconditions := application_routine.precondition_list
				!! formal_arguments.make (arg_list.count)
				from
					arg_list.start
					i := 1
				until
					arg_list.after
				loop
					formal_arguments.extend (arg_list.item.argument_name)
					arg_list.forth
					i := i + 1
				end
				Result.append ("%T%T%Tprecondition := True%N")
				from
					preconditions.start
				until
					preconditions.after
				loop
					Result.append ("%T%T%Tprecondition := precondition and then ")
					Result.append (preconditions.item.generated_text_for_routine (formal_arguments))
					Result.append ("%N")
					preconditions.forth
				end
				Result.append ("%T%T%Tif precondition then%N%T")
			end
			Result.append ("%T%T%Ttarget.")
			Result.append (application_routine.routine_name)
			if not arg_list.empty then
				Result.append (" (")
				from 
					arg_list.start
					i := 1
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
			if check_precondition then
				Result.append ("%N%T%T%Telse%N%T%T%T%Tdisplay_error_message (%"")
				Result.append ("Incorrect `")
				Result.append (application_routine.routine_name)
				Result.append ("' field.%", Void)")
				Result.append ("%N%T%T%Tend")
			end
			Result.append ("%N%T%Tend%N%N")
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

	check_precondition: BOOLEAN
			-- Do we have to generate precondition test?
			
end -- class GENERATE_OBJECT_COMMAND_CMD
