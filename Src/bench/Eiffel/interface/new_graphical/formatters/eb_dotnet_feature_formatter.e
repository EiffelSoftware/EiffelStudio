indexing
	description: "Formatter that displays the text of a feature in flat form for .NET features"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DOTNET_FEATURE_FORMATTER

inherit
	EB_FEATURE_TEXT_FORMATTER
		redefine
			set_stone,
			set_editor,
			feature_cmd,
			generate_text,
			formatted_text
		end

	EB_SHARED_FORMAT_TABLES

	SHARED_FORMAT_INFO

	SHARED_APPLICATION_EXECUTION

create
	make
	
feature -- Status setting

	set_editor (an_editor: EB_CLICKABLE_EDITOR) is
			-- Set `editor' to `an_editor'.
			-- Used to share an editor between several formatters.
		do
			Precursor {EB_FEATURE_TEXT_FORMATTER} (an_editor)
			editor.drop_actions.extend (~on_breakable_drop)
		end
		
	set_stone (new_stone: FEATURE_STONE) is
			-- Associate `Current' with class contained in `new_stone'.
		local
			l_reader: EIFFEL_XML_DESERIALIZER
		do
			if new_stone /= Void and new_stone.class_i.is_external_class then
				create l_reader
				consumed_type ?= l_reader.new_object_from_file (new_stone.class_i.file_name)
				set_feature (new_stone.e_feature)
			else
				associated_feature := Void
				feature_cmd := Void
				if selected then
					if widget_owner /= Void then
						widget_owner.set_widget (widget)
					end
					display_header
				end
			end			
		end

	consumed_type: CONSUMED_TYPE

feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_flat, 1)
			Result.put (Pixmaps.Icon_format_flat, 2)
		end
 
	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showflat
		end
 
feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Flat
		end

	post_fix: STRING is "rdotnet"
			-- String symbol of the command, used as an extension when saving.

	formatted_text: STRUCTURED_TEXT

feature {NONE} -- Implementation

	selected_line: INTEGER
			-- Line in the editor in front of which there is an arrowed breakpoint.

	on_breakable_drop (st: BREAKABLE_STONE) is
			-- Launch `st' to the manager.
		do
			manager.set_stone (st)
		end

	feature_cmd: E_SHOW_ROUTINE_FLAT
			-- Class command that can generate the information. Not used.

	create_feature_cmd is
			-- Create `feature_cmd'.
		require else
			associated_feature_non_void: associated_feature /= Void
		do
			create feature_cmd.do_nothing
		end

	generate_text is
		local
			retried: BOOLEAN
		do
			if not retried then
				set_is_with_breakable
				formatted_text := rout_flat_dotnet_text (associated_feature, consumed_type)
				if formatted_text = Void then
					last_was_error := True
				else
					last_was_error := False
				end
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

end -- class EB_DOTNET_FEATURE_FORMATTER
