note

	description:
		"[
			Prefix map and context for xmlns declaration generation filter

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
		]"
	date: "$Date$"
	revision: "$Revision$"

class XML_XMLNS_GENERATOR_CONTEXT

inherit

	ANY

	XML_MARKUP_CONSTANTS
		export {NONE} all end

create
	make

feature {NONE} -- Creation

	make
			-- Reset.
		do
			create prefixes.make
			create element_prefixes.make (10)
			element_prefixes.compare_objects
			last_item := Void
			create default_namespaces.make
			default_namespaces.force ({XML_XMLNS_CONSTANTS}.Default_namespace)
		end

feature {NONE} -- Default context

	default_namespaces: LINKED_STACK [READABLE_STRING_32]
			-- Default namespace URI stack.

feature -- Default

	is_same_as_default (a_namespace: READABLE_STRING_32): BOOLEAN
			-- Is namespace the same as the default one for the current element?
		require
			a_namespace_not_void: a_namespace /= Void
		do
			Result := same_string (a_namespace, default_namespaces.item)
		end

	set_default (a_namespace: READABLE_STRING_32)
			-- Set default namespace URI.
		require
			a_namespace_not_void: a_namespace /= Void
		do
				-- Change top of stack.
			default_namespaces.replace (a_namespace)
		ensure
			set: same_string (a_namespace, default_namespaces.item)
		end

feature {NONE} -- Prefixed context

	prefixes: LINKED_LIST [HASH_TABLE [READABLE_STRING_32, STRING_32]]
			-- Prefixes by namespace

	element_prefixes: HASH_TABLE [READABLE_STRING_32, STRING_32] -- HASH_SET ?
			-- Prefixes in use (not only declared) in top element.

	last_item: detachable READABLE_STRING_32
			-- Cache for lookup

feature -- Status

	has (a_namespace: READABLE_STRING_32): BOOLEAN
			-- Is namespace known to prefixes table?
			-- If found, set `last_item' to the related item
		require
			a_namespace_not_void: a_namespace /= Void
			a_namespace_not_empty: not a_namespace.is_empty
		local
			a_cursor: LINKED_LIST_ITERATION_CURSOR [HASH_TABLE [READABLE_STRING_32,  STRING_32]]
			done: BOOLEAN
			ns: STRING_32
		do
			from
				ns := a_namespace.to_string_32
				a_cursor := prefixes.new_cursor
				a_cursor.reverse
				a_cursor.start
			until
				a_cursor.after or done
			loop
				if a_cursor.item.has (ns) then
					Result := True
					last_item := a_cursor.item.item (ns)
					done := True
				else
					Result := False
					a_cursor.forth
				end
			end
		end

	item (a_namespace: READABLE_STRING_32): detachable READABLE_STRING_32
			-- Find prefix for namespace
		require
			a_namespace_not_void: a_namespace /= Void
			a_namespace_not_empty: not a_namespace.is_empty
		do
			if has (a_namespace) then
				Result := last_item
			end
		ensure
			result_not_empty: Result /= Void implies not Result.is_empty
		end

	new_element_cursor: HASH_TABLE_ITERATION_CURSOR [READABLE_STRING_32, STRING_32]
			-- New element cursor.
		do
			check in_element: not prefixes.is_empty end
			Result := prefixes.last.new_cursor
		ensure
			result_not_void: Result /= Void
		end

feature -- Setting

	force (a_prefix: READABLE_STRING_32; a_namespace: READABLE_STRING_32)
			-- Add namespace, prefix to context.
		require
			a_namespace_not_void: a_namespace /= Void
			a_namespace_not_empty: not a_namespace.is_empty
			a_prefix_not_void: a_prefix /= Void
			a_prefix_not_empty: not a_prefix.is_empty
		do
			prefixes.last.force (a_prefix, a_namespace.to_string_32)
		ensure
			has: has (a_namespace)
			item: item (a_namespace) = a_prefix
		end

feature -- Status

	element_has_prefix (a_prefix: READABLE_STRING_32): BOOLEAN
			-- Is this prefix used in the top element?
		require
			a_prefix_not_void: a_prefix /= Void
			a_prefix_not_empty: not a_prefix.is_empty
		do
			Result := element_prefixes.has (a_prefix.to_string_32)
		end

	element_prefix (a_prefix: READABLE_STRING_32)
			-- Declare prefix in use in top element.
		require
			a_prefix_not_void: a_prefix /= Void
			a_prefix_not_empty: not a_prefix.is_empty
		do
			element_prefixes.force (a_prefix, a_prefix.to_string_32)
		ensure
			has: element_has_prefix (a_prefix)
		end

feature -- Elements

	on_start_element
			-- Push context.
		local
			a_table: HASH_TABLE [READABLE_STRING_32, STRING_32]
		do
			create a_table.make (10)
			a_table.compare_objects
			prefixes.extend (a_table)
			element_prefixes.wipe_out
			default_namespaces.force (default_namespaces.item)
		end

	on_end_element
			-- Pop context.
		do
			check prefixes.count > 0 end
			prefixes.finish
			prefixes.remove

			default_namespaces.remove
		end

feature {NONE} -- Implementation

	same_string (a,b: detachable READABLE_STRING_32): BOOLEAN
			-- Are `a' and `b' the same string?
		do
			if a = b then
				Result := True
			elseif a /= Void and b /= Void then
				Result := a.same_string (b)
			end
		end

invariant

	prefixes_not_void: prefixes /= Void
	element_prefixes_not_void: element_prefixes /= Void
	default_namespaces_not_void: default_namespaces /= Void

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
