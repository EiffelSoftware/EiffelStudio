indexing

	description:	
		"Command to stop in a feature while debugging.";
	date: "$Date$";
	revision: "$Revision$"


class DEBUG_STOPIN_HOLE

inherit

	SHARED_APPLICATION_EXECUTION;
	HOLE_COMMAND
		redefine
			compatible, process_breakable,
			process_feature, process_call_stack,
			process_class
		end;
	SHARED_EIFFEL_PROJECT;
	WARNING_MESSAGES

creation

	make, do_nothing

feature -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := l_Showstops
		end;

	symbol: PIXMAP is
			-- Pixmaps for the button.
		once
			Result := bm_Setstop
		end;

feature -- Access

	compatible (dropped: STONE): BOOLEAN is
			-- Can `Current' accept `dropped' ?
		do
			Result := dropped /= Void and then 
					(dropped.stone_type = Breakable_type or else
					dropped.stone_type = Class_type or else
					dropped.stone_type = Call_stack_type or else
					dropped.stone_type = Routine_type)
		end;

feature -- Execution

	work (argument: ANY) is
		do
			debug_window.clear_window;
			if 
				Application.debugged_routines.empty and 
				Application.removed_routines.empty 
			then
				debug_window.put_string ("No stop points.");
				debug_window.new_line;
			else
				if not Application.debugged_routines.empty then
					Debug_window.put_string ("Active stop points:");
					debug_window.new_line;
					debug_window.new_line;
					display_debuggable_routines (Application.debugged_routines)
				end;
				debug_window.new_line;
				debug_window.put_string ("-------------");
				debug_window.new_line;
				debug_window.new_line;
				if not Application.removed_routines.empty then
					debug_window.put_string ("Non-active stop points:");
					debug_window.new_line;
					debug_window.new_line;
					display_debuggable_routines (Application.removed_routines)
				end;
			end;
			debug_window.new_line;
			debug_window.display
		end;

feature -- Output

	display_debuggable_routines (routine_list: LINKED_LIST [E_FEATURE]) is
			-- Display either the list of routines whose stop points are
			-- activated, or the list of routines whose stop points have been
			-- deactivated.
		local
			table: EXTEND_TABLE [PART_SORTED_TWO_WAY_LIST[E_FEATURE], CLASS_ID];
			stwl: PART_SORTED_TWO_WAY_LIST[E_FEATURE];
			f: E_FEATURE;
			c: E_CLASS;
			i, bp_count: INTEGER;
			bp_list: LIST [INTEGER];
			first_bp: BOOLEAN;
			bp_text: STRING;
			bp: BREAKABLE_STONE;
			more_than_one: BOOLEAN
		do
			from
				!! table.make (5);
				routine_list.start
			until
				routine_list.after
			loop
				f :=  routine_list.item;
				c := f.written_class;
				stwl := table.item (c.id);
				if stwl = Void then
					!!stwl.make;
					table.put (stwl, c.id)
				end;
				stwl.extend (f);
				routine_list.forth
			end;
			from
				table.start
			until
				table.after
			loop
				stwl := table.item_for_iteration;
				c := Eiffel_system.class_of_id (table.key_for_iteration);
				from
					stwl.start;
					more_than_one := stwl.count > 1;
					if more_than_one then
						debug_window.put_class (c, c.name_in_upper);
						debug_window.put_string (": ");
						debug_window.new_line
					end
				until
					stwl.after
				loop
					if more_than_one then
						debug_window.put_one_indent
					else
						debug_window.put_class (c, c.name_in_upper);
						debug_window.put_string (": ");
					end;
					debug_window.put_feature (stwl.item, stwl.item.name);
					f := stwl.item;
					bp_list := Application.breakpoints_set_for (f);
					if not bp_list.empty then
						from
							debug_window.put_string (" [");
							first_bp := True;
							bp_list.start
						until
							bp_list.after
						loop
							i := bp_list.item;
							if not first_bp then
								debug_window.put_string (", ")
							else
								first_bp := False
							end;
							bp_text := i.out;
							!! bp.make (f, i);
							debug_window.put_breakpoint_stone (bp, bp_text);
							bp_list.forth
						end;
						debug_window.put_string ("]")
					end;
					debug_window.new_line;
					stwl.forth
				end;
				table.forth
			end;
		end;

feature -- Update

	process_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone
		local
			index: INTEGER;
			mp: MOUSE_PTR;
			f: E_FEATURE
		do
			if Eiffel_project.successful then
				f := bs.routine;
				index := bs.index
				if f.is_debuggable then
					!! mp.set_watch_cursor;
					Application.add_feature (f);
					Application.switch_breakpoint (f, index);
					Window_manager.routine_win_mgr.show_stoppoint (f, index);
					Project_tool.show_stoppoint (f, index);
					work (Void);
					mp.restore
				end;
			else
				warner (Project_tool.popup_parent).gotcha_call (w_Cannot_debug)
			end
		end;

	process_call_stack (dropped: CALL_STACK_STONE) is
			-- Accept all stone types
		do
			Project_tool.process_call_stack (dropped)
		end;

	process_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			f: E_FEATURE;
			mp: MOUSE_PTR
		do
			if Eiffel_project.successful then
				f := fs.e_feature;
				if f.is_debuggable then
					!! mp.set_watch_cursor;
					update_debuggable_for (f);
					work (Void);
							-- Feature stone dropped.
							-- If the feature is debuggable, its first breakable
							-- point is set (or remove if already set).
					mp.restore
				end;
			else
				warner (Project_tool.popup_parent).gotcha_call (w_Cannot_debug)
			end
		end;

	process_class (cs: CLASSC_STONE) is
			-- Process class stone
		local
			list: LIST [E_FEATURE];
			mp: MOUSE_PTR;
			updated: BOOLEAN;
			f: E_FEATURE
		do
			if Eiffel_project.successful then
				!! mp.set_watch_cursor;
				list := cs.e_class.written_in_features;
				from
					list.start
				until
					list.after
				loop
					f := list.item;
					if f.is_debuggable then
						updated := True;
						update_debuggable_for (f);
					end;
					list.forth
				end
				if updated then
					work (Void);
				end;
				mp.restore
			else
				warner (Project_tool.popup_parent).gotcha_call (w_Cannot_debug)
			end
		end;

feature -- Property

	stone_type: INTEGER is do end

feature {NONE} -- Implementation

	update_debuggable_for (f: E_FEATURE) is
			-- Update the debuggable information for feature `f'.
			-- If `f' is already debuggable then switch it to another
			-- category. Otherwize, set the first breakpoint.
		require
			f_is_valid: f /= Void;
			is_debuggable: f.is_debuggable
		do
			if Application.has_feature (f) then
				Application.switch_feature (f);
				Window_manager.routine_win_mgr.resynchronize_debugger (f)
			else
				Application.add_feature (f);
				Application.switch_breakpoint (f, 1);
				Window_manager.routine_win_mgr.show_stoppoint (f, 1);
				Project_tool.show_stoppoint (f, 1)
			end
		end;

end -- class DEBUG_STOPIN_HOLE
