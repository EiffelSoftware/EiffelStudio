indexing
	description: "Command to display the implementers of a feature."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_IMPLEMENTERS_FORMATTER

inherit
	EB_FEATURE_TEXT_FORMATTER
		redefine
			feature_cmd,
			is_dotnet_formatter
		end

create
	make
	
feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_feature_implementers, 1)
			Result.put (Pixmaps.Icon_format_feature_implementers, 2)
		end
 
	feature_cmd: E_SHOW_ROUTINE_IMPLEMENTERS
			-- Feature command that can generate wanted information.

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showhistory
		end
 
feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Implementers
		end

	post_fix: STRING is "imp"
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
		end

	has_breakpoints: BOOLEAN is False
			-- Should breakpoints be shown in Current?

end -- class EB_IMPLEMENTERS_FORMATTER



