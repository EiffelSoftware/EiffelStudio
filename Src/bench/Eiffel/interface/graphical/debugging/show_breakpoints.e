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
			dark_symbol, display_temp_header
		end;
	FORMATTER
		redefine
			dark_symbol, format, display_temp_header, execute
		select
			format, execute
		end;
	SHARED_APPLICATION_EXECUTION;
	SHARED_FORMAT_TABLES;
	CUSTOM_CALLER

creation

	make


feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
			-- Initialize the command.
		do
			init (a_text_window);
		end; -- make

feature -- Execution

	execute_apply_action (a_cust_tool: like associated_custom_tool) is
			-- Action performed when apply button is activated
		do
			if a_cust_tool.is_first_option_selected = do_simple_format then
				do_simple_format :=
					not a_cust_tool.is_first_option_selected;
				if tool.last_format.associated_command = Current then
					tool.synchronize
				end
			end
		end;

	execute_ok_action (a_cust_tool: like associated_custom_tool) is
			-- Action performed when ok button is activated
		do
				-- *** FIXME need to save resource
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
						l_Showstops,
						l_Non_clickable_showstops,
						not do_simple_format)
			else
				old_execute (arg)
			end
		end

feature -- Formatting

	format (stone: FEATURE_STONE) is
			-- Show the "debug" format of `stone' if it is debuggable.
		local
			bar_and_text_tool: BAR_AND_TEXT;
			e_feature: E_FEATURE;
			message: STRING
		do
			if stone /= Void then
				e_feature := stone.e_feature;
				if e_feature.is_debuggable then
					old_format (stone)
				else
					bar_and_text_tool ?= tool;
					if tool /= Void then
						bar_and_text_tool.showtext_frmt_holder.execute (stone)
					end;
					if e_feature.body_id = Void then
							--FIXME need specify error message
						message := w_Cannot_debug_feature
					elseif e_feature.is_external then
						message := w_Cannot_debug_externals
					elseif e_feature.is_deferred then
						message := w_Cannot_debug_deferreds
					elseif e_feature.is_unique then
						message := w_Cannot_debug_uniques
					elseif e_feature.is_constant then
						message := w_Cannot_debug_constants
					elseif e_feature.is_attribute then
						message := w_Cannot_debug_attributes
					elseif not e_feature.written_class.is_debuggable then
						message := w_Cannot_debug_feature
					else
							-- Has to be dle!!!
							-- DLE temporary constraint:
							-- Cannot debug routines from the DC-set.
						message := w_Cannot_debug_dynamics
					end;
					warner (popup_parent).gotcha_call (message)
				end;
			end
		end;

feature -- Properties

	do_simple_format: BOOLEAN
			-- If True, only do the simple format (no clickables)

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := bm_Breakpoint
		end; -- symbol

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'.
		once
			Result := bm_Dark_breakpoint
		end;

feature -- Status setting

	set_format_mode (b: like do_simple_format) is
			-- Set `do_simple_format' to `b'.
		do	
			do_simple_format := b
		ensure	
			set: do_simple_format = b
		end

feature {NONE} -- Implementation

	display_info (s: FEATURE_STONE) is
			-- Display debug format of `stone'.
		do
			if do_simple_format then
				text_window.process_text (simple_debug_context_text (s))
			else
				text_window.process_text (debug_context_text (s))
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
			if do_simple_format then
				Result := l_Non_clickable_showstops
			else
				Result := l_Showstops
			end
		end;

	title_part: STRING is
			-- Part of the title.
		do
			if do_simple_format then
				Result := l_Non_clickable_stoppoints_of
			else
				Result := l_Stoppoints_of
			end
		end;

end -- class SHOW_BREAKPOINTS
