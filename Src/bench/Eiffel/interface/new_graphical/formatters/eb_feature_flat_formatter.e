indexing
	description: "Command to display the flat aspect of a feature."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_FLAT_FORMATTER

inherit
	EB_FEATURE_TEXT_FORMATTER
		redefine
			feature_cmd
		end

creation
	make
	
feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.bm_Showflat, 1)
		end
 
	feature_cmd: E_SHOW_ROUTINE_FLAT
			-- Feature command that can generate the information.

feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Flat
		end

	post_fix: STRING is "fla"
			-- String symbol of the command, used as an extension when saving.

feature {NONE} -- Implementation

	create_feature_cmd is
			-- Create `feature_cmd'.
		require else
			associated_feature_non_void: associated_feature /= Void
		do
			create feature_cmd.make (associated_feature)
		end

end -- class EB_FEATURE_FLAT_FORMATTER


