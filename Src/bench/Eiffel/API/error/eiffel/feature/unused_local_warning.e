indexing
	description: "Warning for unreferenced local variable within a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class UNUSED_LOCAL_WARNING

inherit
	EIFFEL_WARNING
		redefine
			build_explain
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like associated_class; a_feat: FEATURE_I) is
			-- New instance of unused local warnings in `a_feat' from `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_feat_not_voiid: a_feat /= Void
		do
			associated_class := a_class
			associated_feature := a_feat.api_feature (a_feat.written_in)
			create unused_locals.make
		ensure
			associated_class_set: associated_class = a_class
		end

feature -- Properties

	associated_feature: E_FEATURE
			-- Feature containing the unused local variable

	unused_locals: LINKED_LIST [TUPLE [STRING, TYPE_A]]
			-- List of unused local names and type.

	code: STRING is
			-- Error code
		do
			Result := "Unused_local_warning"
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		local
			l_name: STRING
			l_type: TYPE_A
		do
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
				l_name ?= unused_locals.item.item (1)
				l_type ?= unused_locals.item.item (2)
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
		end

feature {COMPILER_EXPORTER}

	add_unused_local (s: STRING; t: TYPE_A) is
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

end -- class UNUSED_LOCAL_WARNING
