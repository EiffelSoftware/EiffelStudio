indexing
	description	: "Manager for all external output tools. Can be instanciated on the fly."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: ""

class
	EB_EXTERNAL_OUTPUT_MANAGER

inherit
	EB_OUTPUT_MANAGER

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	OUTPUT_ROUTINES
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER

create
	default_create

feature -- Basic Operations

	set_target_development_window (dev_window: EB_DEVELOPMENT_WINDOW) is
			-- set `target_development_window' to `dev_window'.
		require
			dev_window_not_void: dev_window /= Void
		do
			target_development_window := dev_window
		ensure
			target_development_window_set: target_development_window = dev_window
		end

	force_display is
			-- Make the output tools visible (to ensure the user sees what we print).
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.force_display
				managed_output_tools.forth
			end
		end

	scroll_to_end is
			-- Make all output tools scroll to the bottom.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.scroll_to_end
				managed_output_tools.forth
			end
		end

	clear is
			-- Clear the window.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.clear
				managed_output_tools.forth
			end
		end

	synchronize_on_process_starts (cmd_line: STRING) is
			-- Synchronize states when launch external command `cmd_line'.
		local
			eo: EB_EXTERNAL_OUTPUT_TOOL
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				eo ?= managed_output_tools.item
				if eo /= Void then
					eo.force_display
					eo.synchronize_on_process_starts (cmd_line)
				end
				managed_output_tools.forth
			end
		end

	synchronize_on_process_exits is
			-- Synchronize states when an external command exits.
		local
			eo: EB_EXTERNAL_OUTPUT_TOOL
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				eo ?= managed_output_tools.item
				if eo /= Void then
					eo.synchronize_on_process_exits
				end
				managed_output_tools.forth
			end
		end

	display_state (s: STRING; warning: BOOLEAN) is
			-- Display process state `s' to external command output panel.
			-- If `warning' is True, display in red color, otherwise in black color.
		local
			eo: EB_EXTERNAL_OUTPUT_TOOL
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				eo ?= managed_output_tools.item
				if eo /= Void then
					eo.display_state (s, warning)
				end
				managed_output_tools.forth
			end
		end

	process_block_text (text: EB_PROCESS_IO_DATA_BLOCK) is
			-- Print `text' on `target_development_window'.
		local
			eo: EB_EXTERNAL_OUTPUT_TOOL
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				eo ?= managed_output_tools.item
				if eo /= Void then
					if target_development_window /= Void then
						if eo.owner_development_window = target_development_window then
							eo.process_block_text (text)
						end
					else
						eo.process_block_text (text)
					end
				end
				managed_output_tools.forth
			end
			scroll_to_end
		end

	process_text (st: STRUCTURED_TEXT) is
			-- Print `st' on all output tools.
		do
		end

	synchronize_command_list (selected_cmd: EB_EXTERNAL_COMMAND) is
			-- Make sure that command list box in external command output panel
			-- contains right external command list.
			-- If `selected_cmd' not Void, make it a default selection in
			-- external command list.
		local
			et: EB_EXTERNAL_OUTPUT_TOOL
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				et ?= managed_output_tools.item
				if et /= Void then
					et.synchronize_command_list	(selected_cmd)
				end
				managed_output_tools.forth
			end
		end

feature -- Status reporting

	target_development_window: EB_DEVELOPMENT_WINDOW
			-- Development windows where current external command is launcheds		

feature -- Basic Operations / Information message

	clear_and_process_text (st: STRUCTURED_TEXT) is
		do
		end

	display_system_info is
		do
		end

	display_welcome_info is
		do
		end

	display_application_status is
		do
		end

	display_breakpoints is
		do
		end

feature -- Basic Operations / Compiler messages

	trace_warnings (handler: ERROR_HANDLER) is
		do
		end

	trace_errors (handler: ERROR_HANDLER) is
		do
		end

feature -- Element change

	extend (an_output_tool: EB_OUTPUT_TOOL) is
			-- Add this output tool to the list of managed output tools.
		do
			managed_output_tools.extend (an_output_tool)
		end

	prune (an_output_tool: EB_OUTPUT_TOOL) is
			-- Remove this output tool from the list of managed output tools.
		do
			managed_output_tools.start
			managed_output_tools.prune_all (an_output_tool)
		end

feature {NONE} -- Implementation

	display_error_error (st: STRUCTURED_TEXT) is
		do
		end

	display_error_list (st: STRUCTURED_TEXT; error_list: LINKED_LIST [ERROR]) is
		do
		end

	display_separation_line (st: STRUCTURED_TEXT) is
		do
		end

	display_additional_info (st: STRUCTURED_TEXT) is
		do
		end


feature {NONE} -- Implementation

	welcome_info: STRUCTURED_TEXT is
		do
		end

	structured_system_info: STRUCTURED_TEXT is
		do
		end

feature  -- Implementation / Private attributes

	managed_output_tools: ARRAYED_LIST [EB_OUTPUT_TOOL] is
			-- Managed output tools
		once
			create Result.make (10)
		end

end -- class EB_EXTERNAL_OUTPUT_MANAGER
