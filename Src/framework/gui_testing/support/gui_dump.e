note
	description: "Facilities to dump a GUI tree to file or the standard output"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GUI_DUMP

feature -- Access

	dump_file_name: STRING
			-- File name for dump

feature -- Element change

	set_dump_file_name (a_file_name: like dump_file_name)
			-- Set `dump_file_name' to `a_file_name'.
		do
			dump_file_name := a_file_name
		ensure
			dump_file_name_set: dump_file_name = a_file_name
		end

	clear_dump_file
			-- Clear existing dump file.
		local
			a_file: PLAIN_TEXT_FILE
		do
			create a_file.make_open_write (dump_file_name)
			a_file.close
		end

feature -- Support

	dump_tree (an_application: EV_APPLICATION)
			-- Dump whole GUI tree.
		do
			an_application.windows.do_all (agent dump_window)
		end

	dump_window (a_window: EV_WINDOW)
			-- Dump window.
		do
			print_line ("Window ("+a_window.title+")")
			print_new_line
			indent
				print_line ("Title: "+a_window.title)
				dump_class_info (a_window)
				print_new_line
				indent
					if a_window.menu_bar /= Void then
						dump_menu_bar (a_window.menu_bar)
					end
					print_new_line
					a_window.linear_representation.do_all (agent dump_widget)
				undent
			undent
		end

	dump_class_info (an_any: EV_ANY)
			-- Dump class information.
		local
			a_textable: EV_TEXTABLE
			an_identifiable: EV_IDENTIFIABLE
			a_positioned: EV_POSITIONED
		do
			print_line ("Generating type: "+an_any.generating_type)
			a_textable ?= an_any
			if a_textable /= Void then
				dump_textable (a_textable)
			end
			an_identifiable ?= an_any
			if an_identifiable /= Void then
				dump_identifier (an_identifiable)
			end
			a_positioned ?= an_any
			if a_positioned /= Void then
				dump_position (a_positioned)
			end
		end

	dump_position (a_positioned: EV_POSITIONED)
			-- Dump position.
		do
			print_line ("Screen Position: "+a_positioned.screen_x.out+" / "+a_positioned.screen_y.out)
			print_line ("Relative Position: "+a_positioned.x_position.out+" / "+a_positioned.y_position.out)
			print_line ("Dimension: "+a_positioned.width.out+" / "+a_positioned.height.out)
		end

	dump_identifier (an_identifiable: EV_IDENTIFIABLE)
			-- Dump identifier.
		do
			print_line ("Identifier name: "+an_identifiable.identifier_name)
			print_line ("Full path: "+an_identifiable.full_identifier_path)
		end

	dump_textable (a_textable: EV_TEXTABLE)
			-- Dump textable.
		do
			print_line ("Text: "+a_textable.text)
		end

	dump_menu_bar (a_menu_bar: EV_MENU_BAR)
			-- Dump menu bar.
		do
			print_line ("Menu bar")
			print_new_line
			indent
				dump_class_info (a_menu_bar)
				print_new_line
				a_menu_bar.linear_representation.do_all (agent dump_menu_item)
			undent
		end

	dump_menu_item (a_menu_item: EV_MENU_ITEM)
			-- Dump menu item.
		local
			a_menu: EV_MENU
		do
			print_line ("Menu item ("+a_menu_item.text+")")
			print_new_line
			indent
				dump_class_info (a_menu_item)
				print_new_line
				a_menu ?= a_menu_item
				if a_menu /= Void then
					indent
						a_menu.linear_representation.do_all (agent dump_menu_item)
					undent
				end
			undent
		end

	dump_item (an_item: EV_ITEM)
			--
		local
			an_item_list: EV_ITEM_LIST [EV_ITEM]
		do
			print_line ("Item")
			print_new_line
			indent
				dump_class_info (an_item)
				print_new_line

				an_item_list ?= an_item
				if an_item_list /= Void then
					an_item_list.linear_representation.do_all (agent dump_item)
				end
			undent
		end

	dump_widget (a_widget: EV_WIDGET)
			--
		local
			an_item_list: EV_ITEM_LIST [EV_ITEM]
			a_container: EV_CONTAINER
		do
			print_line ("Widget")
			print_new_line
			indent
				dump_class_info (a_widget)
				print_new_line

				an_item_list ?= a_widget
				if an_item_list /= Void then
					an_item_list.linear_representation.do_all (agent dump_item)
				end

				a_container ?= a_widget
				if a_container /= Void then
					a_container.linear_representation.do_all (agent dump_widget)
				end
			undent
		end

feature {NONE} -- Implementation

	current_indentation: INTEGER

	indent
			--
		do
			current_indentation := current_indentation + 1
		end

	undent
			--
		do
			current_indentation := current_indentation - 1
		end

	print_indentation
			--
		do
			print_text (create {STRING}.make_filled ('%T', current_indentation))
		end

	print_new_line
			--
		do
			print_text ("%N")
		end

	print_line (a_text: STRING_32)
			--
		do
			print_indentation
			print_text (a_text)
			print_new_line
		end

	print_text (a_text: READABLE_STRING_32)
			--
		local
			a_file: PLAIN_TEXT_FILE
		do
			if dump_file_name = Void then
				io.put_string_32 (a_text)
			else
				create a_file.make_open_append (dump_file_name)
				a_file.put_string_32 (a_text)
				a_file.close
			end
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
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

end
