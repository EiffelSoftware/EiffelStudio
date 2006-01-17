indexing
	description: "Command to disable one/some/all breakpoints."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_ENABLE_DISABLE_STOP_POINTS_HOLE

inherit
	HOLE_COMMAND
		redefine
			compatible, process_breakable,
			process_feature, process_class
		end

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

create
	make_enabled, 
	make_disabled 

feature {NONE} -- Initialization

	make_enabled is
			-- Initialize command to enable all stoppoints.
		do
			status_type := enabled_type
		end
 
	make_disabled is
			-- Initialize command to disable all stoppoints.
		do
			status_type := disabled_type
		end

feature -- Properties

	name: STRING is
			-- Name of the command.
		do
			inspect
				status_type
			when disabled_type then
				Result := Interface_names.f_Disable_stop_points
			when enabled_type then
				Result := Interface_names.f_Enable_stop_points
			end
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			inspect
				status_type
			when disabled_type then
				Result := Interface_names.m_Disable_stop_points
			when enabled_type then
				Result := Interface_names.m_Enable_stop_points
			end
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	symbol: PIXMAP is 
			-- Pixmap for the button.
		do 
			Result := Pixmaps.bm_Disable_breakpoints 
		end

	stone_type: INTEGER is
		do
		end

feature -- Access

	compatible (dropped: STONE): BOOLEAN is
			-- Can `Current' accept `dropped' ?
		do
			Result := dropped /= Void and then
					(dropped.stone_type = Breakable_type or else
					dropped.stone_type = Class_type or else
					dropped.stone_type = Routine_type)
		end

feature -- Update

	process_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone
		local
			index: INTEGER
			f: E_FEATURE
			disp_bp: DEBUG_STOPIN_HOLE
			mp: MOUSE_PTR
			body_index: INTEGER
		do
			if Eiffel_project.successful then
				f := bs.routine
				if f.is_debuggable then
					index := bs.index
					body_index := bs.body_index

					create mp.set_watch_cursor
					Application.disable_breakpoint (f, index)
					Window_manager.routine_win_mgr.show_stoppoint (body_index, index)
					Project_tool.show_stoppoint (body_index, index)
					mp.restore

						-- update information window
					create disp_bp.do_nothing
					disp_bp.work (Void)
				end
			else
				warner (Project_tool.popup_parent).gotcha_call (Warning_messages.w_Cannot_debug)
			end
		end

	process_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			f: E_FEATURE
			disp_bp: DEBUG_STOPIN_HOLE
			mp: MOUSE_PTR
		do
			if Eiffel_project.successful then
				f := fs.e_feature
				if f /= Void and then f.is_debuggable and then Application.has_breakpoint_set(f) then
					create mp.set_watch_cursor
					Application.disable_breakpoints_in_feature(f)
					create disp_bp.do_nothing
					disp_bp.work (Void)
					Window_manager.routine_win_mgr.resynchronize_debugger (Void)
					Project_tool.resynchronize_debugger
					mp.restore
				end
			end
		end

	process_class (cs: CLASSC_STONE) is
			-- Process class stone.
		local
			disp_bp: DEBUG_STOPIN_HOLE
			mp: MOUSE_PTR
		do
			if Eiffel_project.successful and then cs.e_class /= Void then
				create mp.set_watch_cursor
				Application.disable_breakpoints_in_class(cs.e_class)

					-- update information window
				create disp_bp.do_nothing
				disp_bp.work (Void)
	
				Window_manager.routine_win_mgr.resynchronize_debugger (Void)
				Project_tool.resynchronize_debugger
				mp.restore
			end
		end

feature -- Execution

	work (argument: ANY) is
			-- Continue execution.
		local
			disp_bp: DEBUG_STOPIN_HOLE
		do
			if Application.has_breakpoints then
				inspect status_type
				when disabled_type then
					Application.disable_all_breakpoints
				when enabled_type then
					Application.enable_all_breakpoints
				end -- inspect
				create disp_bp.do_nothing
				disp_bp.work (Void)
				Window_manager.routine_win_mgr.resynchronize_debugger (Void)
				Project_tool.resynchronize_debugger
			end -- if
		end

feature {NONE} -- Implementation
 
	status_type: INTEGER
			-- Status type
 
	disabled_type, enabled_type: INTEGER is unique;


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class DEBUG_ENABLE_DISABLE_STOP_POINTS_HOLE
