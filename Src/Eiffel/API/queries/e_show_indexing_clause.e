note

	description:
		"Command to display indexing clause of classes in the universe."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_INDEXING_CLAUSE

inherit

	E_OUTPUT_CMD;
	SHARED_SERVER
		export
			{NONE} all
		end

create

	make, do_nothing

feature -- Execution

	work
			-- Show indexing clauses of clases in universe.
		local
			groups: ARRAYED_LIST [CONF_GROUP];
			cursor: CURSOR;
		do
			groups := universe.groups
			if not groups.is_empty then
				from
					--| Print user defined clusters
					groups.start
				until
					groups.after
				loop
					cursor := groups.cursor
					display_a_cluster (groups.item)
					groups.go_to (cursor)
					groups.forth
				end
			end
		end

	display_a_cluster (a_group: CONF_GROUP)
		local
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING];
			classes: HASH_TABLE [CONF_CLASS, STRING];
			a_classi: CLASS_I;
			a_class: CLASS_C;
			l_precompile: CONF_PRECOMPILE
		do
			create sorted_class_names.make;
			classes := a_group.classes;
			from
				classes.start
			until
				classes.after
			loop
				sorted_class_names.put_front (classes.key_for_iteration);
				classes.forth
			end;
			sorted_class_names.sort;
			text_formatter.add ("Cluster: ");
			text_formatter.add_group (a_group, a_group.name);
			l_precompile ?= a_group
			if l_precompile /= Void then
				text_formatter.add (" (Precompiled)")
			end
			text_formatter.add_new_line;
			from
				sorted_class_names.start
			until
				sorted_class_names.after
			loop
				a_classi ?= classes.item (sorted_class_names.item)
				if a_classi /= Void then
					text_formatter.add_indent;
					a_class := a_classi.compiled_class;
					if a_class /= Void then
						a_class.append_signature (text_formatter, True);
						display_indexing (a_class, text_formatter)
					else
						a_classi.append_name (text_formatter);
						text_formatter.add ("  (not in system)")
					end;
					text_formatter.add_new_line;
				end
				sorted_class_names.forth
			end
		end;

	display_indexing (e_class: CLASS_C; a_text_formatter: TEXT_FORMATTER)
			-- Display the indexing clause of `classc' if any.
		local
			indexes: EIFFEL_LIST [INDEX_AS]
			index_list: EIFFEL_LIST [ATOMIC_AS]
			index_tag_32: STRING_32
			index: INDEX_AS
			ast: CLASS_AS
		do
			ast := e_class.ast
			if ast /= Void then
				indexes := ast.top_indexes
				if indexes /= Void then
					from
						indexes.start
					until
						indexes.after
					loop
						index := indexes.item
						index_tag_32 := index.tag.name_32
						if
							index_tag_32 /= Void and then
							attached index_tag_32.as_string_8 as index_tag and then
							(not index_tag.is_equal ("status") and
							not index_tag.is_equal ("date") and
							not index_tag.is_equal ("revision"))
						then
							a_text_formatter.add_new_line
							a_text_formatter.add_indent
							a_text_formatter.add_indent
							a_text_formatter.add (index_tag_32)
							a_text_formatter.add (": ")
							index_list := index.index_list
							from
								index_list.start
							until
								index_list.after
							loop
								a_text_formatter.add (index_list.item.string_value_32)
								if not index_list.islast then
									a_text_formatter.add (", ")
								end
								index_list.forth
							end
						end
						indexes.forth
					end
				end
				indexes := ast.bottom_indexes
				if indexes /= Void then
					from
						indexes.start
					until
						indexes.after
					loop
						index := indexes.item
						index_tag_32 := index.tag.name_32
						if
							index_tag_32 /= Void and then
							attached index_tag_32.as_string_8 as index_tag and then
							(not index_tag.is_equal ("status") and
							not index_tag.is_equal ("date") and
							not index_tag.is_equal ("revision"))
						then
							a_text_formatter.add_new_line
							a_text_formatter.add_indent
							a_text_formatter.add_indent
							a_text_formatter.add (index_tag_32)
							a_text_formatter.add (": ")
							index_list := index.index_list
							from
								index_list.start
							until
								index_list.after
							loop
								a_text_formatter.add (index_list.item.string_value_32)
								if not index_list.islast then
									a_text_formatter.add (", ")
								end
								index_list.forth
							end
						end
						indexes.forth
					end
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class E_SHOW_INDEXING_CLAUSE

