indexing
	description: "Formats structured text."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_FORMATTER

feature -- Output

	process_text (text: STRUCTURED_TEXT) is
			-- Process structured text `text' to be
			-- generated as output.
		do
			if text /= Void then
				from
					text.start
				until
					text.after
				loop
					(text.item).append_to (Current)
					text.forth
				end
			end
		end

feature {TEXT_ITEM} -- Implementation

	process_basic_text (text: BASIC_TEXT) is
			-- Process default basic text `t'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_character_text (text: CHARACTER_TEXT) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_number_text (text: NUMBER_TEXT) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_string_text (text: STRING_TEXT) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_new_line (text: NEW_LINE_ITEM) is
			-- Process new line text `t'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_indentation (text: INDENT_TEXT) is
			-- Process indentation `t'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_keyword_text (text: KEYWORD_TEXT) is
			-- Process keyword text.
		require
			text_not_void: text /= Void
		deferred
		end

end -- class TEXT_FORMATTER
