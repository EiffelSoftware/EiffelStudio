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
			executable, execute
		end

feature -- Initialization

	make (a_class: CLASS_C) is
			-- Make current command with current_class as
			-- `a_class'.
		require
			valid_a_class_c: a_class /= Void
			compiled_class: a_class.has_feature_table
		do
			current_class := a_class;	
			!! structured_text.make
		ensure
			class_set: current_class = a_class;
			structured_text_not_void: structured_text /= Void
		end;

feature -- Property

	current_class: CLASS_C
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
			-- Execute the current command. Add a before and after
			-- declaration to `structured_text'
			-- and invoke `work'.
		do
			structured_text.add (ti_Before_class_declaration);
			work;
			structured_text.finish;
			structured_text.add (ti_After_class_declaration);
		end;

	work is
			-- Perform the command only.
		deferred
		end;

feature {NONE} -- Implementation

	sorted_list (list: LINKED_LIST [CLASS_C]): SORTED_TWO_WAY_LIST [CLASS_I] is
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
		end

end -- class E_CLASS_CMD
