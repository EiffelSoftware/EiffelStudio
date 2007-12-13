indexing
	description: "[
		A EiffelStudio discardable confirmation prompt that requests user saves modified files prior to exiting EiffelStudio.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_EXIT_SAVE_FILES_PROMPT

inherit
	ES_QUESTION_PROMPT
		rename
			make as make_question_prompt
		redefine
			build_prompt_interface,
			is_size_and_position_remembered
		end

create
	make

feature {NONE} -- Initialization

	make (a_class_list: like class_list)
			-- Initialize a discardable class list dialog
		require
			a_class_list_attached: a_class_list /= Void
			not_a_class_list_is_empty: not a_class_list.is_empty
		do
			class_list := a_class_list
			make_standard (interface_names.l_exit_warning)
			set_sub_title (interface_names.st_unsaved_changed)
		end

feature {NONE} -- User interface initialization

	build_prompt_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			-- Note: Redefine to add widgets before the discardable check.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			l_classes: DS_BILINEAR_CURSOR [CLASS_I]
			l_list: ES_GRID
			l_tabbable: EV_TAB_CONTROLABLE
			i: INTEGER
		do
			Precursor {ES_QUESTION_PROMPT} (a_container)

			if class_list /= Void and then not class_list.is_empty then
				create l_list
				l_list.disable_border
				l_list.hide_header

					-- Current hack because EV_GRID does not implement EV_TAB_CONTROLABLE				
				l_tabbable ?= l_list
				if l_tabbable /= Void then
					l_tabbable.disable_tabable_to
				end

					-- Prevent selection
				l_list.disable_selection_on_click
				l_list.disable_always_selected

					-- Size size info				
				l_list.set_minimum_width (300)
				l_list.set_column_count_to (1)
				l_list.column (1).set_width (300)
				l_list.set_row_height (18)
				l_list.set_minimum_height (class_list.count.min (14) * 18)

					-- Add rows
				l_list.set_row_count_to (class_list.count)
				i := 1
				l_classes := class_list.new_cursor
				from l_classes.start until l_classes.after loop
					populate_row (l_classes.item, l_list.row (i))
					l_classes.forth
					i := i + 1
				end

				a_container.extend (l_list)
			end
		end

	populate_row (a_class: CLASS_I; a_row: EV_GRID_ROW) is
			-- Populates a row with the information from a given class
			--
			-- `a_class': Class interface used to populate the grid row
			-- `a_row': A grid row to populate
		require
			a_class_attached: a_class /= Void
			a_row_attached: a_row /= Void
		local
			l_item: EV_GRID_LABEL_ITEM
		do
				-- Class
			create l_item.make_with_text (a_class.name)
			l_item.set_pixmap (pixmap_factory.pixmap_from_class_i (a_class))
			l_item.set_tooltip (a_class.file_name)
			l_item.set_font (fonts.prompt_text_font)
			l_item.set_foreground_color (colors.prompt_text_forground_color)
			l_item.set_left_border (25)

			a_row.set_item (1, l_item)
		end

feature {NONE} -- Status report

	is_size_and_position_remembered: BOOLEAN
			-- Indicates if the size and position information is remembered for the dialog
		do
				-- Prompts should not remember size and position information.
			Result := True
		end

feature -- Access

	class_list: DS_BILINEAR [CLASS_I]
			-- List of modified class files

invariant
	class_list_attached: class_list /= Void
	not_class_list_is_empty: not class_list.is_empty
	class_list_contains_attached_items: not class_list.has (Void)

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This class is part of Eiffel Software's Eiffel Development Environment.
			
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
