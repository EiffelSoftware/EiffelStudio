
class STATE 

inherit

	FUNCTION
		redefine
			func_editor, input_data, output_data,
			drop_pair
		end;
	GRAPH_ELEMENT;
	WINDOWS;
	NAMABLE;
	EDITABLE

creation

	make

feature -- Creation

	make is
		do
			!!input_list.make;
			!!output_list.make;
			int_generator.next;
			identifier := int_generator.value;
		end;

	reset_namer is
		do
			namer.reset;
			int_generator.reset;
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.state_pixmap_small
		end;

	help_file_name: STRING is
		do
			Result := Help_const.state_help_fn
		end;

feature -- Editable

	create_editor is
		local
			ed: STATE_EDITOR
		do
			if not edited then
				ed := window_mgr.state_editor;
				ed.set_edited_function (Current);
			end;
			window_mgr.display (func_editor)
		end;

feature -- Anchors

	func_editor: STATE_EDITOR;

	input_data: CONTEXT;

	output_data: BEHAVIOR;

feature -- Command Labels

	labels: LINKED_LIST [CMD_LABEL] is
			-- All command labels in Current state
		local
			old_pos: INTEGER;
			sublist: LINKED_LIST [CMD_LABEL]
		do
			!!Result.make;
			from
				old_pos := output_list.index;
				output_list.start
			until
				output_list.after
			loop
				sublist := output_list.item.labels;
				from
					sublist.start
				until
					sublist.after
				loop
					Result.put_right (sublist.item);
					sublist.forth
				end;
				output_list.forth
			end;
			output_list.go_i_th (old_pos)
		end;

	identifier: INTEGER;

	set_internal_name (s: STRING) is
		do
			if s.empty then
				namer.next;
				set_label (namer.value)
			else
				set_label (s);
			end;
		end;

feature {NONE}

	int_generator: INT_GENERATOR is
		once
			!!Result
		end;

	namer: NAMER is
			-- Unique strings generator
		once
			!!Result.make ("State")
		end;

feature -- Query

	has_command (cmd: CMD): BOOLEAN is
		local
			old_pos: INTEGER;
		do
			old_pos := output_list.index;
			from
				output_list.start
			until
				output_list.after
			loop
				Result := output_list.item.has_command (cmd);
				output_list.forth
			end;
			output_list.go_i_th (old_pos)
		end;

feature -- Editing

	internal_name: STRING;

	visual_name: STRING;

	behaviors: LINKED_LIST [BEHAVIOR] is
			-- Non empty behaviors defined
			-- in Current state
		do
			!!Result.make;
			from
				start
			until
				after
			loop
				if 
					not (output.empty or input.deleted)
				then
					Result.put_right (output)
				end;
				forth	
			end;
		end;

	drop_pair is
		local
			drop_pair_command: FUNC_DROP;
		do
			if pair_is_valid then
				add (input_data, output_data);
				!!drop_pair_command;
				drop_pair_command.execute (Current);
				func_editor.reset_stones;
			elseif
				output_set and then output_data.context /= Void and then
				(not has_input (output_data.context.data))
			then
				set_input_data (output_data.context.data);
				add (input_data, output_data);
				!!drop_pair_command;
				drop_pair_command.execute (Current);
				func_editor.reset_stones;
			end;
		end;

	edited: BOOLEAN is
			-- Is currrent State being edited?
		do
			Result := not (func_editor = Void)
		end;

	label: STRING is
			-- Just kept for historical purposes
		do
			if visual_name = Void then
				Result := internal_name
			else
				Result := visual_name
			end
		end;

	raise_editor is
		do
			if
				not (func_editor = Void)
			then
				func_editor.raise
			end
		end;

	set_label (s: STRING) is
		do
			internal_name := s
		end;

	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void
			else
				visual_name := clone (s);
			end;
			app_editor.update_circle_text (Current);
		end;

	retrieve_set_visual_name (s: STRING) is
		require
			valid_s: s /= Void
		do
			visual_name := clone (s);
		end;

	copy_lists (func: like Current) is
		do
			copy_contents (func)
		end;	
	
feature 

	data: STATE is
		do
			Result := Current
		end;

end
