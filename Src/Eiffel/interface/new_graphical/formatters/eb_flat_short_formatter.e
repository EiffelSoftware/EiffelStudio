note
	description: "Command to display the flat/short version of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FLAT_SHORT_FORMATTER

inherit
	EB_CLASS_TEXT_FORMATTER
		redefine
			class_cmd,
			generate_text,
			set_stone,
			is_dotnet_formatter
		end

	EB_SHARED_FORMAT_TABLES

create
	make

feature -- Properties

	symbol: ARRAY [EV_PIXMAP]
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (pixmaps.icon_pixmaps.view_flat_contracts_icon, 1)
			Result.put (pixmaps.icon_pixmaps.view_flat_contracts_icon, 2)
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Graphical representation of the command.
		once
			Result := pixmaps.icon_pixmaps.view_flat_contracts_icon_buffer
		end

	menu_name: STRING_GENERAL
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showfs
		end

 	is_dotnet_formatter: BOOLEAN
 			-- Is Current able to format .NET XML types?
 		do
 			Result := True
 		end

feature {NONE} -- Properties

	capital_command_name: STRING_GENERAL
			-- Name of the command.
		do
			Result := Interface_names.l_Flatshort
		end

	post_fix: STRING = "fs"
			-- String symbol of the command, used as an extension when saving.

	internal_consumed_type: CONSUMED_TYPE
			-- The .NET consumed undergoing formatting.

	class_i: EXTERNAL_CLASS_I
			-- Class currently associated with `Current'.

feature -- Access

	mode: NATURAL_8
			-- Formatter mode, see {ES_CLASS_TOOL_VIEW_MODES} for applicable values.
		do
			Result := {ES_CLASS_TOOL_VIEW_MODES}.flat_short
		end

feature {NONE} -- Implementation

	class_cmd: E_SHOW_FS
			-- Class command that can generate the information. Not used.

	create_class_cmd
			-- Create `class_cmd'.
		require else
			associated_class_non_void: associated_class /= Void
		do
			create class_cmd
		end

	generate_text
		local
			retried: BOOLEAN
		do
			if not retried and associated_class /= Void then
				set_is_without_breakable
				if not is_dotnet_mode then
					editor.handle_before_processing (false)
					if associated_class /= Void then
						last_was_error := flatshort_context_text (associated_class, editor.text_displayed)
					end
					editor.handle_after_processing
				else
					editor.handle_before_processing (false)
					if class_i /= Void then
						last_was_error := flatshort_dotnet_text (internal_consumed_type, class_i, editor.text_displayed)
					elseif associated_class /= Void then
						last_was_error := flatshort_dotnet_text (internal_consumed_type, associated_class.original_class, editor.text_displayed)
					end
					editor.handle_after_processing
				end

				if has_breakpoints then
					editor.enable_has_breakable_slots
				else
					editor.disable_has_breakable_slots
				end
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

	has_breakpoints: BOOLEAN = False
			-- Should `Current' display breakpoints?

	line_numbers_allowed: BOOLEAN = False
		-- Does it make sense to show line numbers in Current?

feature -- Status setting

	set_stone (new_stone: detachable STONE)
			-- Associate `Current' with class contained in `new_stone'.
		do
			stone := new_stone
			if attached {CLASSI_STONE} new_stone as l_new_stone and then l_new_stone.class_i.is_external_class then
				set_dotnet_mode (True)
				if attached {CLASSC_STONE} l_new_stone as l_classc_stone then
					internal_consumed_type := consumed_type (l_classc_stone.class_i)
					class_i := Void
				else
					internal_consumed_type := consumed_type (l_new_stone.class_i)
					associated_class := Void
				end
			else
				set_dotnet_mode (False)
				internal_consumed_type := Void
			end
			Precursor {EB_CLASS_TEXT_FORMATTER} (new_stone)
		end

	set_classi (a_class: CLASS_I)
			-- Associate current formatter with non-compiled `a_class'.
		do
			class_i ?= a_class
			class_cmd := Void
			must_format := True
			format
			ensure_display_in_widget_owner
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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

end -- class EB_FLAT_SHORT_FORMATTER

