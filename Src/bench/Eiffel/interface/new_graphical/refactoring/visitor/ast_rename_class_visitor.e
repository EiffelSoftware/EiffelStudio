indexing
	description: "Visitor that changes all occurances of a class name to a new name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_RENAME_CLASS_VISITOR

inherit
	AST_REFACTORING_VISITOR
		redefine
			process_class_type_as,
			process_class_as,
			process_client_as,
			process_break_as,
			process_string_as, process_verbatim_string_as
		end


create
	make

feature {NONE} -- Initialization

	make (an_old_class_name: STRING; a_new_class_name: STRING; a_change_comments: BOOLEAN; a_change_strings: BOOLEAN) is
			-- Create a visitor that renames the class `an_old_class_name' into `a_new_class_name'.
			-- `a_change_comments' specifies if the occurance of the name in comments should be changed.
			-- `a_change_strings' specifies if the occurance of the name in strings should be changed.
		require
			an_old_class_name_ok: an_old_class_name /= Void and not an_old_class_name.is_empty
			a_new_class_name_ok: a_new_class_name /= Void and not a_new_class_name.is_empty
			an_old_class_name_upper: an_old_class_name.is_equal (an_old_class_name.as_upper)
			a_new_class_name_upper: a_new_class_name.is_equal (a_new_class_name.as_upper)
		do
			old_class_name := an_old_class_name
			new_class_name := a_new_class_name
			change_comments := a_change_comments
			change_strings := a_change_strings
		end

feature

	process_class_type_as (l_as: CLASS_TYPE_AS) is
			-- Process `l_as'.
		do
			if old_class_name.is_case_insensitive_equal (l_as.class_name) then
				l_as.class_name.replace_text (new_class_name, match_list)
				has_modified := True
			end
			Precursor (l_as)
		end

	process_class_as (l_as: CLASS_AS) is
			-- Process `l_as'.
		do
			if old_class_name.is_case_insensitive_equal (l_as.class_name) then
				l_as.class_name.replace_text (new_class_name, match_list)
				has_modified := True
			end
			Precursor (l_as)
		end

	process_client_as (l_as: CLIENT_AS) is
			-- Process export clauses
		local
			l_list: EIFFEL_LIST [ID_AS]
			l_item: ID_AS
		do
			from
				l_list := l_as.clients
				l_list.start
			until
				l_list.after
			loop
				l_item := l_list.item
				if old_class_name.is_case_insensitive_equal (l_item) then
					l_item.replace_text (new_class_name, match_list)
					has_modified := True
				end
				l_list.forth
			end
		end

	process_break_as (l_as: BREAK_AS) is
			-- Process breaks which could be comments.
		do
			if change_comments then
				l_as.replace_subtext ("`"+old_class_name+"'", "`"+new_class_name+"'", False, match_list)
				has_modified := True
			end
			Precursor (l_as)
		end

	process_string_as (l_as: STRING_AS) is
		do
			if change_strings then
				l_as.replace_subtext ("`"+old_class_name+"'", "`"+new_class_name+"'", False, match_list)
				has_modified := True
			end
			Precursor (l_as)
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
			if change_strings then
				l_as.replace_subtext ("`"+old_class_name+"'", "`"+new_class_name+"'", False, match_list)
				has_modified := True
			end
			Precursor (l_as)
		end


feature {NONE} -- Implementation

	old_class_name: STRING
			-- Old class name

	new_class_name: STRING
			-- New class name

	change_comments: BOOLEAN
			-- Do we have to change the name in comments?

	change_strings: BOOLEAN
			-- Do we have to change the name in strings?

invariant
	old_class_name_ok: old_class_name /= Void and not old_class_name.is_empty
	new_class_name_ok: new_class_name /= Void and not new_class_name.is_empty
	old_class_name_upper: old_class_name.is_equal (old_class_name.as_upper)
	new_class_name_upper: new_class_name.is_equal (new_class_name.as_upper)

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
