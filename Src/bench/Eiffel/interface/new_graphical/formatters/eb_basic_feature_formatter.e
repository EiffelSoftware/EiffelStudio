indexing
	description: "Formatter that displays the text of a feature with no analysis."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_BASIC_FEATURE_FORMATTER

inherit
	EB_FEATURE_TEXT_FORMATTER
		redefine
			generate_text,
			feature_cmd,
			editable,
			formatted_text,
			format,
			make
		end

creation
	make

feature -- Initialization

	make (a_manager: like manager) is
			-- Create a formatter associated with `a_manager'.
		do
			Precursor {EB_FEATURE_TEXT_FORMATTER} (a_manager)
			create_feature_cmd
			create formatted_text.make
		end

feature -- Properties

	editable: BOOLEAN is False
			-- Can the generated text be edited?

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_text, 1)
			Result.put (Pixmaps.Icon_format_text, 2)
		end

	formatted_text: STRUCTURED_TEXT
			-- Text representing `associated_feature'.

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showtext_new
		end
 
feature -- Formatting

	format is
			-- Refresh `widget'.
		do
			if
				selected and then
				associated_feature /= Void and then
				displayed 
			then
				editor.set_feature_for_click (associated_feature)
				editor.enable_feature_click
				if must_format then
					display_temp_header
					generate_text
				end
				if formatted_text /= Void then
					editor.load_eiffel_text (formatted_text.image)
				else
					editor.clear_window
				end
				if editable then
					editor.enable_editable
				else
					editor.disable_editable
				end
				must_format := False
				display_header
			end
		end


feature -- Status setting

	set_associated_feature (a_feature: E_FEATURE) is
			-- Associate `Current' with `a_feature'.
		do
			set_associated_feature (a_feature)
		end

feature {NONE} -- Properties

	feature_cmd: E_SHOW_ROUTINE_FLAT
			-- Just needed for compatibility, do not use.

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Basic_text
		end

	post_fix: STRING is "txt"
			-- String symbol of the command, used as an extension when saving.

feature {NONE} -- Implementation

	generate_text is
			-- Create `formatted_text'.
		do
			formatted_text := associated_feature.text
		end

	create_feature_cmd is
			-- Create `feature_cmd'.
		require else
			True
		do
			create feature_cmd.do_nothing
		end

end -- class EB_BASIC_FEATURE_FORMATTER
