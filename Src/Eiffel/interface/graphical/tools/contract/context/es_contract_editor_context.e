indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_CONTRACT_EDITOR_CONTEXT [G -> CLASSI_STONE]

inherit
	EB_RECYCLABLE

	ES_MODIFIABLE
		redefine
			internal_recycle
		end

	ES_STONABLE_I
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
			Precursor {ES_MODIFIABLE}
		ensure then
			internal_text_modifier_is_recycled: (old internal_text_modifier) /= Void implies (old internal_text_modifier).is_recycled
		end

feature -- Access

	stone: ?STONE assign set_stone
			-- <Precursor>

	context_stone: !G
			-- Context stone
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			Result ?= stone
		end

	context_class: !CLASS_I
			-- Context class for contract modifications
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			Result ?= context_stone.class_i
		end

	context_parents: !DS_LIST [CLASS_C]
			-- Context parent classes containing contracts
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		local
			l_list: !DS_LIST [CLASS_C]
			l_result: !DS_LINKED_LIST [CLASS_C]
		do
			if internal_context_parents = Void then
				create l_result.make_default
				l_list ?= l_result
				calculate_parents (context_class, l_list)
				internal_context_parents := l_result
				Result ?= l_result
			else
				Result ?= internal_context_parents
			end
		ensure
			result_contains_attached_item: not Result.has (Void)
			result_consistent: Result = context_parents
		end

	text_modifier: !like create_text_modifier
			-- Access to text modifier used to modify the contracts
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		local
			l_result: like internal_text_modifier
		do
			l_result := internal_text_modifier
			if l_result = Void then
				Result ?= create_text_modifier
				internal_text_modifier := Result
			else
				Result ?= l_result
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
			result_contracts_is_empty: (not a_live and not a_class.is_compiled) implies Result.contracts.is_empty
		end

feature -- Element change

	set_stone (a_stone: ?STONE)
			-- <Precursor>
		do
			if stone /= a_stone then
					-- Reset any cached data
				reset

				if internal_text_modifier /= Void then
					internal_text_modifier.recycle
				end
				internal_text_modifier := Void
				stone := a_stone
			end
		ensure then
			internal_text_modifier_detached: (old stone) /= a_stone implies internal_text_modifier = Void
			internal_text_modifier_is_recycled: (old internal_text_modifier /= Void) implies not (old internal_text_modifier).is_interface_usable
		end

feature -- Status report

	is_stone_usable (a_stone: ?STONE): BOOLEAN
			-- <Precursor>
		local
			l_stone: ?G
		do
			Result := a_stone = Void
			if not Result then
				l_stone ?= a_stone
				Result := l_stone /= Void
			end
		ensure then
			is_class_stone: Result implies (a_stone = Void or else (({G}) #? a_stone) /= Void)
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
		local
			l_save_prompt: ES_SAVE_CLASSES_PROMPT
			l_classes: DS_ARRAYED_LIST [CLASS_I]
			retried: BOOLEAN
		do
			if not retried then
				if not equal (stone, a_stone) then
					Result := not is_dirty
					if not Result then
							-- There should be sufficent editor context if the contents of the tool has been modified
						check has_stone: has_stone end

							-- Ask user about saving changes
						if has_stone then
							create l_classes.make (1)
							l_classes.put_last (context_class)
							create l_save_prompt.make_standard_with_cancel ("The contract tool has unsaved class changes.%NDo you wanted to save the following class(es)?")
							l_save_prompt.classes := l_classes
							l_save_prompt.show_on_active_window
							if l_save_prompt.dialog_result = {ES_DIALOG_BUTTONS}.yes_button then
								commit_changes
								Result := True
							elseif l_save_prompt.dialog_result = {ES_DIALOG_BUTTONS}.no_button then
								Result := True
							end
						else
							Result := True
						end
					end
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end

	commit_changes
			-- Commits the changes made.
		require
			is_interface_usable: is_interface_usable
			--is_dirty: is_dirty
		do
			text_modifier.commit
			set_is_dirty (False)
		ensure
			not_is_dirty: not is_dirty
		end

feature {NONE} -- Basic operation

	reset
			-- Resets any cached data
		require
			is_interface_usable: is_interface_usable
		do
			internal_text_modifier := Void
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

feature {NONE} -- Factory

	create_text_modifier: ?ES_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]
			-- Creates a text modifier
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		deferred
		ensure
			result_attached: Result /= Void
		end

	create_parent_text_modifier (a_parent: !CLASS_C): ?like create_text_modifier
			-- Creates a text modifier for a given parent class.
			--
			-- `a_parent': A parent class to generate a modifier for.
			-- `Result': A text modifier for the parent class.
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
			context_parents_has_a_parent: context_parents.has (a_parent)
		deferred
		ensure
			result_attached: Result /= Void
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
