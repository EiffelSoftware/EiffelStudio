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
			height, width: INTEGER
			a_query_editor_form: QUERY_EDITOR_FORM
			a_push_b_c: PUSH_B_C
		do
			application_class := object_tool_generator.edited_class
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
