
class LABEL_SCR_L  

inherit

	COMMAND;
	COMMAND_ARGS
		rename 
			First as unused,
			Second as set_show_action,
			Third as set_label_action
		end;
	DRAG_SOURCE;
	LABEL_STONE;
	SCROLLABLE_LIST
		rename 
			make as list_make,
			merge_right as list_merge_right
		export
			{APP_EDITOR} all
		end;
	SCROLLABLE_LIST
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

creation

	make
	
feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			list_make (a_name, a_parent);
			!! label_names.make 
			compare_objects;
			add_button_press_action (3, Current, set_show_action);
			add_button_press_action (3, Current, set_label_action);
			initialize_transport;
			set_visible_item_count (7);
		end; 

feature

	selected_label: STRING is
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
				if not label_names.after  then
	   				Result := label_names.item.cmd_label.label
				end;
			end;
		end;

	merge_right (l: ARRAYED_LIST [TRAN_NAME]) is
			-- Merge right of cursor position put `l'. Construct label_names
			-- from `l'.
		do
			l.start;
			from
				l.start
			until
				l.after
			loop
				label_names.extend (l.item)
				l.forth
			end
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

	data: CMD_LABEL;

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
			if argument = set_label_action then
				data := Void;
				if selected_item /= Void then
					from
						label_names.start;
					until
						label_names.after or else
						equal (selected_item, label_names.item)
					loop
						label_names.forth;
					end;
					if not label_names.after  then
	   					data := label_names.item.cmd_label
					end
				end;
			elseif argument = set_show_action then
				data := Void;
			end
		end;

end
	
