
class STATE 

inherit

	STATE_STONE;
	FUNCTION
		redefine
			func_editor, input_stone, output_stone,
			drop_pair
		end;
	PIXMAPS;
	GRAPH_ELEMENT;
	WINDOWS;
	NAMABLE;
	EDITABLE

creation

	make

feature -- Creation

	make is
		do
			set_symbol (State_pixmap_small);
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

	input_stone: CONTEXT;

	output_stone: BEHAVIOR;

feature -- Command Labels

	labels: LINKED_LIST [CMD_LABEL] is
			-- All command labels in Current state
		local
			old_pos: INTEGER;
			sublist: LINKED_LIST [CMD_LABEL]
		do
			!!Result.make;
			from
				old_pos := position;
				start
			until
				off
			loop
				sublist := output.labels;
				from
					sublist.start
				until
					sublist.after
				loop
					Result.put_right (sublist.item);
					sublist.forth
				end;
				forth
			end;
			go_i_th (old_pos)
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
			if
				pair_is_valid
			then
				add (input_stone, output_stone);
				!!drop_pair_command;
				drop_pair_command.execute (Current);
				func_editor.reset_stones;
			elseif
				output_set and then output_stone.context /= Void and then
				(not has_input (output_stone.context.original_stone))
			then
				set_input_stone (output_stone.context.original_stone);
				add (input_stone, output_stone);
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

	copy_lists (func: like Current) is
		do
			copy_contents (func)
		end;

-- **************
-- Stone features
-- **************

	
feature {NONE}

	source: WIDGET is do end;

	
feature 

	original_stone: STATE is
		do
			Result := Current
		end;

end
