
class LABEL_SCR_L  

inherit

	COMMAND
		export
			{NONE} all
		end;
	COMMAND_ARGS
		rename First as unused,
		Second as set_show_action,
		Third as set_label_action
		export
			{NONE} all
		end;
	LABEL_STONE
		export
			{NONE} all
		redefine
			transportable
		end;
	SCROLL_LIST
		rename 
			make as list_make,
			merge_right as list_merge_right
		export
			{APP_EDITOR} all
		end;
	SCROLL_LIST
		rename		
			make as list_make
		export
			{APP_EDITOR} all
		redefine
			merge_right
		select
			merge_right
		end;
	REMOVABLE
		export
			{NONE} all
		end

creation

	make
	
feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			list_make (a_name, a_parent);
			add_button_press_action (3, Current, set_show_action);
			add_button_press_action (3, Current, set_label_action);
			initialize_transport
		end; 

feature

	label: STRING is
			-- Current label selected
		do
			if selected_item /= Void then
				from
					label_names.start;
				until
					label_names.after or else
					equal (selected_item, label_names.item)
				loop
					label_names.forth;
				end;
            	if
               		not label_names.after 
            	then
       				Result := label_names.item.label_name 
				end;
            end;
		end;

	merge_right (l: SORTED_TWO_WAY_LIST [TRAN_NAME]) is
			-- Merge right of cursor position put `l'. Construct label_names
			-- from `l'.
		require else
			not_void_l: l /= Void;
		do
				l.start;
				label_names := l.duplicate (l.count);	
				list_merge_right (l);
		end;

feature {NONE}

	remove_yourself is
		local
			cut_label_command: APP_CUT_LABEL
		do
			!!cut_label_command;
			cut_label_command.execute (selected_item);
		end;

	transportable: BOOLEAN;
			-- Is the stone able to be transported ?

	original_stone: CMD_LABEL is
		do
		end;

	symbol:PIXMAP is
		do
		end;

	source:WIDGET is
		do
			Result := Current 
		end;

	label_names: SORTED_TWO_WAY_LIST [TRAN_NAME];
			-- List of the labels names. 

feature {NONE} -- Execute

	execute (argument: ANY) is
			-- Execute the command
		do
			if
				argument = set_label_action
			then
				if
					(selected_item = Void)
				then
					transportable := false
				else
					transportable := true;
				end;
			elseif
				argument = set_show_action
			then
				transportable := false
			end
		end;

end
	
