
class BEHAVIOR 

inherit

	BEHAVIOR_STONE
		
		export
			{NONE} all
		end;

	FUNCTION
		redefine
			func_editor, 
			input_stone, output_stone
		end;

	PIXMAPS
		export
			{NONE} all
		end


creation

	make

-- ************
-- Anchor types
-- ************

	
feature 

	input_stone: EVENT;

	output_stone: CMD_INSTANCE;

	func_editor: BEHAVIOR_EDITOR;

-- **************
-- Command labels
-- **************

	labels: LINKED_LIST [CMD_LABEL] is
			-- Command labels contained in Current
			-- behavior
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

-- ********
-- Creation
-- ********

	make is
		do
			set_symbol (Behavior_pixmap_small);
			!!input_list.make;
			!!output_list.make;
			int_generator.next;
			identifier := int_generator.value;
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

-- ****************
-- Editing features
-- ****************
	
feature 

	label: STRING;

	context: CONTEXT;
			-- Context associated with the behavior

	set_context (c: CONTEXT_STONE) is
			-- Set context to `c'.
		do
			context := c.original_stone
		end;

	copy_lists (func: like Current) is
		do
			copy_contents (func)
		end;

	set_label (s: STRING) is
		do
			label := s
		end;

-- **************
-- Stone features
-- **************

	
feature {NONE}

	source: WIDGET is do end;

	
feature 

	identifier: INTEGER;

	original_stone: BEHAVIOR is
		do
			Result := Current
		end;

end
