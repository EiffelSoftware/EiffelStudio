indexing
	description: "[
		A base contract editor widget ({ES_CONTRACT_EDITOR_WIDGET}) class for specifying context objects, used to populate the widget.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_CONTRACT_EDITOR_CONTEXT [G -> CLASSI_STONE]

inherit
	EB_RECYCLABLE

	ES_STONABLE
		redefine
			query_set_stone
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if internal_text_modifier /= Void then
				internal_text_modifier.recycle
			end
		ensure then
			internal_text_modifier_is_recycled: (old internal_text_modifier) /= Void implies (old internal_text_modifier).is_recycled
		end

feature -- Access

	context_stone: G
			-- Context stone
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			if {l_result: G} stone then
				Result := l_result
			else
				check not_possible: False end
			end
		ensure
			context_stone_not_void: {l_g: G} Result
		end

	context_class: !CLASS_I
			-- Context class for contract modifications
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			Result := context_stone.class_i.as_attached
		end

	context_parents: !DS_LINKED_LIST [CLASS_C]
			-- Context parent classes containing contracts
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			if {l_result: like context_parents} internal_context_parents then
				Result := l_result
			else
				create Result.make_default
				calculate_parents (context_class, Result)
				internal_context_parents := Result
			end
		ensure
			result_contains_attached_item: not Result.has (Void)
			result_consistent: Result = context_parents
		end

	text_modifier: like create_text_modifier
			-- Access to text modifier used to modify the contracts
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			if {l_result: like text_modifier} internal_text_modifier then
				Result := l_result
			else
				Result := create_text_modifier
				internal_text_modifier := Result
			end
		ensure
			result_is_interface_usable: Result.is_interface_usable
			result_consistent: Result = text_modifier
		end

feature -- Contracts

	contracts_for_class (a_class: !CLASS_I; a_live: BOOLEAN): !TUPLE [contracts: !DS_LIST [TAGGED_AS]; modifier: !ES_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]]
			-- Retrieves the contacts for a given class with an associated text modifier.
			--
			-- `a_class': The class interface to retrieve the contracts for.
			-- `a_live': True to retrieve the live (possibly uncompiled) contracts for a class; False to use the compiled data.
			-- `Result': A text modifier used to modify the class and a list of contracts discovered in the specified class.
			--           Note: The modifier will only be prepared when using the live contracts.
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		deferred
		ensure
			result_contracts_contains_attached_items: not Result.contracts.has (Void)
			result_modifier_is_prepared: a_live implies Result.modifier.is_prepared
			result_modifier_is_interface_usable: Result.modifier.is_interface_usable
			result_contracts_is_empty: ((not a_live and not a_class.is_compiled) or (a_live and not Result.modifier.is_ast_available)) implies Result.contracts.is_empty
		end

feature -- Status report

	is_editable: BOOLEAN
			-- Indicates if the context allows for modifications
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			Result := not context_class.is_read_only
		ensure
			context_class_is_writable: Result implies not context_class.is_read_only
		end

feature {NONE} -- Status report

	internal_is_stone_usable (a_stone: !like stone): BOOLEAN
			-- <Precursor>
		do
			Result := {l_g: G} a_stone
		ensure then
			is_class_stone: Result implies ({?G}) #? a_stone /= Void
		end

feature -- Query

	contract_keywords (a_origin: BOOLEAN): !ARRAYED_LIST [EDITOR_TOKEN]
			-- Retrieve contract keyword list of tokens.
			--
			-- `a_origin': True when requiring the feature origin.
			-- `Result': List of tokens used in represent the assertions.
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

	template_category: !STRING
			-- Code template category name
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Query

	calculate_parents (a_class: !CLASS_I; a_list: !DS_LIST [CLASS_C])
			-- Context parent classes containing contracts
			--
			-- `a_class': The class to retrieve applicable parent for.
			-- `a_list': The list to populate the discovered parent classes into.
		require
			is_interface_usable: is_interface_usable
			a_list_contains_attached_items: not a_list.has (Void)
		deferred
		ensure
			a_list_contains_attached_items: not a_list.has (Void)
		end

feature -- Basic operations

	query_set_stone (a_stone: ?STONE): BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {NONE} -- Basic operation

	reset
			-- Resets any cached data associated with a particular stone.
		require
			is_interface_usable: is_interface_usable
		do
			if internal_text_modifier /= Void then
				internal_text_modifier.recycle
				internal_text_modifier := Void
			end
			internal_context_parents := Void
		ensure
			internal_text_modifier_detached: internal_text_modifier = Void
			internal_context_parents_detached: internal_context_parents = Void

		end

feature -- Synchronization

	synchronize
			-- Synchronizes any new data (compiled or other wise)
		do
			--| Does nothing!
		end

feature {NONE} -- Action handlers

	on_stone_changed (a_old_stone: ?STONE)
			-- <Precursor>
		do
				-- Reset any cached data
			reset
		ensure then
			internal_text_modifier_detached: internal_text_modifier = Void
			internal_text_modifier_is_recycled: (old internal_text_modifier /= Void) implies not (old internal_text_modifier).is_interface_usable
		end

feature {NONE} -- Factory

	create_text_modifier: !ES_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]
			-- Creates a text modifier
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		deferred
		end

	create_parent_text_modifier (a_parent: CLASS_C): like create_text_modifier
			-- Creates a text modifier for a given parent class.
			--
			-- `a_parent': A parent class to generate a modifier for.
			-- `Result': A text modifier for the parent class.
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
			a_parent_not_void: a_parent /= Void
			context_parents_has_a_parent: context_parents.has (a_parent)
		deferred
		end

feature {NONE} -- Internal implementation cache

	internal_text_modifier: ?like text_modifier
			-- Cached version `text_modifier'
			-- Note: Do not use directly!

	internal_context_parents: ?like context_parents
			-- Cached version `context_parentes'
			-- Note: Do not use directly!

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
