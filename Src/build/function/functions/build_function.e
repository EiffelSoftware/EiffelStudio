
--===================================================================
--
-- Last revision: 07/30/92
--
-- General notion of function.
-- Represented graphically by two adjacent columns
-- indicating associations between input and output
-- elements.
-- The main consistency requirement for a function
-- is that a given element may appear at most once 
-- as input.
--
--===================================================================

deferred class FUNCTION  
	
feature -- Anchors

	input_stone, output_stone: STONE;
			-- Stones (dropped information) 
			-- comming from the entry holes
			-- of a function editor.

	input_list: EB_LINKED_LIST [like input_stone];
			-- Input list representation of the
			-- function.

	output_list: EB_LINKED_LIST [like output_stone];
			-- Output list representation of the
			-- function.

feature {FUNC_EDITOR, FUNC_COMMAND} -- Function Editor

	func_editor: FUNC_EDITOR;
			-- Editor used for editing Current
	
	drop_pair is
			-- Append input_stone and output_stone
			-- to corresponding lists input_list
			-- and output_list.
		require
			valid_editor: func_editor /= Void
		local
			drop_command: FUNC_DROP
		do
			if
				pair_is_valid
			then
				accept_pair;
				!!drop_command;
				drop_command.execute (Current);
				func_editor.reset_stones
			end
		end;

	reset is
			-- `Forget' the func_editor.
		do
			func_editor := Void
		end;

	set_editor (ed: like func_editor) is
			-- Set func_editor to `ed'.
		require
		 	valid_ed: (ed /= Void)	
		do
			func_editor := ed
		end; -- set_editor

	set_lists (il, ol: like input_list) is
			-- Set input_list to `il' and
			-- set output_list to `ol'.
		do
			input_list := il;
			output_list := ol;
		end;

	save_lists is
			-- Save lists. (This is required
			-- since the dynamic type is of
			-- type EB_BOX).
		require
			valid_editor: func_editor /= Void
		local
			il, ol: like input_list
		do
			from
				!!il.make;
				input_list.finish
			until
				input_list.before
			loop
				il.add_right (input_list.item);
				input_list.back
			end;
			input_list := il;
			from
				!!ol.make;
				output_list.finish
			until
				output_list.before
			loop
				ol.add_right (output_list.item);
				output_list.back
			end;
			output_list := ol
		end;

feature {NONE} -- Function Editor

	accept_pair is
			-- If the element in the input hole
			-- has not already been entered, 
			-- and if both input and output are
			-- set then include the pair 
			-- composed ofthe two stones
			-- in the function.
		require
			Valid_pair: pair_is_valid;
			valid_editor: func_editor /= Void
		local
			old_pos: INTEGER
		do
			add (input_stone, output_stone);
			reset_input_stone;
			reset_output_stone;
		end;

feature -- Insertion and Delections

	add_element_line (i: INTEGER; input_st, output_st: STONE) is
			-- Add `input_st' and `output_st' at line
			-- `position' in input_list and output_list.
		do
			if not has_input (input_st) then
				if i = 1 and input_list.empty then
					add (input_st, output_st);
				else
					go_i_th (i - 1);
					add_right (input_st, output_st);
				end;
			end
		end; 

	remove_element_line (elt: like input_stone; is_command: BOOLEAN) is
			-- Remove the element line that has `elt' as either
			-- as the input or output element. If `is_command' is
			-- True then insert into the history list for the
			-- removal of the line.
		local
			cut_elt_line_cmd: FUNC_CUT;
		do
			find_input (elt);
			if
				not input_list.after
			then
				if
					is_command
				then
					!!cut_elt_line_cmd;
					cut_elt_line_cmd.execute (Current);
				end;
				remove;
			end
		end;

feature -- Input and Output stones 
		
	find_input (elt: like input_stone) is
			-- Find `elt'. If not found, 
			-- cursor ends up after.
		local
			pos: INTEGER
		do
			from
				input_list.start;
			until
				input_list.after or else
				(elt.equivalent (input_list.item))
			loop
				input_list.forth
			end;
			if
				not input_list.after
			then
				pos := input_list.index;
				output_list.go_i_th (pos);
			end
		end;

	has_output (o: like output_stone): BOOLEAN is
			-- Does the function already contain
			-- the element contained in the input
			-- hole?
		do
			Result := has_stone (output_list, o);
		end;

	has_input (i: like input_stone): BOOLEAN is
			-- Does the function already contain
			-- the element contained in the input
			-- hole?
		local
			old_pos: INTEGER
		do
			Result := has_stone (input_list, i);
		end;

	input: like input_stone is 
			-- Current item in input_list
		require
			Not_off: not off
		do 
			Result := input_list.item.original_stone
		end;

	output: like output_stone is 
			-- Current item in output_list
		require
			Not_off: not off
		do 
			Result := output_list.item.original_stone
		end;

	
	reset_input_stone is
			-- `Forget' the input_stone and
			-- set input_set to False.
		do
			input_set := False;
			input_stone := Void;
		end;

	reset_output_stone is
			-- `Forget' the output_stone and
			-- set output_set to False.
		do
			output_set := False;
			output_stone := Void;
		end;

	set_input_stone (s: like input_stone) is
			-- Set `input_stone' to `s'.
		do
			input_set := True;
			input_stone := s.original_stone;
		end;

	set_output_stone (s: like output_stone) is
			-- Set `input_stone' to `s'.
		do
			output_set := True;
			output_stone := s.original_stone;
		end;

	copy_lists (func: STONE) is
			-- Copy the contents of `func' into edited function.
		deferred
		end;

feature {NONE}

	input_set, output_set: BOOLEAN;
			-- Does the input (output) hole
			-- contain a stone?

	input_list_put (elt: STONE) is
		do
			input_list.put (elt);			
		end;

	output_list_put (elt: STONE) is
		do
			output_list.put (elt);			
		end;

	pair_is_valid: BOOLEAN is
		do
			Result := (input_set and output_set) and then
				(not has_input (input_stone))
		end;

	
	has_stone (l: EB_LINKED_LIST [STONE]; s: STONE): BOOLEAN is
			-- Does the `l' contain stone `s'. 
		local
			old_pos: INTEGER
		do
			if not (s = Void) then
				from
					old_pos := l.index;
					l.start
				until
					l.after or else Result
				loop
					Result := l.item.equivalent (s);
					l.forth
				end;
				l.go_i_th (old_pos)
			end;
		end;

	copy_contents (func: like Current) is
		local
			il, ol: like input_list;
		do
			il := func.input_list;
			ol := func.output_list;
			from
				il.start;
				ol.start;
			until
				il.after
			loop
				add (il.item, ol.item);
				il.forth
			end
		end; 

feature -- List operations

	add (i: like input_stone; o: like output_stone) is
			-- Append the pair (`i', `o') to Current
			-- function.
		require
			Consistency: not has_input (i)
		do
			input_list.add (i);
			output_list.add (o);
		end;

	add_right (i: like input_stone; o: like output_stone) is
			-- Add right  the pair (`i', `o') to Current
			-- function.
		require
			Consistency: not has_input (i);
			list_have_same_index: input_list.index = output_list.index
		do
			input_list.add_right (i);
			output_list.add_right (o);
		end;

	empty: BOOLEAN is
			-- Is current function empty?
		do
			Result := (input_list.empty or output_list.empty)
		end;

	finish is
			-- Move cursor position to first item
			-- in input_list and output_list.
		do
			input_list.finish;
			output_list.finish
		end; -- finish

	forth is
			-- Move cursor forward one position
			-- in input_list or output_list.
		require
			Not_off: not off
		do
			input_list.forth;
			output_list.forth
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to position `i' in 
			-- input_list or output_list.
		do
			input_list.go_i_th (i);
			output_list.go_i_th (i);
		end;

	off: BOOLEAN is
			-- Is cursor position off in 
			-- input_list or output_list.
		do
			Result := (input_list.off or output_list.off)
		end;

	after: BOOLEAN is
			-- Is cursor position after in 
			-- input_list or output_list.
		do
			Result := (input_list.after or output_list.after)
		end;

	merge (other: like Current) is
			-- Merge `other' to Current.
		local
			il, ol: EB_LINKED_LIST [STONE];
			c: INTEGER;
			merge_command: FUNC_MERGE;
		do
			if
				not (other = Current)
				and (not other.input_list.empty)
			then
				c := other.input_list.count;
				other.input_list.start;
				il := other.input_list.duplicate;
				other.output_list.start;
				ol := other.output_list.duplicate;
				-- remove duplicates
				from
					il.start;
					ol.start
				until
					il.after
				loop
					from
						input_list.start
					until
						input_list.after or else
						input_list.item.equivalent (il.item)
					loop
						input_list.forth
					end;
					if
						not input_list.after
					then
						il.remove;
						ol.remove;
					else
						il.forth;
						ol.forth
					end;
				end;
				if
					not il.empty
				then
					!!merge_command;
					merge_command := clone (merge_command);
					merge_command.set_old_lists
						(input_list, output_list);
					input_list.merge (il);
					output_list.merge (ol);
					merge_command.execute (Current);
				end
			end
		end;

	position: INTEGER is
			-- Current position in input_list
		do
			Result := input_list.index
		end;

	start is
			-- Move cursor position to first item 
			-- in input_list and output_list.
		do
			input_list.start;
			output_list.start;
		end;

	wipe_out is
			-- Empty input_list and output_list.
		do
			input_list.wipe_out;
			output_list.wipe_out;
		end;

	set (i, o: like input_list) is
			-- Set input_list to `i' and
			-- output_list to `o'.
		do
			input_list.set (i);
			output_list.set (o);
		end;

feature {NONE}

	count: INTEGER is
			-- Number of elements in function
		do
			Result := input_list.count 
		end;

	remove is
			-- Remove item in input_list and output_list at 
			-- cursor position.
		local
			old_pos: INTEGER
		do
			input_list.remove;
			output_list.remove;
			from
				old_pos := input_list.index;
				input_list.start;
			until
				input_list.after
			loop
				input_list.forth
			end;
			input_list.go_i_th (old_pos)
		ensure
			same_count: input_list.count = input_list.count
		end; -- remove

feature -- Stone

	original_stone: STONE is
		deferred
		end;

	label: STRING is
		deferred
		end;

	set_label (s: STRING) is
		deferred
		end;

	symbol: PIXMAP;

	set_symbol (s: PIXMAP) is
		do
			symbol := s
		end;

end
