indexing

	description: 
		"General notion of an eiffel query command (semantic unity)%
		%for a class. Display output for current command for%
		%associated class to output_window.";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_CLASS_CMD

inherit

	E_OUTPUT_CMD
		rename
			make as cmd_make
		export
			{NONE} cmd_make
		redefine
			executable
		end

feature -- Initialization

	set, make (a_class: E_CLASS; st: like structured_text) is
			-- Make current command with current_class as
			-- `a_class'.
		require
			valid_a_class_c: a_class /= Void;
			valid_st: st /= Void
		do
			current_class := a_class;	
			set_structured_text (st)
		ensure
			class_set: current_class = a_class;
			structured_text_set: structured_text = st
		end;

feature -- Property

	current_class: E_CLASS
			-- Class for current action

	executable: BOOLEAN is
			-- Is the Current able to be executed?
		do
			Result := current_class /= Void and then
				structured_text /= Void
		ensure then
			good_result: Result implies current_class /= Void;
		end

feature -- Execution

	execute is
			-- Execute Current command.
		deferred
		end;

feature {NONE} -- Implementation

	sorted_list (list: LINKED_LIST [E_CLASS]): SORTED_TWO_WAY_LIST [CLASS_I] is
			-- Sorted `list' based on `class_name' from `CLASS_I'
		require
			valid_list: list /= Void
		do
			!! Result.make
			from
				list.start
			until
				list.after
			loop
				Result.put_front (list.item.lace_class);
				list.forth
			end;
			Result.sort
		ensure
			valid_Result: Result /= Void;
			sorted: Result.sorted
		end;

	add_tabs (st:STRUCTURED_TEXT; i: INTEGER) is
			-- Add `i' tabs to `structured_text'.
		local
			j: INTEGER
		do
			from
				j := 1;
			until
				j > i
			loop
				st.add_indent;
				j := j + 1
			end;
		end;

end -- class E_CLASS_CMD
