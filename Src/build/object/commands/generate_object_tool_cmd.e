indexing
	description: "Generate object tool."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	GENERATE_OBJECT_TOOL_CMD

inherit

	EB_UNDOABLE

	SHARED_CLASS_IMPORTER

creation

	make

feature

	make is
			-- Create command.
		do
		end

feature -- Execution

	work (arg: ANY) is
			-- Generate one object tool.
		local
			mp: MOUSE_PTR
		do
			!! mp
			application_class := object_tool_generator.edited_class
			mp.set_watch_shape
			generate_interface
			generate_command
			generate_instance
			mp.restore
			object_tool_generator.close
		end

	undo is
		do
		end

	redo is
		do
		end

	failed: BOOLEAN

	name: STRING is
		do
			!! Result.make (0)
			Result.append (Command_names.Generate_tool_cmd_name)
			Result.append (" ")
			if application_class /= Void then
				Result.append (application_class.class_name)
			end
		end

	visual_command_name: STRING is
			-- Visual name of the generated command.
		local
			cl_name: STRING
		do
			!! Result.make (0)
			Result.append ("set_")
			cl_name := clone (application_class.class_name)
			cl_name.to_lower
			Result.append (cl_name)
			Result.append ("_object_cmd")	
		end
feature {NONE} -- Interface attribute

	ok_push_b_c: PUSH_B_C

feature -- Tool generation

	generate_interface is
			-- Generate the interface elements.
		local
			counter, width, height, max_height: INTEGER
			a_query_editor_form: QUERY_EDITOR_FORM
		do
			generate_permanent_window
			form_list := object_tool_generator.form_table.linear_representation
			from
				width := 300
				form_list.start
			until
				form_list.after
			loop
				a_query_editor_form := form_list.item
				if a_query_editor_form.managed then
					if counter < (form_list.index // 20) then
						counter := form_list.index // 20
						max_height := max_height.max (height)
						height := 0
					end
					a_query_editor_form.generate_interface_elements (width * counter, height, perm_wind)
					height := height + a_query_editor_form.minimum_height
					width := width.max (a_query_editor_form.minimum_width)
				end
				form_list.forth
			end
			if counter = 0 then
				max_height := height
			end
			counter := counter + 1
			!! ok_push_b_c
			ok_push_b_c := ok_push_b_c.create_context (perm_wind)
			ok_push_b_c.set_x_y (width * counter - 100, height)
			ok_push_b_c.set_visual_name ("OK")
			max_height := max_height + ok_push_b_c.height
			perm_wind.set_size (width * counter, max_height)
			perm_wind.set_x_y (0, 0)
		end

	generate_permanent_window is
			-- Generate the permanent window.
		require
			application_class_not_void: application_class /= Void
		local
			new_perm_wind: PERM_WIND_C
			visual_name: STRING
		do
			!! new_perm_wind
			perm_wind := new_perm_wind.create_context (Void)
			perm_wind.realize
			perm_wind.widget.manage	
			!! visual_name.make (15)
			visual_name.append (application_class.class_name)
			visual_name.append (" object editor")
			perm_wind.set_visual_name (visual_name)
		end

	generate_command is
			-- Generate the associated command.
		do
			!! generated_command.make
			generated_command.set_internal_name ("")
			generated_command.set_arguments (arguments)
			generated_command.set_eiffel_text (generated_eiffel_text)
			generated_command.set_visual_name (visual_command_name)
			generated_command.overwrite_text
			command_catalog.add_to_page (generated_command, command_catalog.generated_commands)
		end

	generated_eiffel_text: STRING is
			-- Generated eiffel text for associated command.
		do
			!! Result.make (0)
			Result.append (indexing_clause)
			Result.append (class_declaration)
			Result.append (feature_execute)
			Result.append (initialization_clause)
			Result.append (invariant_clause)
			Result.append (end_class_clause)
		end

	generate_instance is
			-- Generate an instance of the generated command.
		local
			generated_instance: CMD_INSTANCE
		do
			!! generated_instance.special_session_init (generated_command)
			generated_instance.set_arguments (argument_instances)
			ok_push_b_c.associate_instance (generated_instance)
		end	

feature {NONE} -- Code generation

	generated_command: USER_CMD
			-- Generated command

 	arguments: EB_LINKED_LIST [ARG] is
 			-- Widgets from the interface.
 		local
			a_query_editor_form: QUERY_EDITOR_FORM
		do
 			!! Result.make
 			from
				form_list.start
			until
				form_list.after
			loop
				a_query_editor_form := form_list.item
				if a_query_editor_form.managed then
					Result.append (a_query_editor_form.arguments)
				end
				form_list.forth
			end
		end

 	argument_instances: EB_LINKED_LIST [ARG_INSTANCE] is
 			-- Widgets from the interface.
 		local
			a_query_editor_form: QUERY_EDITOR_FORM
		do
 			!! Result.make
 			from
				form_list.start
			until
				form_list.after
			loop
				a_query_editor_form := form_list.item
				if a_query_editor_form.managed then
					Result.append (a_query_editor_form.argument_instances)
				end
				form_list.forth
			end
		end

	indexing_clause: STRING is
			-- Generate indexing clause.
		local
			class_name, routine_name: STRING
		do
			class_name := clone (application_class.class_name)
			!! Result.make (0)
			Result.append ("indexing%N")
			Result.append ("%Tdescription: %" Generated command used to change %%%N%T%T%T%T%% the queries of a ")
			Result.append (application_class.class_name)
			Result.append (" object.%"%N")
			Result.append ("%Tvisual_name: %"")
			Result.append (visual_command_name)
			Result.append ("%"%N%N")
		end

	class_declaration: STRING is
			-- Generate declaration of the class.
		require
			command_exists: generated_command /= Void
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
			Result.append ("]%N%Ncreation%N%N%Tmake%N%Nfeature%N%N")
		end


	feature_execute: STRING is
			-- Generate feature `execute'.
		local
			a_query_editor_form: QUERY_EDITOR_FORM
			argument_namer: LOCAL_NAMER
		do
			!! argument_namer.make ("argument")
			!! Result.make (0)
			Result.append ("%Texecute is%N%T%Trequire else%N%T%T%Ttarget_set: target_set%N%T%T%N")
			Result.append ("%T%Tlocal%N%T%T%Tprecondition: BOOLEAN%N%T%Tdo%N") 
			from
				form_list.start
			until
				form_list.after
			loop
				a_query_editor_form := form_list.item
				if a_query_editor_form.managed then
					argument_namer.next
					Result.append (a_query_editor_form.generate_eiffel_text (argument_namer))
				end
				form_list.forth
			end
			Result.append ("%T%Tend%N%N")
		end
		
	initialization_clause: STRING is
			-- Initialization.
		do
			!! Result.make (0)
			Result.append ("%Tmake is%N%T%Tdo%N%T%Tend%N%N")
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
			-- Class for which a tool has been generated

feature {NONE} -- Attributes

	perm_wind: PERM_WIND_C
			-- Generated permanent window.

	form_list: ARRAYED_LIST [QUERY_EDITOR_FORM]
			-- List of QUERY_EDITOR_FORM; need to generate interface
			-- element if corresponding QUERY_EDITOR_FORM is managed

end -- class GENERATE_OBJECT_TOOL_CMD
