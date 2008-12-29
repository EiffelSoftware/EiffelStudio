note
	description: "[
					Visitor to print query language items into editor tokens					
					Every time before generating text, call `wipe_out_text' to clean `text', and then generated.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_QUERY_LANGUAGE_PRINTER_VISITOR

inherit
	QL_VISITOR

	EB_SHARED_WRITER

	SHARED_TEXT_ITEMS

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize Current.
		do
			set_is_class_name_displayed (True)
		end

feature -- Access

	output: EB_QUERY_LANGUAGE_PRINTER_OUTPUT
			-- Output to store visiting result

feature -- Status report

	is_text_empty: BOOLEAN
			-- Is `text' empty (i.e., no editor token in it)?
		require
			output_attached: output /= Void
		do
			Result := output.is_output_empty
		ensure
			good_result: Result = output.is_output_empty
		end

	is_folder_displayed: BOOLEAN
			-- Should folder where a class is located be displayed?
			-- Default: False

	is_class_name_displayed: BOOLEAN
			-- Should class name be processed?
			-- Used when `is_folder_displayed' is True to display folder information for a class without class name
			-- Default: True			

feature -- Output generation

	wipe_out_output
			-- Wipe out `output'.
		require
			output_attached: output /= Void
		do
			output.initialize_last_output
		ensure
			output_wiped_output: output.is_output_empty
		end

	generate_output (a_item: QL_ITEM)
			-- Generate output for `a_item', store it in `output'.
		require
			a_item_attached: a_item /= Void
			output_attached: output /= Void
		do
			a_item.process (Current)
		end

feature -- Setting

	set_is_folder_displayed (b: BOOLEAN)
			-- Set `is_folder_displayed' with `b'.
		do
			is_folder_displayed := b
		ensure
			is_folder_displayed_set: is_folder_displayed = b
		end

	set_is_class_name_displayed (b: BOOLEAN)
			-- Set `is_class_name_displayed' with `b'.
		do
			is_class_name_displayed := b
		ensure
			should_class_be_processed_set: is_class_name_displayed = b
		end

	set_output (a_output: like output)
			-- Set `output' with `a_output'.
		require
			a_output_attached: a_output /= Void
		do
			output := a_output
		ensure
			output_set: output = a_output
		end

feature -- Process

	process_domain (a_item: QL_DOMAIN)
			-- Process `a_item'.
		do
			-- Do nothing.
		end

	process_item_internal (a_item: QL_ITEM)
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		local
			l_output: like output
		do
			l_output := output
			if not is_text_empty then
				l_output.process_dot_separator
			end
			output.process_item (a_item)
		end


	process_target (a_item: QL_TARGET)
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_group (a_item: QL_GROUP)
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_class (a_item: QL_CLASS)
			-- Process `a_item'.
		local
			l_folder: STRING
			l_separator: CHARACTER
			l_folders: LIST [STRING]
			l_text_style: EB_TEXT_EDITOR_TOKEN_STYLE
			l_count: INTEGER
			l_group: CONF_GROUP
			l_path: STRING
			l_name: STRING
			l_should_put_separator: BOOLEAN
			l_output: like output
		do
			l_output := output

				-- Display folder for `a_item'.
			if is_folder_displayed then
				l_folder := a_item.conf_class.path
				if l_folder /= Void and then not l_folder.is_empty then
					l_folder := l_folder.twin
					l_separator := '/'
					l_folders := l_folder.split (l_separator)

					create l_text_style
					create l_path.make (64)
					l_group := a_item.conf_class.group
					l_should_put_separator := not is_text_empty
					from
						l_count := l_folders.count
						l_folders.start
					until
						l_folders.after
					loop
						l_name := l_folders.item
						if not l_name.is_empty then
							l_path.append_character (l_separator)
							l_path.append (l_name)
							if l_should_put_separator then
								l_output.process_dot_separator
							end
							l_output.process_folder (l_name, l_path, l_group)
							l_should_put_separator := True
						end
						l_folders.forth
					end
				end
			end

				-- Display class name for `a_item'.
			if is_class_name_displayed then
				if not is_text_empty then
					l_output.process_dot_separator
				end
				output.process_item (a_item)
			end
		end

	process_feature (a_item: QL_FEATURE)
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_real_feature (a_item: QL_REAL_FEATURE)
			-- Process `a_item'.
		do
			process_feature (a_item)
		end

	process_invariant (a_item: QL_INVARIANT)
			-- Process `a_item'.
		do
			process_feature (a_item)
		end

	process_quantity (a_item: QL_QUANTITY)
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_line (a_item: QL_LINE)
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_generic (a_item: QL_GENERIC)
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_local (a_item: QL_LOCAL)
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_argument (a_item: QL_ARGUMENT)
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_assertion (a_item: QL_ASSERTION)
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_path (a_item: QL_ITEM; a_self_included: BOOLEAN; a_parent_included: BOOLEAN; a_indirect_parent_included: BOOLEAN; a_target_included: BOOLEAN)
			-- Process `a_item' and write path of `a_item' into `text_internal' in form of "grand_parent.parent.item"
			-- If `a_self_included' is True, including `a_item' itself.
			-- If `a_parent_included' is True, including direct parent of `a_item'.
			-- If `a_indirect_parent_included" is True, including indirect parent of `a_item'.
			-- If `a_target_included' is True, including target parents, otherwise, target parents will be omited. Has no effect if `a_self_included' is True and
			-- `a_item' is a target.
		require
			a_item_attached: a_item /= Void
		local
			l_list: LINKED_LIST [QL_ITEM]
			l_parent: QL_ITEM
			l_curr_item: QL_ITEM
			l_old_is_class_name_displayed: BOOLEAN
		do
			l_curr_item := a_item
			l_old_is_class_name_displayed := is_class_name_displayed

			create l_list.make

				-- Insert `a_item' itself.
			if a_self_included then
				l_list.extend (l_curr_item)
			else
				if l_curr_item.is_class and then is_folder_displayed then
					set_is_class_name_displayed (False)
					l_list.extend (l_curr_item)
				end
			end

				-- Insert direct parent.
			l_parent := l_curr_item.parent_with_real_path
			if a_parent_included and then l_parent /= Void then
				if not l_parent.is_target or else a_target_included then
					l_list.put_front (l_parent)
				end
			end
			l_curr_item := l_parent

				-- Insert indirect parent.
			if a_indirect_parent_included and then l_curr_item /= Void then
				from
					l_parent := l_curr_item.parent
				until
					l_parent = Void
				loop
					if not l_parent.is_target or else a_target_included then
						l_list.put_front (l_parent)
					end
					l_parent := l_parent.parent
				end
			end

				-- Print.
			if not l_list.is_empty then
				if l_list.count = 1 then
					l_list.first.process (Current)
				else
					from
						l_list.start
					until
						l_list.after
					loop
						l_list.item.process (Current)
						l_list.forth
					end
				end
			end
			set_is_class_name_displayed (l_old_is_class_name_displayed)
		end

note
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

end
