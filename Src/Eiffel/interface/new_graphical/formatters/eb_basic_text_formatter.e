﻿note
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
			is_editable,
			set_class,
			format,
			make,
			set_accelerator,
			force_stone
		end

create
	make

feature -- Initialization

	make (a_manager: like manager)
			-- Create a formatter associated with `a_manager'.
		do
			Precursor {EB_CLASS_TEXT_FORMATTER} (a_manager)
			create_class_cmd
			is_editable := True
		end

feature -- Properties

	is_editable: BOOLEAN
			-- Can the generated text be edited?

	symbol: ARRAY [EV_PIXMAP]
			-- Graphical representation of the command.
		once
			create Result.make_filled (pixmaps.icon_pixmaps.view_editor_icon, 1, 2)
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Graphical representation of the command.
		once
			Result := pixmaps.icon_pixmaps.view_editor_icon_buffer
		end

	menu_name: STRING_GENERAL
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showtext_new
		end
feature -- Access

	mode: NATURAL_8
			-- Formatter mode, see {ES_CLASS_TOOL_VIEW_MODES} for applicable values.
		do
			Result := {ES_CLASS_TOOL_VIEW_MODES}.basic
		end

feature -- Formatting

	format
			-- Refresh `widget'.
		local
			f_name: STRING_32
		do
			if
				classi /= Void and then
				selected and then
				displayed and then
				editor /= Void and then
				editor.is_initialized and then
				actual_veto_format_result
			then
				display_temp_header
				setup_viewpoint
				if not equal (classi.file_name, editor.file_name) then
					editor.set_stone (stone)
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
				is_editable :=	not classi.is_read_only and not editor.load_file_error
				editor.set_read_only (not is_editable)
				if has_breakpoints then
					editor.enable_has_breakable_slots
				else
					editor.disable_has_breakable_slots
				end
				display_header
				stone.set_pos_container (Current)
				if editor.stone /= Void then
					editor.stone.set_pos_container (Current)
				end
			end
		end

feature -- Status setting

	set_accelerator (accel: EV_ACCELERATOR)
			-- Changes the accelerator.
		do
			Precursor {EB_CLASS_TEXT_FORMATTER} (accel)
			accelerator.actions.put_front (agent invalidate)
		end

	set_class (a_class: CLASS_C)
			-- Associate `Current' with `a_class'.
		do
			set_classi (a_class.original_class)
		end

	set_stone (new_stone: STONE)
			-- Associate `Current' with class contained in `new_stone'.
		do
			force_stone (new_stone)
			if attached {CLASSI_STONE} new_stone as l_new_stone then
				if not l_new_stone.class_i.is_external_class then
					set_classi (l_new_stone.class_i)
				end
			else
				classi := Void
				if selected then
					editor.clear_window
				end
				ensure_display_in_widget_owner
			end
		end

	set_classi (a_class: CLASS_I)
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
			ensure_display_in_widget_owner
		end

	force_stone (a_stone: STONE)
			-- Directly set `stone' with `a_stone'
		do
			Precursor (a_stone)
			if attached {CLASSI_STONE} a_stone as l_stone then
				set_classi (l_stone.class_i)
			end
		end

feature {NONE} -- Properties

	class_cmd: E_SHOW_FLAT
			-- Just needed for compatibility, do not use.

	classi: CLASS_I
			-- Class currently associated with `Current'.

	capital_command_name: STRING_GENERAL
			-- Name of the command.
		do
			Result := Interface_names.l_Basic_text
		end

	post_fix: STRING = "txt"
			-- String symbol of the command, used as an extension when saving.

feature {NONE} -- Implementation

	generate_text
			-- Create `formatted_text'.
		do
		end

	create_class_cmd
			-- Create `class_cmd'.
		require else
			True
		do
			create class_cmd
		end

	has_breakpoints: BOOLEAN = False
		-- Should `Current' display breakpoints?

	line_numbers_allowed: BOOLEAN = True;
		-- Does it make sense to show line numbers in Current?

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_BASIC_TEXT_FORMATTER
