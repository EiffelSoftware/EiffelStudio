deferred class TEXT_AREA

inherit

	OUTPUT_WINDOW;
	DRAG_SOURCE;
	WINDOWS;
	COMMAND
		redefine
			context_data_useful
		end;

feature -- Properties

	last_format: FORMAT_HOLDER;
			-- Last format used.

	tool: TOOL_W;
			-- Tool window to which Current belongs.

	focus: STONE is
			-- The stone where the focus currently is
		deferred
		end;

	is_editable: BOOLEAN is
			-- Is the Current text area able to edit text?
		do
			Result := True
		end;

	image: STRING is
			-- Text image of text area
		deferred
		ensure 
			non_void_result: Result /= Void
		end;

	changed: BOOLEAN is
			-- Has the text been edited since last display?
		deferred
		end;

feature -- Access

	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects and
			-- objects kept in history
		deferred
		end;

	transported_stone: STONE is
			-- Stone to be transported
		do
			Result := focus
		end;

feature -- Text operations

	highlight_focus is
			-- Highlight focus (using reverse video) on the screen
			-- from `focus_start' to `focus_end'.
			-- Put cursor on the focus if not already done.
		deferred
		end;

	deselect_all is
		deferred
		end;

feature -- Status setting

	set_changed (b: BOOLEAN) is
			-- Set `changed' to b.
		deferred
		end;

	set_last_format (f: like last_format) is
			-- Assign `f' to `last_format'.
		require
			format_exists: f /= Void
		do
			if last_format /= f then
				if not tool.history.islast then
					tool.history.extend (tool.stone)
				end;
				if last_format /= Void then
					last_format.set_selected (False)
				end;
				last_format := f;
				last_format.set_selected (True)
			else
				last_format.set_selected (True)
			end
		ensure
			last_format_set: equal (last_format, f)
		end;

feature -- Execution

	context_data_useful: BOOLEAN is 
		do
			Result := True
		end

	execute (argument: ANY) is
			-- Execute the command for Current.
		local
			but_data: BUTTON_DATA;
			history: STONE_HISTORY;
			st: like focus
		do
			if not changed then
				if argument = modify_event then 
					history := tool.history;
					if not history.islast then
						history.extend (tool.stone);
					end;
					set_changed (true);
					tool.update_save_symbol
				elseif argument = new_tooler then
					but_data ?= context_data;
					update_before_transport (but_data);
					st := focus;
					if st /= Void then
						Project_tool.receive (st);
						deselect_all
					end
				end
			end
		end;

feature {NONE} -- Command arguments

	new_tooler: ANY is
			-- Callback value to indicate that a new tool should come up.
		once
			!! Result
		end;

	modify_event: ANY is
			-- Callback value to indicate that the text has modified.
		once
			!! Result
		end;

end -- class TEXT_AREA
