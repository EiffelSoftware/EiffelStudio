indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Time checker

class TIME_CHECKER

inherit

	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;
	COMPILER_EXPORTER

feature

	time_check is
			-- Check time stamps of compiled classes of the system
		require
			System.root_class.compiled_class /= Void
		do
			if System.any_class.compiled_class.parents /= Void then
				check_suppliers_of_unchanged_classes;
			end;
		end;

	check_suppliers_of_unchanged_classes is
			-- Check if there is no conflicts for the suppliers
			-- of the `old' classes but only if the system is moved
			-- i.e. if a class has been added or removed
		local
			new_classes: LINKED_LIST [CLASS_I]
			classes_with_name: LIST [CLASS_I]
			class_name: STRING
			class_c, client_class_c: CLASS_C
			class_i: CLASS_I
			checked_classes: SEARCH_TABLE [INTEGER]
			clients: ARRAYED_LIST [CLASS_C]
			class_id: INTEGER
			l_removed_classes: SEARCH_TABLE [CLASS_C]
		do
			new_classes := System.new_classes
			if not new_classes.is_empty then
debug ("ACTIVITY")
io.error.put_string ("TIME_CHECK check_suppliers_of_unchanged_classes%N")
end
				create checked_classes.make (1)
				l_removed_classes := system.removed_classes
				if l_removed_classes = Void then
					create l_removed_classes.make (0)
				end

				from
					new_classes.start
				until
					new_classes.after
				loop
					class_name := new_classes.item.name
debug ("ACTIVITY")
io.error.put_string ("%Tfind classes of name ")
io.error.put_string (class_name)
io.error.put_string ("%N")
end;

-- FIXME renaming with libraries

						-- look for classes with the same name that are already compiled
					classes_with_name := universe.compiled_classes_with_name (class_name)
					from
						classes_with_name.start
					until
						classes_with_name.after
					loop
						class_i := classes_with_name.item
						class_c := class_i.compiled_class
						class_id := class_c.class_id
						if not checked_classes.has (class_id) then
							clients := class_c.syntactical_clients
							from
								clients.start
							until
								clients.after
							loop
								client_class_c := clients.item
								if
									not client_class_c.changed
										-- Pass1 will be done entirely on the class
								and then
									not checked_classes.has (client_class_c.class_id)
								then
									checked_classes.force (client_class_c.class_id)
debug ("ACTIVITY")
io.error.put_string ("%T%Tcheck: ")
io.error.put_string (class_c.name)
io.error.put_string ("%N")
end;
									if not l_removed_classes.has (client_class_c) then
										client_class_c.eiffel_class_c.check_suppliers_and_parents
									end
								end
								clients.forth
							end
						end
						classes_with_name.forth
					end
					new_classes.forth
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
