indexing
	description: "Command to display the short version of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHORT_FORMATTER

inherit
	EB_CLASS_TEXT_FORMATTER
		redefine
			class_cmd,
			generate_text,
			set_stone,
			is_dotnet_formatter,
			line_numbers_allowed
		end

	EB_SHARED_FORMAT_TABLES

create
	make

feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (pixmaps.icon_pixmaps.view_contracts_icon, 1)
			Result.put (pixmaps.icon_pixmaps.view_contracts_icon, 2)
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Graphical representation of the command.
		once
			Result := pixmaps.icon_pixmaps.view_contracts_icon_buffer
		end

	menu_name: STRING_GENERAL is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showshort
		end

 	is_dotnet_formatter: BOOLEAN is
 			-- Is Current able to format .NET XML types?
 		do
 			Result := True
 		end

feature {NONE} -- Properties

	capital_command_name: STRING_GENERAL is
			-- Name of the command.
		do
			Result := Interface_names.l_Short
		end

	post_fix: STRING is "sho"
			-- String symbol of the command, used as an extension when saving.

	consumed_type: CONSUMED_TYPE
			-- The .NET consumed undergoing formatting.

	class_i: EXTERNAL_CLASS_I
			-- Class currently associated with `Current'.

feature -- Access

	mode: NATURAL_8
			-- Formatter mode, see {ES_CLASS_TOOL_VIEW_MODES} for applicable values.
		do
			Result := {ES_CLASS_TOOL_VIEW_MODES}.short
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
			if not retried then
				set_is_with_breakable
				if not is_dotnet_mode then
					editor.handle_before_processing (false)
					if associated_class /= Void then
						last_was_error := short_context_text (associated_class, editor.text_displayed)
					end
					editor.handle_after_processing
				else
					editor.handle_before_processing (false)
					set_is_without_breakable
					if class_i /= Void then
						last_was_error := short_dotnet_text (consumed_type, class_i, editor.text_displayed)
					elseif associated_class /= Void then
						last_was_error := short_dotnet_text (consumed_type, associated_class.lace_class, editor.text_displayed)
					end
					editor.handle_after_processing
				end
				if has_breakpoints then
					editor.enable_has_breakable_slots
				else
					editor.enable_has_breakable_slots
				end
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

	has_breakpoints: BOOLEAN is False
		-- Should `Current' display breakpoints?

	line_numbers_allowed: BOOLEAN is False
			-- Does it make sense to show line numbers in Current?

feature -- Status setting

	set_stone (new_stone: CLASSI_STONE) is
			-- Associate `Current' with class contained in `new_stone'.
		local
			a_stone: CLASSC_STONE
			l_ext_class: EXTERNAL_CLASS_I
		do
			stone := new_stone
			if new_stone /= Void and new_stone.class_i.is_external_class then
				set_dotnet_mode (True)
				a_stone ?= new_stone
				if
					a_stone /= Void and then a_stone.e_class /= Void and then
					a_stone.e_class.has_feature_table
				then
					-- Is compiled .NET type.
					if consumed_types.has (a_stone.class_i.name) then
						consumed_type := consumed_types.item (a_stone.class_i.name)
					else
						l_ext_class ?= a_stone.class_i
						check
							l_ext_class_not_void: l_ext_class /= Void
						end
						consumed_type := l_ext_class.external_consumed_type
						if consumed_type /= Void then
							consumed_types.put (consumed_type, a_stone.class_i.name)
						end
					end
					class_i := Void
					set_class (a_stone.e_class)
				else
					l_ext_class ?= new_stone.class_i
					check
						l_ext_class_not_void: l_ext_class /= Void
					end
					consumed_type := l_ext_class.external_consumed_type
					associated_class := Void
					set_classi (new_stone.class_i)
				end
			else
				set_dotnet_mode (False)
				Precursor {EB_CLASS_TEXT_FORMATTER} (new_stone)
			end
		end

	set_classi (a_class: CLASS_I) is
			-- Associate current formatter with `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			class_i ?= a_class
			class_cmd := Void
			must_format := True
			format
			ensure_display_in_widget_owner
		end

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

end -- class EB_SHORT_FORMATTER
