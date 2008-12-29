note
	description: "Warning for unreferenced local variable within a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class UNUSED_LOCAL_WARNING

inherit
	EIFFEL_WARNING
		redefine
			help_file_name, build_explain, trace_primary_context,
			print_single_line_error_message
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like associated_class; a_feat: FEATURE_I)
			-- New instance of unused local warnings in `a_feat' from `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_feat_not_voiid: a_feat /= Void
		do
			associated_class := a_class
			associated_feature := a_feat.enclosing_feature.api_feature (a_feat.written_in)
			create unused_locals.make
		ensure
			associated_class_set: associated_class = a_class
		end

feature -- Properties

	associated_feature: E_FEATURE
			-- Feature containing the unused local variable

	unused_locals: LINKED_LIST [TUPLE [name: STRING; type: TYPE_A]]
			-- List of unused local names and type.

	code: STRING = "Unused_local_warning"
			-- Error code

	help_file_name: STRING = "Unused_local_warning"
			-- Help file name

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		local
			l_name: STRING
			l_type: TYPE_A
			l_group: CONF_GROUP
		do
			l_group := a_text_formatter.context_group
			a_text_formatter.set_context_group (associated_class.group)
			a_text_formatter.add ("Class: ")
			associated_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Feature: ")
			associated_feature.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			if unused_locals.count = 1 then
				a_text_formatter.add ("Unused local is: ")
			else
				a_text_formatter.add ("Unused locals are: ")
			end
			a_text_formatter.add_new_line

			from
				unused_locals.start
			until
				unused_locals.after
			loop
				l_name := unused_locals.item.name
				l_type := unused_locals.item.type
				check
					l_name_not_void: l_name /= Void
					l_type_not_void: l_type /= Void
				end
				a_text_formatter.add_indent
				a_text_formatter.add (l_name)
				a_text_formatter.add (": ")
				l_type.append_to (a_text_formatter)
				a_text_formatter.add_new_line
				unused_locals.forth
			end
			a_text_formatter.set_context_group (l_group)
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER)
			-- Build the primary context string so errors can be navigated to
		do
			if {l_class: !like associated_class} associated_class and then {l_feature: !like associated_feature} associated_feature and then {l_formatter: !TEXT_FORMATTER} a_text_formatter then
				print_context_feature (l_formatter, l_feature, l_class)
			else
				Precursor (a_text_formatter)
			end
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER)
			-- Displays single line help in `a_text_formatter'.
		local
			l_locals: like unused_locals
			l_cursor: CURSOR
			l_text: STRING_32
		do
			Precursor (a_text_formatter)
			create l_text.make (100)
			l_text.append_character (' ')

			l_locals := unused_locals
			l_cursor := l_locals.cursor
			from l_locals.start until l_locals.after loop
				l_text.append_character ('`')
				l_text.append (l_locals.item.name)
				l_text.append_character ('%'')
				if not l_locals.islast then
					l_text.append (", ")
				end
				l_locals.forth
			end
			l_locals.go_to (l_cursor)

			a_text_formatter.add (l_text)
		end

feature {COMPILER_EXPORTER}

	add_unused_local (s: STRING; t: TYPE_A)
			-- Extend `unused_locals' with unused local `s' of type `t'.
		require
			s_not_void: s /= Void
			t_not_void: t /= Void
		do
			unused_locals.extend ([s, t])
		ensure
			unused_locals_updated: unused_locals.count = (old unused_locals.count) + 1
		end

invariant
	associated_class_not_void: associated_class /= Void
	associated_feature_not_void: associated_feature /= Void
	unused_locals_not_void: unused_locals /= Void

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

end -- class UNUSED_LOCAL_WARNING
