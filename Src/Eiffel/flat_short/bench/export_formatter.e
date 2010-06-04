note
	description: "[
		Format an EXPORT_I object using a TEXT_FORMATTER_DECORATOR. We are not using the visitor pattern
		but as soon as we need to process EXPORT_I objects in a similar fashion we should.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EXPORT_FORMATTER

inherit
	ANY

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

feature -- Formatting

	format (a_ctxt: TEXT_FORMATTER_DECORATOR; a_export: EXPORT_I)
			-- Format `a_export' using `a_ctxt'.
		require
			a_ctxt_not_void: a_ctxt /= Void
			a_export_not_void: a_export /= Void
		local
			l_export: EXPORT_SET_I
			l_client: CLIENT_I
		do
			if a_export.is_all then
					-- Nothing to be done
			elseif a_export.is_none then
					-- Print NONE
				a_ctxt.process_symbol_text (ti_l_curly)
				a_ctxt.add ("NONE");
				a_ctxt.set_without_tabs
				a_ctxt.process_symbol_text (ti_r_curly)
			elseif a_export.is_set then
				l_export ?= a_export
				check l_export_not_void: l_export /= Void end
				from
					l_export.start
				until
					l_export.after
				loop
					l_client := l_export.item
					if
						not (l_client.clients.count = 1 and then
						l_client.clients.first = {PREDEFINED_NAMES}.any_name_id)
					then
						a_ctxt.process_symbol_text (Ti_l_curly)
						format_client_i (a_ctxt, l_client)
						a_ctxt.set_without_tabs
						a_ctxt.process_symbol_text (Ti_r_curly)
					end
					l_export.forth
				end
			end
		end

feature {NONE} -- Implementation

	format_client_i (a_ctxt: TEXT_FORMATTER_DECORATOR; a_client: CLIENT_I)
		require
			a_ctxt_not_void: a_ctxt /= Void
			a_client_not_void: a_client /= Void
		local
			temp: STRING
			group: CONF_GROUP
			client_classi: CLASS_I
			l_names_heap: like names_heap
			i, nb: INTEGER
		do
			l_names_heap := names_heap
			group := System.class_of_id (a_client.written_in).group
			from
				i := 1
				nb := a_client.clients.count
			until
				i > nb
			loop
					-- Class name does not contain non ASCII char.
					-- Safe to use `as_string_8'
				temp := l_names_heap.item_32 (a_client.clients.item (i)).as_string_8
				client_classi := Universe.class_named (temp, group)
				if client_classi /= Void then
					a_ctxt.put_classi (client_classi)
				else
					a_ctxt.process_string_text (temp.as_upper, Void)
				end
				i := i + 1
				if i <= nb then
					a_ctxt.process_symbol_text (Ti_comma)
					a_ctxt.put_space
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
