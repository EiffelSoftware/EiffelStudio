indexing

	description:	
		"Command to set break points.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_BREAKPOINTS

inherit
	FORMATTER
		rename
			execute as old_execute, 
			format as old_format
		redefine
			display_temp_header
		end;
	FORMATTER
		redefine
			format, display_temp_header, execute
		select
			format, execute
		end;
	SHARED_APPLICATION_EXECUTION;
	SHARED_FORMAT_TABLES;
	CUSTOM_CALLER;
	EB_CONSTANTS

creation

	make

feature -- Initialization

	make (a_tool: TOOL_W) is
			-- Initialize the command.
		do
			init (a_tool);
			if tool = Project_tool then
				do_flat := Project_resources.debugger_do_flat_in_breakpoints.actual_value
			else
				do_flat := Feature_resources.do_flat_in_breakpoints.actual_value
			end
		end; 

feature -- Execution

	execute_apply_action (a_cust_tool: like associated_custom_tool) is
			-- Action performed when apply button is activated
		do
			if a_cust_tool.is_first_option_selected /= do_flat then
				do_flat := a_cust_tool.is_first_option_selected;
				if tool.last_format.associated_command = Current then
					tool.synchronize
				end
			end
		end;

	execute_ok_action (a_cust_tool: like associated_custom_tool) is
			-- Action performed when ok button is activated
		do
			execute_apply_action (a_cust_tool)
		end;

	execute (arg: ANY) is
			-- Execute the format.
		local
			rcw: ROUTINE_CUSTOM_W
		do
			if arg = button_three_action then
				rcw := routine_custom_window (popup_parent);
				rcw.set_window (popup_parent);
				rcw.call (Current,
						Interface_names.l_Showstops,
						Interface_names.l_Non_clickable_showstops,
						do_flat)
			else
				old_execute (arg)
			end
		end

feature -- Formatting

	format (stone: STONE) is
			-- Show the "debug" format of `stone' if it is debuggable.
		local
			bar_and_text_tool: BAR_AND_TEXT;
			e_feature: E_FEATURE;
			message: STRING
			f_stone: FEATURE_STONE
			routine_window: ROUTINE_W
		do
			f_stone ?= stone
			if f_stone /= Void then
				e_feature := f_stone.e_feature
				if e_feature.is_debuggable then
					old_format (f_stone)
					if Application.is_running and then Application.is_stopped then
						routine_window ?= tool
						if routine_window /= Void then
							routine_window.synchronize_with_callstack
						end
					end
				else
					bar_and_text_tool ?= tool;
					if tool /= Void then
						bar_and_text_tool.showtext_frmt_holder.execute (f_stone)
					end;
					if e_feature.body_index = 0 then
						message := Warning_messages.w_Cannot_debug_feature
					elseif e_feature.is_external then
						message := Warning_messages.w_Cannot_debug_externals
					elseif e_feature.is_deferred then
						message := Warning_messages.w_Cannot_debug_deferreds
					elseif e_feature.is_unique then
						message := Warning_messages.w_Cannot_debug_uniques
					elseif e_feature.is_constant then
						message := Warning_messages.w_Cannot_debug_constants
					elseif e_feature.is_attribute then
						message := Warning_messages.w_Cannot_debug_attributes
					elseif not e_feature.written_class.is_debuggable then
						message := Warning_messages.w_Cannot_debug_feature
					else
							-- Has to be dle!!!
							-- DLE temporary constraint:
							-- Cannot debug routines from the DC-set.
						message := Warning_messages.w_Cannot_debug_dynamics
					end;
					warner (popup_parent).gotcha_call (message)
				end;
			end
		end;

feature -- Properties

	do_flat: BOOLEAN
			-- If True, do a flat

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := Pixmaps.bm_Breakpoint
		end; -- symbol

feature -- Status setting

	set_format_mode (b: like do_flat) is
			-- Set `do_flat' to `b'.
		do	
			do_flat := b
		ensure	
			set: do_flat = b
		end

feature {NONE} -- Implementation

	display_info (s: FEATURE_STONE) is
			-- Display debug format of `stone'.
		do
			if do_flat then
				text_window.process_text (debug_context_text (s))
			else
				text_window.process_text (simple_debug_context_text (s))
			end
		end;
	
	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Computing stop point positions...")
		end;

feature {NONE} -- Access

	associated_custom_tool: ROUTINE_CUSTOM_W is
			-- Associated custom tool
			-- (Used for type checking and system validity)
		do
		end;

	name: STRING is
			-- Name for he command.
		do
			if do_flat then
				Result := Interface_names.f_Showstops
			else
				Result := Interface_names.f_Non_clickable_showstops
			end
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			if do_flat then
				Result := Interface_names.m_Showstops
			else
				Result := Interface_names.m_Non_clickable_showstops
			end
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
			-- Part of the title.
		do
			if do_flat then
				Result := Interface_names.t_Stoppoints_of
			else
				Result := Interface_names.t_Non_clickable_stoppoints_of
			end
		end;

end -- class SHOW_BREAKPOINTS
