note

	description: "[
			XML Context for namespace resolver

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
			]"
	date: "$Date$"
	revision: "$Revision$"

class XML_NAMESPACE_RESOLVER_CONTEXT

create
	make

feature {NONE} -- Initialization

	make
			-- Create a new context.
		do
			create context.make
		end

feature -- Recyling

	reset
			-- Reset current context
		do
			context.wipe_out
		end

feature -- Element change

	add_default (a_namespace: STRING)
			-- Add default namespace to context.
		require
			a_namespace_not_void: a_namespace /= Void
			context_not_empty: not is_context_empty
		do
			add (a_namespace, Default_pseudo_prefix)
		end

	add (a_namespace: STRING; a_prefix: STRING)
			-- Add namespace to context.
		require
			a_namespace_not_void: a_namespace /= Void
			a_prefix_not_void: a_prefix /= Void
			not_has: not shallow_has (a_prefix)
			context_not_empty: not is_context_empty
		do
			context.first.force (a_namespace, a_prefix)
		end

feature -- Status report

	is_context_empty: BOOLEAN
			-- Is context stack empty?
		do
			Result := context.is_empty
		ensure
			definition: Result = context.is_empty
		end

	shallow_has (a_prefix: STRING): BOOLEAN
			-- Is this prefix known at the current level?
			-- (for duplicate declaration checks)
		require
			a_prefix_not_void: a_prefix /= Void
		do
			Result := context.count > 0 and then context.first.has (a_prefix)
		end

	has (a_prefix: STRING): BOOLEAN
			-- Is this prefix known?
		require
			a_prefix_not_void: a_prefix /= Void
		local
			c: LINKED_LIST_ITERATION_CURSOR [HASH_TABLE [STRING, STRING]]
		do
			c := context.new_cursor
			from
				c.start
			until
				c.after or Result
			loop
				if c.item.has (a_prefix) then
					Result := True
				else
					c.forth
				end
			end
		end

feature -- Access

	resolve_default: STRING
			-- Resolve default namespace.
		do
			Result := resolve (Default_pseudo_prefix)
		ensure
			resoled_not_void: Result /= Void
		end

	resolve (a_prefix: STRING): STRING
			-- Resolve a prefix.
		require
			a_prefix_not_void: a_prefix /= Void
		local
			c: LINKED_LIST_ITERATION_CURSOR [HASH_TABLE [STRING, STRING]]
			i: HASH_TABLE [STRING, STRING]
			result_found: BOOLEAN
		do
			Result := Default_namespace

			c := context.new_cursor
			from
				c.start
			until
				c.after or result_found
			loop
				i := c.item
				if
					i.has (a_prefix) and then attached i.item (a_prefix) as v
				then
					Result := v
					result_found := True
				else
					c.forth
				end
			end
		ensure
			resolved_not_void: Result /= Void
		end

feature -- Stack

	push
			-- Push element context.
		do
			context.put_front (new_string_string_table)
		end

	pop
			-- Pop element context.
		do
			if context.count > 0 then
				context.start
				context.remove
			end
		end

feature {NONE} -- Implementation

	context: LINKED_LIST [HASH_TABLE [STRING, STRING]]
			-- Really a STACK but we need to see the content

	new_string_string_table: HASH_TABLE [STRING, STRING]
		do
			create Result.make (5)
		end

feature {NONE} -- Constants

	Default_pseudo_prefix: STRING = ""
			-- Default pseudo prefix

	Default_namespace: STRING = ""
			-- Default namespace (empty)

invariant

	context_not_void: context /= Void

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
