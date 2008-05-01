indexing
	description: "[
		A EiffelStudio confirmation prompt that requests user saves modified features in EiffelStudio.
	]"
	legal: "See notice at end of feature."
	status: "See notice at end of feature.";
	date: "$date$";
	revision: "$revision$"

class
	ES_SAVE_FEATURES_PROMPT

inherit
	ES_SAVE_ENTITY_PROMPT [E_FEATURE]
		rename
			entities as features,
			set_entities as set_features
		end

create
	make_standard,
	make_standard_with_cancel

feature {NONE} -- Population

	populate_row (a_entity: E_FEATURE; a_row: EV_GRID_ROW) is
			-- <Precursor>
		local
--			l_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_item: EV_GRID_LABEL_ITEM
--			l_generator: like token_generator
			l_printer: like context_printer
			l_yank: YANK_STRING_WINDOW
		do
--			l_generator := token_generator
--			l_generator.wipe_out_lines

			create l_yank.make
			l_printer := context_printer
			l_printer.print_context_feature (l_yank, a_entity, a_entity.written_class)

			create l_item.make_with_text (l_yank.stored_output)
			l_item.set_pixmap (pixmap_factory.pixmap_from_e_feature (a_entity))
			l_item.set_tooltip (a_entity.name + " from " + a_entity.written_class.name_in_upper)
			l_item.set_font (fonts.prompt_text_font)
			l_item.set_foreground_color (colors.prompt_text_foreground_color)
			l_item.set_left_border (25)

--			l_item.set_text_with_tokens (l_generator.tokens (0))
--			l_item.set_pixmap (pixmap_factory.pixmap_from_e_feature (a_entity))
--			l_item.set_tooltip (a_entity.name + " from " + a_entity.written_class.name_in_upper)
--			l_item.set_overriden_fonts (shared_writer.label_font_table, shared_writer.label_font_height)
--			l_item.set_foreground_color (colors.prompt_text_forground_color)
--			l_item.set_left_border (25)

			a_row.set_item (1, l_item)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This feature is part of Eiffel Software's Eiffel Development Environment.
			
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

end
