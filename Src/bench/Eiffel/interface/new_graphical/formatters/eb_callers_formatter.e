indexing
	description: "Command to display the callers of a feature."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CALLERS_FORMATTER

inherit
	EB_FEATURE_TEXT_FORMATTER
		redefine
			feature_cmd,
			is_dotnet_formatter
		end

creation
	make
	
feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_feature_callers, 1)
			Result.put (Pixmaps.Icon_format_feature_callers, 2)
		end
 
	feature_cmd: E_SHOW_CALLERS
			-- Feature command that can generate the information.

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showcallers
		end
 
feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Callers
		end

	post_fix: STRING is "cal"
			-- String symbol of the command, used as an extension when saving.

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET XML types?
		do
			Result := True
		end

feature {NONE} -- Implementation

	create_feature_cmd is
			-- Create `feature_cmd'.
		require else
			associated_feature_non_void: associated_feature /= Void
		do
			create feature_cmd.make (associated_feature)
			if show_all_callers then
				feature_cmd.set_all_callers
			end
		end

end -- class EB_CALLERS_FORMATTER

