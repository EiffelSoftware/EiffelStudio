
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

inherit

	DATA
	
feature -- Anchors

	input_data, output_data: DATA;
			-- Data (dropped information) 
			-- comming from the entry holes
			-- of a function editor.

	input_list: EB_LINKED_LIST [like input_data];
			-- Input list representation of the
			-- function.

	output_list: EB_LINKED_LIST [like output_data];
			-- Output list representation of the
			-- function.

feature {FUNC_EDITOR, FUNC_COMMAND} -- Function Editor

	func_editor: FUNC_EDITOR;
			-- Editor used for editing Current
	
	drop_pair is
			-- Append input_data and output_data
			-- to corresponding lists input_list
			-- and output_list.
		require
			valid_editor: func_editor /= Void
		local
			drop_command: FUNC_DROP
		do
			if pair_is_valid then
				add (input_data, output_data)
				!!drop_command;
				drop_command.execute (Current);
--				accept_pair;
				reset_input_data
				reset_output_data
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
				input_list.start
			until
				input_list.after
			loop
				il.put_right (input_list.item);
				il.forth;
				input_list.forth
			end;
			input_list := il;
			from
				!!ol.make;
				output_list.start
			until
				output_list.after
			loop
				ol.put_right (output_list.item);
				ol.forth;
				output_list.forth
			end;
			output_list := ol
		end;

feature {NONE} -- Function Editor

	accept_pair is
			-- If the element in the input hole
			-- has not already been entered, 
			-- and if both input and output are
			-- set then include the pair 
			-- composed ofthe two datas
			-- in the function.
		require
			Valid_pair: pair_is_valid;
			valid_editor: func_editor /= Void
		local
			old_pos: INTEGER
		do
			add (input_data, output_data);
			reset_input_data;
			reset_output_data;
		end;

feature -- Insertion and Delections

	add_element_line (i: INTEGER; input_d, output_d: data) is
			-- Add `input_st' and `output_st' at line
			-- `position' in input_list and output_list.
		do
			if not has_input (input_d) then
				if i = 1 and input_list.empty then
					add (input_d, output_d);
				else
					go_i_th (i - 1);
					put_right (input_d, output_d);
				end;
			end
		end; 

	remove_element_line (elt: like input_data; is_command: BOOLEAN) is
			-- Remove the element line that has `elt' as either
			-- as the input or output element. If `is_command' is
			-- True then insert into the history list for the
			-- removal of the line.
		local
			cut_elt_line_cmd: FUNC_CUT;
		do
			find_input (elt);
			if not input_list.after then
				if is_command then
					!!cut_elt_line_cmd;
					cut_elt_line_cmd.execute (Current);
				end;
				remove;
				if func_editor /= Void then
					func_editor.display_page_number
				end
			end
		end;

feature -- Input and Output datas 
		
	find_input (elt: like input_data) is
			-- Find `elt'. If not found, 
			-- cursor ends up after.
		local
			pos: INTEGER
		do
			from
				input_list.start;
			until
				input_list.after or else
				input_list.item = elt
			loop
				input_list.forth
			end;
			if not input_list.after then
				pos := input_list.index;
				output_list.go_i_th (pos);
			end
		end;

	has_output (o: like output_data): BOOLEAN is
			-- Does the function already contain
			-- the element contained in the input
			-- hole?
		do
			Result := has_data (output_list, o);
		end;

	has_input (i: like input_data): BOOLEAN is
			-- Does the function already contain
			-- the element contained in the input
			-- hole?
		local
			old_pos: INTEGER
		do
			Result := has_data (input_list, i);
		end;

	input: like input_data is 
			-- Current item in input_list
		require
			Not_off: not off
		do 
			Result := input_list.item;
		end;

	output: like output_data is 
			-- Current item in output_list
		require
			Not_off: not off
		do 
			Result := output_list.item
		end;
	
	reset_input_data is
			-- `Forget' the input_data 
		do
			input_data := Void;
		end;

	reset_output_data is
			-- `Forget' the output_data and
			-- set output_set to False.
		do
			output_data := Void;
		end;

	set_input_data (s: like input_data) is
			-- Set `input_data' to `s'.
		do
			input_data := s;
		ensure
			input_data_set: input_data = s
		end;

	set_output_data (s: like output_data) is
			-- Set `input_data' to `s'.
		do
			output_data := s;
		ensure
			output_data_set: output_data = s
		end;

feature {NONE}

	input_set: BOOLEAN is
			-- Does the input hole
			-- contain a data?
		do
			Result := input_data /= Void
		end

	output_set: BOOLEAN is
			-- Does the input hole
			-- contain a data?
		do
			Result := output_data /= Void
		end;

	input_list_put (elt: DATA) is
		do
			input_list.put (elt);			
		end;

	output_list_put (elt: DATA) is
		do
			output_list.put (elt);			
		end;

	pair_is_valid: BOOLEAN is
		do
			Result := (input_set and output_set) and then
				(not has_input (input_data))
		end;

	
	has_data (l: EB_LINKED_LIST [DATA]; s: DATA): BOOLEAN is
			-- Does the `l' contain data `s'. 
		local
			old_pos: CURSOR
		do
			if s /= Void then
				from
					old_pos := l.cursor;
					l.start
				until
					l.after or else Result
				loop
					Result := l.item =  s;
					l.forth
				end;
				l.go_to (old_pos)
			end;
		end;

feature -- List operations

	add (i: like input_data; o: like output_data) is
			-- Append the pair (`i', `o') to Current
			-- function.
		require
			Consistency: not has_input (i)
		do
			input_list.extend (i);
			output_list.extend (o);
		end;

	put_right (i: like input_data; o: like output_data) is
			-- Add right  the pair (`i', `o') to Current
			-- function.
		require
			Consistency: not has_input (i);
			list_have_same_index: input_list.index = output_list.index
		do
			input_list.put_right (i);
			output_list.put_right (o);
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
			il, ol: EB_LINKED_LIST [DATA];
			c: INTEGER;
			merge_command: FUNC_MERGE;
		do
			if other /= Current and then
				(not other.input_list.empty)
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
						input_list.item = il.item
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
				if not il.empty then
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
			old_pos: CURSOR
		do
			input_list.remove;
			output_list.remove;
			from
				old_pos := input_list.cursor;
				input_list.start;
			until
				input_list.after
			loop
				input_list.forth
			end;
			input_list.go_to (old_pos)
		ensure
			same_count: input_list.count = input_list.count
		end; -- remove

feature -- data

	data: data is
		deferred
		end;

	set_label (s: STRING) is
		deferred
		end;

end
