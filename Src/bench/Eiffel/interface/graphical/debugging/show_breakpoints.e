indexing

	description:	
		"Command to set break points.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_BREAKPOINTS

inherit

	FORMATTER
		rename
			format as old_format
		redefine
			dark_symbol, display_temp_header
		end;
	FORMATTER
		redefine
			dark_symbol, format, display_temp_header
		select
			format
		end;
	SHARED_APPLICATION_EXECUTION;
	SHARED_FORMAT_TABLES

creation

	make


feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
			-- Initialize the command.
		do
			init (a_text_window);
		end; -- make

feature -- Formatting

	format (stone: FEATURE_STONE) is
			-- Show the "debug" format of `stone' if it is debuggable.
		local
			tool: BAR_AND_TEXT;
			e_feature: E_FEATURE;
			message: STRING
		do
			if stone /= Void then
				e_feature := stone.e_feature;
				if e_feature.is_debuggable then
					old_format (stone)
				else
					tool ?= text_window.tool;
					if tool /= Void then
						tool.showtext_frmt_holder.execute (stone)
					end;
					if e_feature.body_id = 0 then
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
					warner (text_window).gotcha_call (message)
				end;
			end
		end;

feature -- Properties

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

feature {NONE} -- Implementation

	display_info (s: FEATURE_STONE) is
			-- Display debug format of `stone'.
		do
			text_window.process_text (debug_context_text (s))
		end;
	
	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Computing stop point positions...")
		end;

feature {NONE} -- Attributes

	name: STRING is
			-- Name for he command.
		do
			Result := l_Showstops
		end;

	title_part: STRING is
			-- Part of the title.
		do
			Result := l_Stoppoints_of
		end;

end -- class SHOW_BREAKPOINTS
