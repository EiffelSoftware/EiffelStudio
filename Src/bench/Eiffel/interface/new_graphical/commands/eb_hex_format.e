indexing
	description: ""
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_HEX_FORMAT_CMD

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	EB_TOOLBARABLE_COMMAND
		redefine
			mini_pixmap,
			new_mini_toolbar_item
		end

create
	make

feature -- Initialization

	make (a_callback: like command_call_back) is
			-- Initialize `Current' and associate it with `tool'.
		do
			command_call_back := a_callback
		end

feature -- Access

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version at least).
			-- Items at position 3 and 4 contain text.
		do
			--| No big pixmap is required for this command.
		end

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command for mini toolbars.
		do
			Result := pixmaps.small_pixmaps.icon_numeric_format
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.e_switch_num_format_to_hex
		end

feature -- Measurement

feature -- Status report

	command_call_back: PROCEDURE [ANY, TUPLE [BOOLEAN]]
			-- Call back procedure to execute current

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.e_Switch_num_formating
		end

	description: STRING is
			-- Description of the command.
		do
			Result := Interface_names.l_Switch_num_format_desc
		end

feature -- Execution

	execute is
			-- Remove an object from `tool'.
		do
			if command_call_back /= Void then
				command_call_back.call ([toggle_button.is_selected])
			end
			if toggle_button.is_selected then
				toggle_button.set_tooltip (interface_names.e_Switch_num_format_to_dec)
			else
				toggle_button.set_tooltip (interface_names.e_Switch_num_format_to_hex)
			end			
		end

feature -- Basic operations

	new_mini_toolbar_item: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		do
			create Result.make (Current)
			Result.set_pixmap (mini_pixmap @ 1)
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
			Result.set_tooltip (tooltip)
			Result.select_actions.extend (agent execute)

			toggle_button := Result
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	toggle_button: EV_TOOL_BAR_TOGGLE_BUTTON

end -- class EB_HEX_FORMAT_CMD
