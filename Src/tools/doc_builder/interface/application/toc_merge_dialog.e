indexing
	description: "Dialog for merging loaded tocs into single toc."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TOC_MERGE_DIALOG

inherit
	TOC_MERGE_DIALOG_IMP
	
	SHARED_OBJECTS
		undefine
			copy,
			default_create
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			toc_list.enable_multiple_selection
			ok_button.select_actions.extend (agent apply)
			cancel_button.select_actions.extend (agent hide)
			show_actions.extend (agent show_tocs)
		end

feature {NONE} -- Implementation

	apply is
			-- Apply.  A new toc is created with 
		local
			l_selected_tocs: LIST [EV_LIST_ITEM]
			l_tocs: ARRAYED_LIST [TABLE_OF_CONTENTS]
			l_new_toc: TABLE_OF_CONTENTS
		do
			if not toc_name_text.text.is_empty then				
				if toc_list.selected_items.count > 1 then
					l_selected_tocs := toc_list.selected_items
					
						-- Get tocs for merge (they are copies of selected tocs)
					from
						create l_tocs.make (2)
						l_selected_tocs.start
					until
						l_selected_tocs.after
					loop					
						create l_new_toc.make_from_toc (shared_toc_manager.toc_by_name (l_selected_tocs.item.text))
						l_tocs.extend (l_new_toc)
						l_selected_tocs.forth
					end
						
						-- Merge tocs
					shared_toc_manager.merge_tocs (l_tocs, toc_name_text.text)
					hide
				end
			end
		end		

	show_tocs is
			-- Show a list of all loaded tocs
		local
			l_tocs: ARRAY [STRING]
			l_toc_name: STRING
			l_cnt: INTEGER
			l_list_item: EV_LIST_ITEM
		do
			l_tocs := Shared_toc_manager.displayed_tocs
			from
				l_cnt := 1
			until
				l_cnt > l_tocs.count
			loop
				l_toc_name := l_tocs.item (l_cnt)			
				create l_list_item.make_with_text (l_toc_name)
				toc_list.extend (l_list_item)
				l_cnt := l_cnt + 1
			end
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
end -- class TOC_MERGE_DIALOG

