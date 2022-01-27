note
	description: "Summary description for {CONFIG_READER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONFIG_READER

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature -- Status report

	has_item  (k: READABLE_STRING_GENERAL): BOOLEAN
			-- Has item associated with key `k'?
		deferred
		end

	has_error: BOOLEAN
			-- Has error?
			--| Syntax error, source not found, ...
		deferred
		end

feature -- Query

	resolved_text_item (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String item associated with key `k' and expanded to resolved variables ${varname}.
		do
			if attached text_item (k) as s then
				Result := resolved_expression (s)
			end
		end

	resolved_text_list_item (k: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
			-- List of String items associated with key `k',
			-- and expanded values to resolved variables ${varname}.
		do
			if attached text_list_item (k) as lst then
				from
					lst.start
				until
					lst.after
				loop
					lst.replace (resolved_expression (lst.item))
					lst.forth
				end
				Result := lst
			end
		end

	resolved_text_table_item (k: READABLE_STRING_GENERAL): detachable STRING_TABLE [READABLE_STRING_32]
			-- Table of String items associated with key `k',
			-- and expanded values to resolved variables ${varname}.
		do
			if attached text_table_item (k) as tb then
				from
					tb.start
				until
					tb.after
				loop
					tb.replace (resolved_expression (tb.item_for_iteration), tb.key_for_iteration)
					tb.forth
				end
				Result := tb
			end
		end

	utf_8_text_item (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
			-- String item associated with key `k'.	
		deferred
		end		

	text_item (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String item associated with key `k'.
		deferred
		end

	text_list_item (k: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
			-- List of String items associated with key `k'.
		deferred
		end

	text_table_item (k: READABLE_STRING_GENERAL): detachable STRING_TABLE [READABLE_STRING_32]
			-- Table of String items associated with key `k'.
		deferred
		end

	table_keys (k: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
			-- Keys of table associated with key `k'.
		deferred
		end
		
	integer_item (k: READABLE_STRING_GENERAL): INTEGER
			-- Integer item associated with key `k'.
		deferred
		ensure
			not has_item (k) implies Result = 0
		end

feature {NONE} -- Implementation

	resolved_items: detachable STRING_TABLE [READABLE_STRING_32]
			-- Resolved items indexed by expression.

	resolved_expression (exp: READABLE_STRING_GENERAL): STRING_32
			-- Resolved `exp' using `Current' or else environment variables.
		local
			i,n,b,e: INTEGER
			k: detachable READABLE_STRING_GENERAL
			c: CHARACTER_32
			l_resolved_items: like resolved_items
			l_text: detachable READABLE_STRING_GENERAL
		do
			from
				i := 1
				n := exp.count
				create Result.make (n)
			until
				i > n
			loop
				c := exp[i]
				if i + 1 < n and then c = '$' and then exp[i+1] = '{' then
					b := i + 2
					e := exp.index_of ('}', b) - 1
					if e > 0 then
						k := exp.substring (b, e)
						l_text := Void
						l_resolved_items := resolved_items
						if
							l_resolved_items /= Void and then
							attached l_resolved_items.item (k) as s
						then
								-- Already resolved, reuse value.
							l_text := s
						elseif attached text_item (k) as s then
								-- has such item
							l_text := s
						elseif attached execution_environment.item (k) as v then
								-- Or from environment
							l_text := v
						else
							l_text := exp.substring (i, e + 1)
						end
						i := e + 1
						Result.append_string_general (l_text)
					else
						Result.extend (c)
					end
				else
					Result.extend (c)
				end
				i := i + 1
			end
		end

feature -- Duplication

	sub_config (k: READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration representing a subset of Current for key `k'.
		deferred
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
