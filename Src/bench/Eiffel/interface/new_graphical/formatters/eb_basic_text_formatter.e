indexing
	description: "Formatter to display the text a class with no analysis."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_BASIC_TEXT_FORMATTER

inherit
	EB_CLASS_TEXT_FORMATTER
		redefine
			set_stone,
			generate_text,
			class_cmd,
			editable,
			formatted_text,
			set_class,
			format,
			make,
			set_accelerator
		end

create
	make

feature -- Initialization

	make (a_manager: like manager) is
			-- Create a formatter associated with `a_manager'.
		do
			Precursor {EB_CLASS_TEXT_FORMATTER} (a_manager)
			create_class_cmd
			create formatted_text.make
			editable := True
		end

feature -- Properties

	editable: BOOLEAN
			-- Can the generated text be edited?

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_text, 1)
			Result.put (Pixmaps.Icon_format_text, 2)
		end

	formatted_text: STRUCTURED_TEXT
			-- Text representing `classi'.

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showtext_new
		end

feature -- Formatting

	format is
			-- Refresh `widget'.
		local
			class_file: RAW_FILE
			f_name: STRING
		do
			if
				classi /= Void and then
				selected and then
				displayed 
			then
				display_temp_header
				create class_file.make (classi.file_name)
				if class_file.exists then
					if not equal (classi.file_name, editor.file_name) then
						editor.load_file (classi.file_name)
						go_to_position
					end
					if editor.load_file_error then
						f_name := editor.file_name
						editor.clear_window
						if f_name = Void or else f_name.is_empty then
							f_name := classi.file_name
						end
						editor.display_message (Warning_messages.w_Cannot_read_file (f_name))
					end
				else
					editor.clear_window
					editor.display_message (Warning_messages.w_file_not_exist (classi.file_name))
				end
				editable :=	not classi.cluster.is_precompiled and
							not classi.is_read_only and
							(class_file.exists and then class_file.is_writable) and
							not editor.load_file_error
				editor.set_read_only (not editable)
				if has_breakpoints then
					editor.enable_has_breakable_slots
				else
					editor.disable_has_breakable_slots
				end
				must_format := False
				display_header
			end
		end


feature -- Status setting

	set_accelerator (accel: EV_ACCELERATOR) is
			-- Changes the accelerator.
		do
			Precursor {EB_CLASS_TEXT_FORMATTER} (accel)
			accelerator.actions.put_front (agent invalidate)
		end

	set_class (a_class: CLASS_C) is
			-- Associate `Current' with `a_class'.
		do
			set_classi (a_class.lace_class)
		end

	set_stone (new_stone: CLASSI_STONE) is
			-- Associate `Current' with class contained in `new_stone'.
		local
			a_stone: CLASSI_STONE
		do
			force_stone (new_stone)
			a_stone ?= new_stone
			if a_stone /= Void then
				if not new_stone.class_i.is_external_class then
					set_classi (a_stone.class_i)
				end
			else
				classi := Void
				if selected then
					if widget_owner /= Void then
						widget_owner.set_widget (widget)
					end
					editor.clear_window
					display_header
				end
			end
		end

	set_classi (a_class: CLASS_I) is
			-- Associate current formatter with `a_class'.
		do
			classi := a_class
			if a_class = Void then
				class_cmd := Void
			else
				create_class_cmd
			end
			must_format := True
			format
			if selected then
				if widget_owner /= Void then
					widget_owner.set_widget (widget)
				end
				display_header
			end
		end

feature {NONE} -- Properties

	class_cmd: E_SHOW_FLAT
			-- Just needed for compatibility, do not use.

	classi: CLASS_I
			-- Class currently associated with `Current'.

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
--			create formatted_text.make
--			formatted_text.add_string (classi.text)
		end

	create_class_cmd is
			-- Create `class_cmd'.
		require else
			True
		do
			create class_cmd
		end

	has_breakpoints: BOOLEAN is False
		-- Should `Current' display breakpoints?

	line_numbers_allowed: BOOLEAN is True;
		-- Does it make sense to show line numbers in Current?
			
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_BASIC_TEXT_FORMATTER
