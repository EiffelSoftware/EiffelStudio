indexing

	description: 
		"General notion of an eiffel command with output%
		%appended to `structured_text'.";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_OUTPUT_CMD

inherit

	E_CMD
		redefine
			executable
		end

	SHARED_TEXT_ITEMS

feature -- Properties

	structured_text: STRUCTURED_TEXT;
			-- Structured text for command.

feature -- Access

	executable: BOOLEAN is
			-- Is Current command executable?
		do
			Result := structured_text /= Void 
		end

feature -- Setting

	make is
			-- Create `structured_text' to `st'.
		do
			!! structured_text.make
		ensure
			struct_text_not_void: structured_text /= Void
		end;

feature -- Execution

	execute is
			-- Execute the current command. Add a before and after
			-- declaration (cluster declaration by default) to `structured_text'
			-- and invoke `work'.
		do
			structured_text.add (ti_Before_cluster_declaration);
			work;
			structured_text.add (ti_After_cluster_declaration);
		end;

	work is
			-- Perform the command only.
		deferred
		end;

feature {NONE} -- Implementation

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

end -- class E_OUTPUT_CMD
