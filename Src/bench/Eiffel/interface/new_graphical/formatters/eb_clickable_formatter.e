indexing
	description: "Formatter for the clickable version of a class display"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLICKABLE_FORMATTER

inherit
	EB_CLASS_TEXT_FORMATTER
		redefine
			class_cmd,
			set_class,
			generate_text,
			formatted_text
		end

	EB_SHARED_FORMAT_TABLES

creation
	make
	
feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_clickable, 1)
			Result.put (Pixmaps.Icon_format_clickable, 2)
		end
 
	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showclick
		end
 
feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Clickable
		end

	post_fix: STRING is "clk"
			-- String symbol of the command, used as an extension when saving.

	formatted_text: STRUCTURED_TEXT

feature -- Status Setting

	set_class (a_class: CLASS_C) is
			-- Associate current formatter with `a_class'.  Redefined to prevent
			-- attempted formatting of external class type.
		do
			if a_class /= Void and not a_class.is_true_external then
				Precursor (a_class)
			end
		end

feature {NONE} -- Implementation

	class_cmd: E_SHOW_FLAT
			-- Class command that can generate the information. Not used.

	create_class_cmd is
			-- Create `class_cmd'.
		require else
			associated_class_non_void: associated_class /= Void
		do
			create class_cmd.do_nothing
		end

	generate_text is
		local
			retried: BOOLEAN
		do
			if not retried then
				set_is_without_breakable
				formatted_text := clickable_context_text (associated_class)
				if formatted_text = Void then
					last_was_error := True
				else
					last_was_error := False
				end
				if has_breakpoints then
					editor.show_breakpoints
				else
					editor.hide_breakpoints
				end
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

end -- class EB_CLICKABLE_FORMATTER
