indexing
	description: "Hole used in the command catalog, used also %
				% to create a new command."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CMD_CAT_ED_H 

inherit

	HOLE
		redefine
			process_instance, process_command, compatible 
		select
			init_toolkit
		end
	EB_BUTTON_COM
	STONE
	DRAG_SOURCE

creation

	make

feature {NONE}

	data: DATA is
		do
		end

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.command_cursor
		end

	stone_type: INTEGER is
		do
		end

	compatible (st: STONE): BOOLEAN is
		do
			Result :=
				st.stone_type = Stone_types.command_type or else
				st.stone_type = Stone_types.instance_type
		end

	process (hole: HOLE) is
		do
		end
	
	process_command (cmd_stone: CMD_STONE) is
		do
			cmd_stone.data.create_editor
		end

	process_instance (cmd_instance: CMD_INST_STONE) is
		do
			cmd_instance.associated_command.create_editor
		end

feature {NONE}

	create_focus_label is
		do
			set_focus_string (Focus_labels.create_edit_label)
		end

	target, source: WIDGET is
		do
			Result := Current
		end

	make (a_parent: COMPOSITE) is
		do
			make_visible (a_parent)
			initialize_transport
			initialize_focus
			register
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_pixmap
		end
	
feature {NONE}

	execute (argument: ANY) is
		local
			doc: EB_DOCUMENT
			cmd: USER_CMD
		do
			!!cmd.make
			cmd.set_internal_name ("")
			cmd.set_eiffel_text (cmd.template)
			cmd.overwrite_text
			--cmd.retrieve_text_from_disk
--			!!doc
--			doc.set_directory_name (Environment.commands_directory)
--			doc.set_document_name (cmd.eiffel_type)
--			doc.save_text (cmd.template)
--			doc.update (cmd.template)
			command_catalog.add (cmd)
		end

end
