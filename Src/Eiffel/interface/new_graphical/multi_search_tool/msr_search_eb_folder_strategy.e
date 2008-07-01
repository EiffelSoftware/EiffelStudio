indexing
	description: "Strategy search in a folder of a group"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_EB_FOLDER_STRATEGY

inherit
	MSR_SEARCH_GROUP_STRATEGY
		rename
			make as make_old
		export
			{NONE} set_group
		redefine
			launch
		end

	QL_UTILITY

	QL_SHARED

create
	make

feature -- Initialization

	make (a_keyword: like keyword;
			a_range: like surrounding_text_range;
			a_folder: like folder;
			only_compiled_class: like only_compiled_class_searched) is
			-- Initialization
		require
			a_folder_not_void: a_folder /= Void
			keyword_attached: a_keyword /= Void
			range_positive: a_range >= 0
		do
			make_old (a_keyword, a_range, a_folder.cluster, only_compiled_class)
			set_folder (a_folder)
		ensure
			folder_not_void: folder = a_folder
		end

feature -- Access

	folder: EB_FOLDER
			-- Folder in which search is done

feature -- Element change

	set_folder (a_folder: like folder) is
			-- Set `folder' with `a_folder'.
		require
			a_folder_not_void: a_folder /= Void
		do
			folder := a_folder
		ensure
			folder_not_void: folder = a_folder
		end

feature -- Search

	launch is
			-- Launch searching
		local
			l_ql_group: QL_GROUP
			l_class_domain_generator: QL_CLASS_DOMAIN_GENERATOR
			l_class_cri: QL_CLASS_CRITERION
			l_class_domain: QL_CLASS_DOMAIN
		do
			create item_matched_internal.make (100)
			create l_ql_group.make (group)
			l_ql_group := query_group_item_from_conf_group (group)
			if only_compiled_class_searched then
				l_class_cri := class_criterion_factory.simple_criterion_with_index (
					class_criterion_factory.c_is_compiled)
			end
			if is_subgroup_searched then
				if l_class_cri = Void then
					create {QL_CLASS_PATH_IN_CRI}l_class_cri.make (folder.path)
				else
					l_class_cri := l_class_cri and create {QL_CLASS_PATH_IN_CRI}.make (folder.path)
				end
			else
				if l_class_cri = Void then
					create {QL_CLASS_PATH_IN_CRI}l_class_cri.make_with_flag (folder.path, False)
				else
					l_class_cri := l_class_cri and create {QL_CLASS_PATH_IN_CRI}.make_with_flag (folder.path, False)
				end
			end
			create l_class_domain_generator
			l_class_domain_generator.set_criterion (l_class_cri)
			l_class_domain_generator.enable_fill_domain
			l_class_domain ?= l_ql_group.wrapped_domain.new_domain (l_class_domain_generator)
			from
				l_class_domain.start
			until
				l_class_domain.after
			loop
				create class_strategy.make (keyword, surrounding_text_range_internal, l_class_domain.item.class_i, only_compiled_class_searched)
				if case_sensitive then
					class_strategy.set_case_sensitive
				else
					class_strategy.set_case_insensitive
				end
				class_strategy.set_regular_expression_used (is_regular_expression_used)
				class_strategy.set_whole_word_matched (is_whole_word_matched)
				class_strategy.launch
				if class_strategy.is_launched then
					item_matched_internal.finish
					item_matched_internal.merge_right (class_strategy.item_matched)
				end
				l_class_domain.forth
			end
			launched := True
			if not item_matched_internal.is_empty then
				item_matched_internal.start
			end
		end

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

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

end
