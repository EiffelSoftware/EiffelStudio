indexing
	description: "Generate object tool."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	GENERATE_OBJECT_TOOL_CMD
	
	--| FIXME Extracted from the released version of Build.
	--| A lot of code has been removed.
	--| Some of the generated class texts should be tidied up.
	--| We need a way to allow a user to assign a name for the class.

inherit

	SHARED_CLASS_IMPORTER
	
	WINDOWS

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
			file: PLAIN_TEXT_FILE
		do
			application_class := object_tool_generator.edited_class
			form_list := object_tool_generator.form_table.linear_representation
			create file.make_open_write ("D:\work\object_editor\generated_window\generated_window.e")
			file.putstring (generated_eiffel_text)
			file.close
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
		end

	visual_command_name: STRING is
			-- Visual name of the generated command.
		local
			cl_name: STRING
		do
			create Result.make (0)
			Result.append ("set_")
			cl_name := clone (application_class.class_name)
			cl_name.to_lower
			Result.append (cl_name)
			Result.append ("_object_cmd")	
		end

feature -- Tool generation

	generate_interface is
			-- Generate the interface elements.
		do
		end


	generate_command is
			-- Generate the associated command.
		do
		end

	generated_eiffel_text: STRING is
			-- Generated eiffel text for associated command.
		do
			create Result.make (0)
			Result.append (indexing_clause)
			Result.append (class_declaration)
			Result.append (feature_execute)
			Result.append (feature_display_error_message)
			Result.append (initialization_clause)
			
			Result.append (access_clause)
			Result.append (implementation_clause)
			Result.append (end_class_clause)
		end

feature {NONE} -- Code generation

	indexing_clause: STRING is
			-- Generate indexing clause.
		local
			class_name: STRING
		do
			class_name := clone (application_class.class_name)
			create Result.make (0)
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
		local
			class_name: STRING
		do
			class_name := "GENERATED_CLASS"
			class_name.to_upper
			create Result.make (0)
			Result.append ("class%N%N%T")
			Result.append (class_name)
			Result.append ("%N%Ninherit%N%N%TEV_TITLED_WINDOW%N%Ncreation%N%N%Tmake%N%Nfeature%N%N")
		end
		
	implementation_clause: STRING is
			-- Generate an implementation clause.
		do
			create Result.make (0)
			Result.append ("feature -- Implementation%N%N")
			Result.append ("%Tbutton: EV_BUTTON%N%N")
			Result.append ("%Tmessage_displayed: BOOLEAN%N%N")
			form_list := object_tool_generator.form_table.linear_representation
			from
				form_list.start
			until
				form_list.after
			loop
				Result.append (form_list.item.generate_interface_elements)	
				form_list.forth
			end
		end
		
	access_clause: STRING is
			-- Generate an access clause.
		do
			create Result.make (0)
			Result.append ("feature -- Access%N%N")
			Result.append ("%Ttarget: " + class_type_name + "%N%N")
			Result.append ("%Tset_target (a_target: " + class_type_name + ") is%N")
			Result.append ("%T%Trequire%N")
			Result.append ("%T%T%Ta_target /= Void%N")
			Result.append ("%T%Tdo%N%T%T%Ttarget := a_target%N%T%Tend%N%N")
			Result.append ("%Ttarget_set: BOOLEAN is%N%T%Tdo%N%T%T%TResult := target /= Void%N%T%Tend%N%N")
		end
		


	feature_execute: STRING is
			-- Generate feature `execute'.
		local
			a_query_editor_form: QUERY_EDITOR_FORM
			argument_namer: LOCAL_NAMER
		do
			create argument_namer.make ("argument")
			create Result.make (0)
			Result.append ("%Texecute is%N%T%Trequire else%N%T%T%Ttarget_set: target_set%N%T%T%N")
			Result.append ("%T%Tlocal%N%T%T%Tprecondition: BOOLEAN%N%T%Tdo%N") 
			Result.append ("%T%T%Tmessage_displayed := False%N")
			from
				form_list.start
			until
				form_list.after
			loop
				a_query_editor_form := form_list.item
				argument_namer.next
				Result.append (a_query_editor_form.generate_eiffel_text (argument_namer))
				form_list.forth
			end
			Result.append ("%T%Tend%N%N")
		end
		
	feature_display_error_message: STRING is 
			-- Display a dialog with the error_message.
		do
			create Result.make (0)
			Result.append ("%Tdisplay_error_message(message: STRING; a_parent: EV_CONTAINER) is%N")
			Result.append ("%T%Tlocal%N%T%T%Terror_dialog: EV_ERROR_DIALOG%N")
			Result.append ("%T%Tdo%N")
			Result.append ("%T%T%Tif not message_displayed then%N")
			Result.append ("%T%T%T%Tcreate error_dialog.make_with_text (message)%N")
			Result.append ("%T%T%T%Terror_dialog.show_modal_to_window (Current)%N")
			Result.append ("%T%T%T%Tmessage_displayed := True%N")
			Result.append ("%T%T%Tend%N")
			Result.append ("%T%Tend%N")
		end
		
		
	initialization_clause: STRING is
			-- Generate an Initialization clause.
		local
			a_query_editor_form: QUERY_EDITOR_FORM
		do
			create Result.make (0)
			Result.append ("%Tmake is%N")
			Result.append ("%T%Tlocal%N%T%T%Tvertical_box: EV_VERTICAL_BOX%N%T%T%Thorizontal_box: EV_HORIZONTAL_BOX%N%T%T%Tlabel: EV_LABEL%N%T%T%Tlist_item: EV_LIST_ITEM%N")
			Result.append ("%T%Tdo%N")
			Result.append ("%T%T%Tdefault_create%N")
			Result.append ("%T%T%Tcreate vertical_box%N")
			from
				form_list.start
			until
				form_list.after
			loop
				a_query_editor_form := form_list.item
				Result.append (a_query_editor_form.build_interface ("vertical_box"))
				form_list.forth
			end
			Result.append_string ("%T%T%Textend (vertical_box)%N")
			Result.append_string ("%T%T%Tcreate button.make_with_text (%"Build%")%N")
			Result.append_string ("%T%T%Tvertical_box.extend (button)%N")
			Result.append_string ("%T%T%Tbutton.select_actions.extend (agent execute)%N")
			Result.append ("%T%Tend%N%N")
		end

	invariant_clause: STRING is
			-- Generate an Invariant clause.
		do
			create Result.make (0)
			Result.append ("invariant%N%N%Ttarget_exist_if_set: target_set implies (target /= Void)%N%N")
		end

	end_class_clause: STRING is
			-- Generate an End of class.
		do
			create Result.make (0)
			Result.append ("end -- class ")
			Result.append ("MY_TEST")
			Result.append ("%N")
		end

feature -- Attributes

	application_class: APPLICATION_CLASS
			-- Class for which a tool has been generated

feature {NONE} -- Attributes

	form_list: ARRAYED_LIST [QUERY_EDITOR_FORM]
			-- List of QUERY_EDITOR_FORM; need to generate interface
			-- element if corresponding QUERY_EDITOR_FORM is managed

end -- class GENERATE_OBJECT_TOOL_CMD
