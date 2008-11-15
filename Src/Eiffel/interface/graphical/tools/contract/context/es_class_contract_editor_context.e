indexing
	description: "[
		A base contract editor ({ES_CONTRACT_EDITOR_WIDGET}) context for class-level contracts.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_CLASS_CONTRACT_EDITOR_CONTEXT

inherit
	ES_CONTRACT_EDITOR_CONTEXT [CLASSI_STONE]

feature {NONE} -- Query

	calculate_parents (a_class: !CLASS_I; a_list: !DS_LIST [CLASS_C])
			-- <Precursor>
		local
			l_class_i: CLASS_I
			l_class_c: CLASS_C
			l_list: LIST [CLASS_C]
			l_cursor: CURSOR
		do
			if a_class.is_compiled then
				l_list := a_class.compiled_class.parents_classes
				if l_list /= Void and then not l_list.is_empty then
					l_cursor := l_list.cursor
					from l_list.start until l_list.after loop
						l_class_c :=  l_list.item
						if not a_list.has (l_class_c) then
							a_list.force_last (l_class_c)
							l_class_i := l_class_c.lace_class
							check l_class_i_not_void: l_class_i /= Void end
							calculate_parents (l_class_i, a_list)
						end
						l_list.forth
					end
					l_list.go_to (l_cursor)
				end
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
