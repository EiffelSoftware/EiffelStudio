indexing
	description: "Command to display the homonyms of a feature."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_HOMONYMS_FORMATTER

inherit
	EB_FEATURE_TEXT_FORMATTER
		redefine
			feature_cmd,
			generate_text
		end

creation
	make
	
feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_feature_homonyms, 1)
			Result.put (Pixmaps.Icon_format_feature_homonyms, 2)
		end
 
	feature_cmd: E_SHOW_ROUTINE_HOMONYMNS
			-- Feature command that can generate wanted information.

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showhomonyms
		end
 
feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Homonyms
		end

	post_fix: STRING is "hom"
			-- String symbol of the command, used as an extension when saving.

feature {NONE} -- Implementation

	generate_text is
			-- Fill `formatted_text' with information concerning `associated_feature'.
		local
			cf: EB_STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			confirmed := False
			create cf.make_initialized (2, "generate_homonyms", Interface_names.l_homonym_confirmation, Interface_names.L_do_not_show_again)
			cf.set_ok_action (~confirm_generate)
			cf.show_modal_to_window (Window_manager.last_focused_development_window.window)
			if confirmed then
				last_was_error := False
				Precursor
			else
				last_was_error := True
			end
		end

	confirm_generate is
			-- The user DOES want to generate the homonyms.
		do
			confirmed := True
		end

	confirmed: BOOLEAN
			-- Did the user confirm he wanted to generate the homonyms?

	create_feature_cmd is
			-- Create `feature_cmd'.
		require else
			associated_feature_non_void: associated_feature /= Void
		do
			create feature_cmd.make (associated_feature)
		end

end -- class EB_HOMONYMS_FORMATTER


