indexing
	description: "Command to set break points."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_BREAKPOINTS_FORMATTER

inherit
	EB_FORMATTER
		redefine
			format, display_temp_header,
			make
		end
	SHARED_APPLICATION_EXECUTION
	EB_SHARED_FORMAT_TABLES
	EB_FEATURE_TOOL_DATA

creation

	make

feature -- Initialization

	make (a_tool: like tool) is
			-- Initialize the command.
		do
			Precursor {EB_FORMATTER} (a_tool)
			do_flat := do_flat_in_breakpoints
		end 

feature -- Formatting

	format is
			-- Show the "debug" format of tool stone if it is debuggable.
		local
			edit_tool: EB_MULTIFORMAT_TOOL
			e_feature: E_FEATURE
			message: STRING
			f_stone: FEATURE_STONE
			wd: EV_WARNING_DIALOG
		do
			f_stone ?= tool.stone
			if f_stone /= Void then
				e_feature := f_stone.e_feature
				if e_feature.is_debuggable then
					Precursor {EB_FORMATTER}
				else
					edit_tool ?= tool
					if tool /= Void then
						edit_tool.format_list.text_format.format
					end
					if e_feature.body_index = Void then
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
					end
					create wd.make_with_text (message)
					wd.show_modal
				end
			end
		end

feature -- Properties

	do_flat: BOOLEAN
			-- If True, do a flat

	symbol: EV_PIXMAP is
			-- Pixmap for the button.
		once
			Result := Pixmaps.bm_Breakpoint
		end -- Symbol

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
				tool.text_area.process_text (debug_context_text (s))
			else
				tool.text_area.process_text (simple_debug_context_text (s))
			end
		end
	
	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Computing stop point positions...")
		end

feature {NONE} -- Access

	name: STRING is
			-- Name for he command.
		do
			if do_flat then
				Result := Interface_names.f_Showstops
			else
				Result := Interface_names.f_Non_clickable_showstops
			end
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			if do_flat then
				Result := Interface_names.m_Showstops
			else
				Result := Interface_names.m_Non_clickable_showstops
			end
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
			-- Part of the title.
		do
			if do_flat then
				Result := Interface_names.t_Stoppoints_of
			else
				Result := Interface_names.t_Non_clickable_stoppoints_of
			end
		end

	post_fix: STRING is "brk"

end -- class EB_BREAKPOINTS_FORMATTER
