
class STATE_SCR_L 

inherit

	COMMAND;
	COMMAND_ARGS
		rename 
			First as First_arg
		end;
	DRAG_SOURCE
		redefine
			transportable
		end;
	HOLE
		rename
			target as source
		redefine
			process_state
		select
			init_toolkit
		end;
	STATE_STONE;
	SCROLLABLE_LIST
		rename 
			identifier as oui_identifier,
			make as list_create,
			init_toolkit as scroll_list_init_toolkit
		end;
		
	REMOVABLE

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE; editor: APP_EDITOR) is
			-- Create the state_scr_list.
		do
			list_create (a_name, a_parent);
			compare_objects;
			application_editor := editor;
			register;
			add_button_press_action (3, Current, Void);
			initialize_transport;
		end; -- Create
	
feature 

	data: BUILD_STATE;
			-- Current data

feature {NONE} -- Stone

	source: STATE_SCR_L is
		do
			Result := Current
		end;

	transportable: BOOLEAN;
			-- Is the data able to be transported ?

feature {NONE} -- Removable

	remove_yourself is
		local
			cut_figure_command: APP_CUT_FIGURE
		do
			!! cut_figure_command.make (selected_circle)
			cut_figure_command.execute (Void)
		end;
	
feature 

	selected_circle: STATE_CIRCLE;
			-- Current state_figure 

	set_selected (c: STATE_CIRCLE) is
			-- Set selected_circle to `c'.
		do
			selected_circle := c	
		end; -- set_figure

feature {NONE}

	application_editor: APP_EDITOR;

	process_state (dropped: STATE_STONE) is
		do
			application_editor.update_selected (dropped.data)
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
				data := selected_circle.data;
				transportable := true;
			end;
		end; -- execute

end -- class LABEL_SCR_L
	
