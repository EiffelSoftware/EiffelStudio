
class BEHAVIOR 

inherit

	FUNCTION
		redefine
			func_editor, 
			input_data, output_data
		end;

creation

	make

feature {NONE}

	make is
		do
			!!input_list.make;
			!!output_list.make;
			int_generator.next;
			identifier := int_generator.value;
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.behavior_pixmap
		end;

	help_file_name: STRING is
		do
			Result := Help_const.behavior_help_fn
		end;
	
feature 

	input_data: EVENT;

	output_data: CMD_INSTANCE;

	func_editor: BEHAVIOR_EDITOR;

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
				Result := output_list.item.associated_command = cmd;
				output_list.forth
			end;
			output_list.go_i_th (old_pos)
		end;

feature -- Command labels

	labels: LINKED_LIST [CMD_LABEL] is
			-- Command labels contained in Current
			-- behavior
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
			!!Result.make ("Behavior")
		end;

feature  -- Editing features

	label: STRING;

	context: CONTEXT;
			-- Context associated with the behavior

	set_context (c: CONTEXT_STONE) is
			-- Set context to `c'.
		do
			context := c.data
		end;

	copy_lists (func: like Current) is
		do
			copy_contents (func)
		end;

	set_label (s: STRING) is
		do
			label := s
		end;

feature -- Datum features

	identifier: INTEGER;

	data: BEHAVIOR is
		do
			Result := Current
		end;

end
