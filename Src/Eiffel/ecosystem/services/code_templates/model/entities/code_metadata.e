note
	description: "[
		Represents a code template metadata section.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_METADATA

inherit
	CODE_SUB_NODE [CODE_TEMPLATE_DEFINITION]

create
	make

feature {NONE} -- Initialization

	initialize_nodes (a_factory: like code_factory)
			-- <Precursor>
		do
			set_title (create {STRING_32}.make_empty)
			set_description (create {STRING_32}.make_empty)
			set_author (create {STRING_32}.make_empty)
			set_shortcut (create {STRING_32}.make_empty)
			set_categories (a_factory.new_code_category_collection (Current))
		end

feature -- Access

	title: STRING_32 assign set_title
			-- Code template title, used by UI for a terse description.

	description: STRING_32 assign set_description
			-- Code template description, used by UI for a more detailed descrition of its function.

	author: STRING_32 assign set_author
			-- Owner/author of the code template.

	shortcut: STRING_32 assign set_shortcut
			-- Shortcut identifier, used in editing to insert the code template quickly.

	categories: CODE_CATEGORY_COLLECTION assign set_categories
			-- A collection of categories that the code template belongs to.

feature -- Element change

	set_title (a_title: like title)
			-- Sets a code template title.
			--
			-- `a_title': The title for the code template.
		require
			a_title_attached: attached a_title
		do
			create title.make_from_string (a_title)
		ensure
			title_set: title ~ a_title
		end

	set_description (a_description: like description)
			-- Sets a code template description.
			--
			-- `a_description': A new code template description.
		require
			a_description_attached: attached a_description
		do
			create description.make_from_string (a_description)
		ensure
			description_set: description ~ a_description
		end

	set_author (a_author: like author)
			-- Sets a new code template author.
			--
			-- `a_author': A new author name or other moniker.
		require
			a_author_attached: attached a_author
		do
			create author.make_from_string (a_author)
		ensure
			author_set: author ~ a_author
		end

	set_shortcut (a_shortcut: like shortcut)
			-- Sets a new code template shortcut, used for quick insertion.
			--
			-- `a_shortcut': A shortcut string.
		require
			a_shortcut_attached: attached a_shortcut
		do
			create shortcut.make_from_string (a_shortcut)
		ensure
			shortcut_set: shortcut ~ a_shortcut
		end

	set_categories (a_categories: like categories)
			-- Sets a new collection of categories.
			--
			-- `a_categories': A new category collection.
		require
			a_categories_attached: attached a_categories
		do
			categories := a_categories
			a_categories.parent := Current
		ensure
			categories_set: categories = a_categories
			categories_parent_set: categories.parent = Current
		end

feature -- Visitor

	process (a_visitor: CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_metadata (Current)
		end

invariant
	title_attached: is_initialized implies attached title
	description_attached: is_initialized implies attached description
	author_attached: is_initialized implies attached author
	shortcut_attached: is_initialized implies attached shortcut
	categories_attached: is_initialized implies attached categories

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end
