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
		do
			application_class := object_tool_generator.edited_class
			generate_interface
			generate_command
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

feature -- Tool generation

	generate_interface is
			-- Generate the interface elements.
		local
			height, width: INTEGER
			a_query_editor_form: QUERY_EDITOR_FORM
			a_push_b_c: PUSH_B_C
		do
			generate_permanent_window
			form_list := object_tool_generator.form_table.linear_representation
			from
				height := 0
				width := 300
				form_list.start
			until
				form_list.after
			loop
				a_query_editor_form := form_list.item
				if a_query_editor_form.managed then
					a_query_editor_form.generate_interface_elements (0, height, perm_wind)
					height := height + a_query_editor_form.minimum_height
					width := width.max (a_query_editor_form.minimum_width)
				end
				form_list.forth
			end
			!! a_push_b_c
			a_push_b_c := a_push_b_c.create_context (perm_wind)
			a_push_b_c.set_x_y (0, height)
			a_push_b_c.set_visual_name ("OK")
			height := height + a_push_b_c.height
			perm_wind.set_size (width, height)
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
		local
			cmd: USER_CMD
			temp_string: STRING
		do
			!! cmd.make
			cmd.set_internal_name ("")
			temp_string := clone (cmd.template)
			cmd.set_eiffel_text (generated_eiffel_text (temp_string))
			cmd.set_visual_name (visual_command_name)
			cmd.overwrite_text
			command_catalog.add_to_page (cmd, command_catalog.generated_commands)
		end

	generated_eiffel_text (a_template: STRING): STRING is
			-- Generated eiffel text for associated command.
		local
			i: INTEGER
		do
			!! Result.make (0)
			Result.append ("indexing%N")
			Result.append ("%Tdescription: %" Generated command used to change %%%N%T%T%T%T%% the queries of a ")
			Result.append (application_class.class_name)
			Result.append (" object.%"%N")
			Result.append ("%Tvisual_name: %"")
			Result.append (visual_command_name)
			Result.append ("%"%N%N")
			i := a_template.substring_index ("execute", 1)
			i := a_template.substring_index ("%T%Tdo%N", i)
			Result.append (a_template.substring (1, i + 4))
			from
				form_list.start
			until
				form_list.after
			loop
				Result.append (form_list.item.generate_eiffel_text (perm_wind.entity_name))
				form_list.forth
			end
			Result.append ("%T%Tend%N%N")
			Result.append ("%Ttarget: ")
			Result.append (application_class.class_name)
			Result.append ("%N%N%Tset_target (new_target: ")
			Result.append (application_class.class_name)
			Result.append (") is%N%T%Tdo%N%T%T%Ttarget := new_target%N")

			Result.append (a_template.substring (i + 5, a_template.count))
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
