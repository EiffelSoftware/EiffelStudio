
class EB_BG_COLOR_TF 

inherit

	EB_TEXT_FIELD
		rename
			make as old_create
		undefine
			init_toolkit
		end;
	HOLE
		redefine
			stone, compatible
		end;
	CONSTANTS

creation

	make

	
feature {NONE}

	editor: CONTEXT_EDITOR;

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE; cmd: COMMAND; an_editor: CONTEXT_EDITOR) is
		do
			editor := an_editor;
			old_create (a_name, a_parent, cmd, an_editor);
			register;
		end;

	
feature {NONE}

	stone: EB_COLOR;
	
	compatible (s: EB_COLOR): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	target: WIDGET is
		do
			Result := Current
		end;

	process_stone is
		local
			a_context: CONTEXT;
			cmd: BG_STONE_CMD;
		do
			a_context := editor.edited_context;
			!!cmd;
			cmd.execute (a_context);
			a_context.set_bg_color_name (stone.color_name);
			context_catalog.update_editors (a_context, Context_const.color_form_nbr);
		end;

end

