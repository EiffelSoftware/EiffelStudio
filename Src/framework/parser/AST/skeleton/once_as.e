note
	description: "AST representation of a once routines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_AS

inherit
	INTERNAL_AS
		redefine
			is_once, as_once,
			is_equivalent
		end

create
	make

feature {NONE} -- Initialization

	make (o: like once_keyword; k: detachable KEY_LIST_AS; c: like compound)
			-- Create new DO AST node.
		do
			initialize (c)
			if o /= Void then
				once_keyword_index := o.index
			end
			internal_keys := k
		ensure
			once_keyword_set: o /= Void implies once_keyword_index = o.index
			keys_set: internal_keys = k
			compound_set: compound = c
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_once_as (Current)
		end

feature -- Roundtrip

	once_keyword_index: INTEGER
			-- Index of keyword "once" associated with this structure.

	once_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "once" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, once_keyword_index)
		end

	internal_keys: detachable KEY_LIST_AS
			-- Internal once keys, in which "(" and ")" are stored.

	index: INTEGER
			-- <Precursor>
		do
			Result := once_keyword_index
		end

feature -- Properties

	is_once: BOOLEAN = True
			-- Is the current routine body a once one?

	as_once: detachable ONCE_AS
			-- See `content' as an instance of ONCE_AS.
		do
			Result := Current
		end

	keys: detachable EIFFEL_LIST [STRING_AS]
			-- Once keys.
		do
			if attached internal_keys as k then
				Result := k.keys
			end
		ensure
			good_result: (internal_keys = Void implies Result = Void) and
						 (attached internal_keys as l_keys implies Result = l_keys.keys)
		end

feature -- Status report

	has_invalid_key (a_feature_as: FEATURE_AS): BOOLEAN
			-- Current once uses a non supported key?	
		local
			s: STRING
		do
			if attached keys as l_keys then
				from
					l_keys.start
				until
					l_keys.after or Result
				loop
					s := l_keys.item.value
					if
						s.is_case_insensitive_equal (once_key_process)
						or s.is_case_insensitive_equal (once_key_thread)
						or s.is_case_insensitive_equal (once_key_object)
					then
						l_keys.forth
					else
						Result := True --| Invalid key found
					end
				end
			end
		end

	invalid_key (a_feature_as: FEATURE_AS): detachable STRING_AS
			-- Current once uses a non supported key?	
		require
			has_invalid_key: has_invalid_key (a_feature_as)
		local
			s: STRING
		do
			if attached keys as l_keys then
				from
					l_keys.start
				until
					l_keys.after or Result /= Void
				loop
					s := l_keys.item.value
					if
						s.is_case_insensitive_equal (once_key_process)
						or s.is_case_insensitive_equal (once_key_thread)
						or s.is_case_insensitive_equal (once_key_object)
					then
						l_keys.forth
					else
						Result := l_keys.item --| Invalid key found
					end
				end
			end
		end

	has_key_conflict (a_feature_as: FEATURE_AS): BOOLEAN
			-- Current once presents a conflict in keys and indexing?
		local
			is_p,is_t,is_o: BOOLEAN
			l_keys: like keys
		do
			l_keys := keys
			is_p :=
				has_key_inside (once_key_process, l_keys) or
				attached a_feature_as.indexes as l_indexes and then l_indexes.has_global_once
			is_t := has_key_inside (once_key_thread, l_keys)
			is_o := has_key_inside (once_key_object, l_keys)

			Result := (is_p and is_t) or (is_p and is_o) or (is_o and is_t)
		end

	has_key_inside (a_key: READABLE_STRING_8; a_keys: like keys): BOOLEAN
			-- Has key inside `a_keys' or inside `keys'?
		require
			a_key_attached: a_key /= Void
		do
			if a_keys /= Void then
				from
					a_keys.start
				until
					a_keys.after or Result
				loop
					Result := a_keys.item.value.is_case_insensitive_equal (a_key)
					a_keys.forth
				end
			end
		end

	has_key (a_key: READABLE_STRING_8): BOOLEAN
		require
			a_key_attached: a_key /= Void
		do
			Result := has_key_inside (a_key, keys)
		end

	has_key_process (f: FEATURE_AS): BOOLEAN
			-- Does feature specified by `f` in a class with once status `o` have a once key "PROCESS"?
		do
			Result :=
				has_key (once_key_process) or
				attached f.indexes as i and then i.has_global_once
		end

	has_key_thread: BOOLEAN
			-- Does feature has a once key "THREAD"?
		do
			Result := has_key (once_key_thread)
		end

	has_key_object: BOOLEAN
			-- Does feature has a once key "OBJECT"?
		do
			Result := has_key (once_key_object)
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void then
				Result := once_keyword (a_list)
			elseif attached internal_keys as k then
				Result := k.first_token (Void)
			elseif attached compound as c then
				Result := c.first_token (Void)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached compound as c then
				Result := c.last_token (a_list)
			elseif attached internal_keys as k then
				Result := k.last_token (a_list)
			elseif a_list /= Void then
				Result := once_keyword (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
				--| We might be smarter, and be flexible on keys' case and order
				--| which does not really matters.
			Result := Precursor (other) and equivalent (internal_keys, other.internal_keys)
		end

feature {NONE} -- Constants

	once_key_process: STRING = "PROCESS"
	once_key_thread: STRING = "THREAD"
	once_key_object: STRING = "OBJECT"

;note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
