indexing
	description: "Command to display the routines clients."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_CALLERS_FORMATTER

inherit
	EB_FILTERABLE
		redefine
			display_temp_header, make
		end
	EB_FEATURE_TOOL_DATA
	NEW_EB_CONSTANTS

creation

	make
	
feature -- Initialization

	make (a_tool: like tool) is
		do
			Precursor {EB_FILTERABLE} (a_tool)
			to_show_all_callers :=
				show_all_callers
		end

feature -- Properties

	to_show_all_callers: BOOLEAN
			-- Is the format going to show all callers?

	symbol: EV_PIXMAP is 
		once 
			Result := Pixmaps.bm_Showcallers 
		end
 
feature -- Executions

feature -- Status setting

	set_show_all_callers (b: BOOLEAN) is
			-- Set `to_show_all_callers' to `b'
		do
			to_show_all_callers := b
		ensure
			set: to_show_all_callers = b
		end

feature {NONE} -- Properties

	name: STRING is
		do
			if to_show_all_callers then
				Result := Interface_names.f_Showallcallers
			else
				Result := Interface_names.f_Showcallers
			end
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			if to_show_all_callers then
				Result := Interface_names.m_Showallcallers
			else
				Result := Interface_names.m_Showcallers
			end
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			if to_show_all_callers then
				Result := Interface_names.t_All_callers
			else
				Result := Interface_names.t_Callers
			end
		end

	post_fix: STRING is "fcl"

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display Senders of `f`.
		local
			cmd: E_SHOW_CALLERS
		do
			create cmd.make (f.e_feature)
			if to_show_all_callers then
				cmd.set_all_callers
			end
			if cmd.has_valid_feature then
				cmd.execute
				Result := cmd.structured_text
			end
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for callers...")
		end

end -- class EB_FEATURE_CALLERS_FORMATTER
