indexing
	description	: "Command to stop in a feature while debugging."
	date		: "$Date$"
	revision	: "$Revision$"

class DEBUG_STOPIN_HOLE

inherit
	HOLE_COMMAND
		redefine
			compatible, process_breakable,
			process_feature, process_call_stack,
			process_class
		end

	SHARED_EIFFEL_PROJECT

	SHARED_APPLICATION_EXECUTION

creation
	make, do_nothing

feature -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Showstops
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showstops
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	symbol: PIXMAP is
			-- Pixmaps for the button.
		once
			Result := Pixmaps.bm_Setstop
		end

feature -- Access

	compatible (dropped: STONE): BOOLEAN is
			-- Can `Current' accept `dropped' ?
		do
			Result := dropped /= Void and then 
					(dropped.stone_type = Breakable_type or else
					dropped.stone_type = Class_type or else
					dropped.stone_type = Call_stack_type or else
					dropped.stone_type = Routine_type)
		end

feature -- Execution

	work (argument: ANY) is
		local
			st: STRUCTURED_TEXT
			enabled_bps: BOOLEAN
			disabled_bps: BOOLEAN
		do
			if Project_tool.initialized then
				debug_window.clear_window
				create st.make
				if not Application.has_breakpoints then
					st.add_string ("No stop points.")
					st.add_new_line
				else
					enabled_bps := Application.has_enabled_breakpoints
					disabled_bps := Application.has_disabled_breakpoints

					if enabled_bps then
						st.add_string ("Enabled stop points:")
						st.add_new_line
						st.add_new_line
						display_breakpoints (st, Application.features_with_breakpoint_set, display_enabled)
						if disabled_bps then
							st.add_new_line
							st.add_string ("-------------")
							st.add_new_line
							st.add_new_line
						end
					end

					if disabled_bps then
						st.add_string ("Disabled stop points:")
						st.add_new_line
						st.add_new_line
						display_breakpoints (st, Application.features_with_breakpoint_set, display_disabled)
					end
				end
				st.add_new_line
				debug_window.process_text (st)
				debug_window.display
			end
		end

feature -- Output

	display_breakpoints (st: STRUCTURED_TEXT; routine_list: LIST [E_FEATURE]; display_mode:INTEGER) is
			-- Display the list of routines whose stop points are activated
		local
			table: HASH_TABLE [PART_SORTED_TWO_WAY_LIST[E_FEATURE], INTEGER]
			stwl: PART_SORTED_TWO_WAY_LIST[E_FEATURE]
			f: E_FEATURE
			c: CLASS_C
			i: INTEGER
			bp_list: LIST [INTEGER]
			bt: BREAKPOINT_ITEM
			first_bp: BOOLEAN
			has_bp: BOOLEAN
		do
			from
				create table.make (5)
				routine_list.start
			until
				routine_list.after
			loop
				f :=  routine_list.item;
				c := f.written_class;
				stwl := table.item (c.class_id);
				if stwl = Void then
					create stwl.make;
					table.put (stwl, c.class_id)
				end;
				stwl.extend (f);
				routine_list.forth
			end

			from
				table.start
			until
				table.after
			loop
				stwl := table.item_for_iteration
				c := Eiffel_system.class_of_id (table.key_for_iteration)

				-- look if this class contains any breakpoint
				has_bp := false
				from
					stwl.start
				until
					stwl.after or has_bp
				loop
					f := stwl.item
					if display_mode = display_enabled then
						bp_list := Application.breakpoints_enabled_for(f)
					else
						bp_list := Application.breakpoints_disabled_for(f)
					end
						
					has_bp := not bp_list.is_empty;
					stwl.forth
				end
				if has_bp then				
					from
						stwl.start
						st.add_classi (c.lace_class, c.name_in_upper)
						st.add_string (": ")
						st.add_new_line
					until
						stwl.after
					loop
						f := stwl.item
						if display_mode = display_enabled then
							bp_list := Application.breakpoints_enabled_for (f)
						else
							bp_list := Application.breakpoints_disabled_for (f)
						end
							
						if not bp_list.is_empty then
							st.add_indent
							st.add_feature (f, f.name)
							from
								st.add_string (" [")
								first_bp := True
								bp_list.start
							until
								bp_list.after
							loop
								i := bp_list.item
								if not first_bp then
									st.add_string (", ")
								else
									first_bp := False
								end
								create bt.make (f, i)
								bt.set_display_number
								st.add (bt)
								bp_list.forth
							end
							st.add_string ("]")
							st.add_new_line
						end
						stwl.forth
					end
				end
				table.forth
			end
		end

feature -- Update

	process_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone
		local
			index: INTEGER
			mp: MOUSE_PTR
			f: E_FEATURE
			body_index: INTEGER
		do
			if Eiffel_project.successful then
				f := bs.routine
				if f.is_debuggable then
					index := bs.index
					body_index := bs.body_index

					create mp.set_watch_cursor
					Application.switch_breakpoint (f, index)
					Window_manager.routine_win_mgr.show_stoppoint (body_index, index);
					Project_tool.show_stoppoint (body_index, index);
					work (Void);
					mp.restore
				end;
			else
				warner (Project_tool.popup_parent).gotcha_call (Warning_messages.w_Cannot_debug)
			end
		end

	process_call_stack (dropped: CALL_STACK_STONE) is
			-- Accept all stone types
		do
			Project_tool.process_call_stack (dropped)
		end;

	process_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			f: E_FEATURE
			mp: MOUSE_PTR
		do
			if Eiffel_project.successful then
				f := fs.e_feature
				if f.is_debuggable then
 					create mp.set_watch_cursor
					update_debuggable_for(f)
					work (Void)
							-- Feature stone dropped.
							-- If the feature is debuggable, its first breakable
							-- point is set (or remove if already set).
					mp.restore
				end
			else
				warner (Project_tool.popup_parent).gotcha_call (Warning_messages.w_Cannot_debug)
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
				create mp.set_watch_cursor;
				list := cs.e_class.written_in_features
				from
					list.start
				until
					list.after
				loop
					f := list.item
					if f.is_debuggable then
						updated := True
						update_debuggable_for(f)
					end
					list.forth
				end
				if updated then
					work (Void)
				end
				mp.restore
			else
				warner (Project_tool.popup_parent).gotcha_call (Warning_messages.w_Cannot_debug)
			end
		end

feature -- Property

	stone_type: INTEGER is do end

feature {NONE} -- Implementation

	update_debuggable_for (f: E_FEATURE) is
			-- Update the debuggable information for feature `f':
			-- Set the first breakpoint.
		require
			f_is_valid: f /= Void;
			is_debuggable: f.is_debuggable
		local
			body_index: INTEGER
		do
			Application.enable_breakpoint(f, 1)
			body_index := f.body_index
			Window_manager.routine_win_mgr.show_stoppoint (body_index, 1)
			Project_tool.show_stoppoint (body_index, 1)
		end

feature {NONE} -- Private Constants
		-- constants used to display the list of enabled/disabled breakpoints
	display_enabled: INTEGER is 1
	display_disabled: INTEGER is 2


end -- class DEBUG_STOPIN_HOLE
