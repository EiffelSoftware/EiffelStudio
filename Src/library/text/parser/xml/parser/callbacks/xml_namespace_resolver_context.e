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

	add_default (a_namespace: READABLE_STRING_32)
			-- Add default namespace to context.
		require
			a_namespace_not_void: a_namespace /= Void
			context_not_empty: not is_context_empty
		do
			add (a_namespace, Default_pseudo_prefix)
		end

	add (a_namespace: READABLE_STRING_32; a_prefix: READABLE_STRING_32)
			-- Add namespace to context.
		require
			a_namespace_not_void: a_namespace /= Void
			a_prefix_not_void: a_prefix /= Void
			not_has: not shallow_has (a_prefix)
			context_not_empty: not is_context_empty
		do
			context.first.force (a_namespace, to_context_key (a_prefix))
		end

feature -- Status report

	is_context_empty: BOOLEAN
			-- Is context stack empty?
		do
			Result := context.is_empty
		ensure
			definition: Result = context.is_empty
		end

	shallow_has (a_prefix: READABLE_STRING_32): BOOLEAN
			-- Is this prefix known at the current level?
			-- (for duplicate declaration checks)
		require
			a_prefix_not_void: a_prefix /= Void
		do
			Result := context.count > 0 and then context.first.has (to_context_key (a_prefix))
		end

	has (a_prefix: READABLE_STRING_32): BOOLEAN
			-- Is this prefix known?
		require
			a_prefix_not_void: a_prefix /= Void
		local
			p: like to_context_key
		do
			p := to_context_key (a_prefix)
			Result := ∃ c: context ¦ c.has (p)
		end

feature -- Access

	resolve_default: READABLE_STRING_32
			-- Resolve default namespace.
		do
			Result := resolve (Default_pseudo_prefix)
		ensure
			resoled_not_void: Result /= Void
		end

	resolve (a_prefix: READABLE_STRING_32): READABLE_STRING_32
			-- Resolve a prefix.
		require
			a_prefix_not_void: a_prefix /= Void
		local
			i: like context.item
			result_found: BOOLEAN
			p: like to_context_key
		do
			Result := Default_namespace
			p := to_context_key (a_prefix)
			across
				context as c
			until
				result_found
			loop
				i := c
				if
					i.has (p) and then
					attached i.item (p) as v
				then
					Result := v
					result_found := True
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

	to_context_key (s: READABLE_STRING_32): like context.item.key_for_iteration
			-- Return the adapted key associated with `s'.
		do
			Result := s.to_string_32
		end

	context: LINKED_LIST [like new_string_string_table]
			-- Really a STACK but we need to see the content

	new_string_string_table: HASH_TABLE [READABLE_STRING_32, STRING_32]
		do
			create Result.make (5)
		end

feature {NONE} -- Constants

	Default_pseudo_prefix: STRING_32 = ""
			-- Default pseudo prefix

	Default_namespace: STRING_32 = ""
			-- Default namespace (empty)

invariant

	context_not_void: context /= Void

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
