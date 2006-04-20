indexing
	description: "Command to display flat form of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FLAT_FORMATTER

inherit
	EB_CLASS_TEXT_FORMATTER
		redefine
			class_cmd,
			set_class,
			generate_text,
			make
		end

	EB_SHARED_FORMAT_TABLES

create
	make

feature {NONE} -- Initialization

	make (a_manager: like manager) is
			-- Initialize `Current'.
		do
			Precursor (a_manager)
		end

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

	post_fix: STRING is "flt"
			-- String symbol of the command, used as an extension when saving.

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
			create class_cmd
		end

	generate_text is
		local
			retried: BOOLEAN
		do
			if not retried and associated_class /= Void then
				set_is_with_breakable
				if associated_class /= Void then
					editor.handle_before_processing (false)
					last_was_error := flat_context_text (associated_class, editor.text_displayed)
					editor.handle_after_processing
				end
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

	has_breakpoints: BOOLEAN is True
		-- Should `Current' display breakpoints?	

	line_numbers_allowed: BOOLEAN is False;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FLAT_FORMATTER
