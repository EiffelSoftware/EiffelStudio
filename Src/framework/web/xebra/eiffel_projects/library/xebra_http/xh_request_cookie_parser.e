note
	description: "[
		Can be used to parse the headers_in value for "Cookie" to get a table of cookies.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_REQUEST_COOKIE_PARSER

inherit
	PEG_FACTORY

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Basic Operations

	cookie_table (a_args: STRING): detachable HASH_TABLE [XH_COOKIE, STRING]
			-- Returns a table of cookies if the string could be parsed successfully
		require
			not_a_args_is_detached: a_args /= Void
		local
			l_result: PEG_PARSER_RESULT
		do
			l_result := parser.parse (create {PEG_PARSER_STRING}.make_from_string (a_args))
			if l_result.error_messages.count > 0 or l_result.left_to_parse.count > 0 then
				from
					l_result.error_messages.start
				until
					l_result.error_messages.after
				loop
					print (l_result.error_messages.item)
					l_result.error_messages.forth
				end
			else
				if attached {like cookie_table} l_result.parse_result.first as l_rec then
					Result := l_rec
				end
			end
		end


feature {NONE} -- Parser

	parser: PEG_ABSTRACT_PEG
			-- Creates the parser
			-- name=value; name=value; name=value
		local
			key_eq,
			key_value,
			key_sq,
			item_value,
			item_name,
			table_item,
			table: PEG_ABSTRACT_PEG
			l_parser_result: PEG_PARSER_RESULT
		once
				-- Constants
			key_eq := stringp ({XU_CONSTANTS}.cookie_eq)
			key_sq := stringp ({XU_CONSTANTS}.cookie_sqp)

				-- User fields
			item_name := (-(key_eq.negate + any)).consumer
			item_name.fixate
			item_value := (-((key_sq.negate) + any)).consumer
			item_value.fixate

				-- Structure
			table_item := item_name + key_eq + item_value
			table_item.set_behaviour (agent build_table_item)
			table_item.fixate

			table := ((-(table_item + key_sq)) + table_item).optional
			table.set_behaviour (agent build_table)

			Result := table
		ensure
			result_attached: Result /= Void
		end


	build_table_item (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a name value tuple
			-- TABLE_ENTRY =  item_name  item_value ;
		require
			a_result_attached: attached a_result
		local
			l_escaper: XU_ESCAPER
		do
			create l_escaper
			Result := a_result
			if attached {STRING} a_result.parse_result [1] as l_name and
				attached {STRING} a_result.parse_result [2] as l_value then
					Result.replace_result (create {XH_COOKIE}.make ( l_escaper.unescape_cookie_text (l_name), l_escaper.unescape_cookie_text (l_value)))
			end
		ensure
			Result_attached: attached Result
		end

	build_table (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a hash table
			-- TABLE = {TABLE_ENTRIES}
		require
			a_result_attached: attached a_result
		local
			l_table_args: like cookie_table
			-- l_cookie_monster: like cookie
		do
			Result := a_result
			create l_table_args.make (a_result.parse_result.count)
			from
				a_result.parse_result.start
			until
				a_result.parse_result.after
			loop
				if attached {XH_COOKIE} a_result.parse_result.item as l_arg then
					l_table_args.put (l_arg, l_arg.name)
				end
				a_result.parse_result.forth
			end
			Result.replace_result (l_table_args)
		ensure
			Result_attached: attached Result
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
