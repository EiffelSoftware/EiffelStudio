
class STATE_SCR_L 

inherit

	COMMAND;
	COMMAND_ARGS
		rename 
			First as First_arg
		end;
	HOLE
		rename
			target as source
		redefine
			stone, compatible
		end;
	STATE_STONE
		redefine
			transportable
		end;
	SCROLL_LIST
		rename 
			identifier as oui_identifier,
			make as list_create
		end;
	REMOVABLE

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE; editor: APP_EDITOR) is
			-- Create the state_scr_list.
		do
			list_create (a_name, a_parent);
			application_editor := editor;
			register;
			add_button_press_action (3, Current, Void);
			initialize_transport;
		end; -- Create
	
feature 

	original_stone: STATE;
			-- Current original_stone

feature {NONE} -- Stone

	stone: STATE_STONE;
	
	compatible (s: STATE_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	source: STATE_SCR_L is
		do
			Result := Current
		end;

	transportable: BOOLEAN;
			-- Is the original_stone able to be transported ?

	label: STRING is
		do
			Result := original_stone.label
		end;

	labels: LINKED_LIST [CMD_LABEL] is
		do
		end;

	symbol: PIXMAP is
		do
			Result := original_stone.symbol
		end;

feature {NONE} -- Removable

	remove_yourself is
		local
			cut_figure_command: APP_CUT_FIGURE
		do
			!!cut_figure_command;
			cut_figure_command.execute (selected_circle)
		end;

	
feature 

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

	selected_circle: STATE_CIRCLE;
			-- Current state_figure 

	set_selected (c: STATE_CIRCLE) is
			-- Set selected_circle to `c'.
		do
			selected_circle := c	
		end; -- set_figure

feature {NONE}

	application_editor: APP_EDITOR;

	process_stone is
		do
			application_editor.update_selected (stone.original_stone)
		end; -- process_stone

	
feature {NONE} -- Execute

	execute (argument: ANY) is
			-- Execute the command
		do
			if
				(selected_circle = Void)
			then
				transportable := false
			else
				original_stone := selected_circle.original_stone;
				transportable := true;
			end;
		end; -- execute

end -- class LABEL_SCR_L
	
