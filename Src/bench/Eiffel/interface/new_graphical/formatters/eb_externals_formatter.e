indexing
	description: "Command to display class external routines."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNALS_FORMATTER

inherit
	EB_CLASS_TEXT_FORMATTER
		redefine
			class_cmd
		end

creation
	make
	
feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_externals, 1)
			Result.put (Pixmaps.Icon_format_externals, 2)
		end
 
	class_cmd: E_SHOW_EXTERNALS
			-- Class command that can generate the information.

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showexternals
		end
 
feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_External
		end

	post_fix: STRING is "ext"
			-- String symbol of the command, used as an extension when saving.

feature {NONE} -- Implementation

	create_class_cmd is
			-- Create `class_cmd'.
		require else
			associated_class_non_void: associated_class /= Void
		do
			create class_cmd.make (associated_class)
		end

end -- class EB_EXTERNALS_FORMATTER
