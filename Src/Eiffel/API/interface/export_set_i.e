indexing
	description: "Representation of an export clause which lists to whom a feature%N%
		%will be exported."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXPORT_SET_I

inherit
	EXPORT_I
		undefine
			copy, is_equal
		redefine
			is_set
		end

	LINKED_SET [CLIENT_I]
		rename
			is_subset as ll_is_subset
		end

	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	SHARED_TEXT_ITEMS
		undefine
			copy, is_equal
		end

create
	make

feature -- Property

	is_set: BOOLEAN is
			-- Is the current object an instance of EXPORT_SET_I ?
		do
			Result := True
		end

feature -- Access

	same_as (other: EXPORT_I): BOOLEAN is
			-- is `other' the same as Current ?
		local
			other_set: EXPORT_SET_I
			one_client: CLIENT_I
			c1, c2: CURSOR
		do
			other_set ?= other
			if other_set /= Void and then count = other_set.count then
				c1 := cursor
				c2 := other_set.cursor
				from
					Result := True
					start
				until
					after or else not Result
				loop
					one_client := item
					other_set.start
					other_set.search (one_client)
					Result :=  not other_set.after and then one_client.same_as (other_set.item)
					forth
				end
				go_to (c1)
				other_set.go_to (c2)
			end
		end

feature -- Comparison

	infix "<" (other: EXPORT_I): BOOLEAN is
			-- is Current less restrictive than other
		local
			other_set: EXPORT_SET_I
		do
			if other.is_none then
				Result := True
			elseif other.is_all then
				Result := not is_all
			else
				other_set ?= other
				check
					must_be_a_set: other_set /= Void
				end
				Result := first.less_restrictive_than (other_set.first)
			end
		end

feature -- Output

	append_to (st: TEXT_FORMATTER) is
			-- Append a representation of `Current' to `st'.
		local
			ci: CLASS_I
			cts: LIST [STRING]
			cis: LIST [CLASS_I]
		do
			from
				start
			until
				after
			loop
				cts := item.clients
				if not (cts.count = 1 and then cts.first.is_equal ("ANY")) then
					st.add (S_l_curly)
					from
						cts.start
					until
						cts.after
					loop
						cis := Universe.classes_with_name (cts.item)
						ci := Void
						if cis /= Void and then not cis.is_empty then
							ci := cis.first
						end
						if ci /= Void then
							st.add_class (ci)
						else
							st.add (cts.item)
						end
						cts.forth
						if not cts.after then
							st.add (", ")
						end
					end
					st.add (S_r_curly)
				end
				forth
			end
		end

feature {COMPILER_EXPORTER}

	equiv (other: EXPORT_I): BOOLEAN is
			-- Is 'other' equivalent to Current ?
			-- [Semantic: old_status.equiv (new_status) ]
		local
			other_set: EXPORT_SET_I
			old_cursor: CURSOR
			export_client, other_export_client: CLIENT_I
		do
			other_set ?= other
			if other_set /= Void then
				old_cursor := cursor
				from
					Result := True
					start
				until
					after or else not Result
				loop
					export_client := item
					other_export_client := other_set.clause (export_client.written_in)
					Result := (other_export_client /= Void)
						and then export_client.equiv (other_export_client)
					forth
				end
				go_to (old_cursor)
			else
				Result := other.is_all
			end
		end

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export valid for client `client' when the supplier is
			-- `supplier' ?
		do
			from
				start
			until
				after or else Result
			loop
				Result := item.valid_for (client)
				forth
			end
		end

	concatenation (other: EXPORT_I): EXPORT_I is
			-- Concatenation of Current and `other'
		local
			other_set, new: EXPORT_SET_I
			old_cursor: CURSOR
		do
			if other.is_set then
					-- Duplication
				old_cursor := cursor
				start
				Result := duplicate (count)
					-- Merge
				other_set ?= other
				new ?= Result
				new.merge (other_set)
				go_to (old_cursor)
			elseif other.is_none then
				Result := Current
			else
				check
					other.is_all
				end
				Result := other
			end
		end

	is_subset (other: EXPORT_I): BOOLEAN is
			-- Is Current clients a subset or equal with
			-- `other' clients?
		local
			other_set: EXPORT_SET_I
			l_client: CLIENT_I
			l_clients: LIST [STRING]
			current_group: CONF_GROUP
			l_class: CLASS_I
			l_index: INTEGER
			l_cursor: like cursor
		do
			if other.is_none then
				Result := False
			elseif other.is_all then
				Result := True
			else
				other_set ?= other
				check
					must_be_a_set: other_set /= Void
				end
				Result := True
				from
					start
				until
					after or else not Result
				loop
					l_cursor := cursor
					from
						l_client := item
						l_clients := l_client.clients
						current_group := l_client.written_class.group
						l_clients.start
					until
						l_clients.after or else not Result
					loop
						l_class := Universe.class_named (l_clients.item, current_group)
						l_index := l_clients.index
						if l_class /= Void and then l_class.is_compiled then
							Result := other_set.valid_for (l_class.compiled_class)
						end
						l_clients.go_i_th (l_index)
						l_clients.forth
					end
					go_to (l_cursor)
					forth
				end
			end
		end

	clause (written_in: INTEGER): CLIENT_I is
			-- Clause of attribute `written_in'
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor
			from
				start
			until
				after or else Result /= Void
			loop
				if item.written_in = written_in then
					Result := item
				end
				forth
			end
			go_to (old_cursor)
		end

	trace is
			-- Debug purpose
		do
			from
				start
			until
				after
			loop
				item.trace
				io.error.put_new_line
				forth
			end
		end

	format (ctxt: TEXT_FORMATTER_DECORATOR) is
		do
			from
				start
			until
				after
			loop
				if not (item.clients.count = 1 and then item.clients.first.is_equal ("any")) then
					ctxt.process_symbol_text (Ti_l_curly)
					item.format (ctxt)
					ctxt.set_without_tabs
					ctxt.process_symbol_text (Ti_r_curly)
				end
				forth
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

end -- class EXPORT_SET_I
