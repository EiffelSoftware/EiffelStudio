indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_CONTRACT_EDITOR_CONTEXT [G -> CLASSC_STONE]

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
			Result ?= context_stone.e_class.lace_class
		end

	context_parents: !DS_ARRAYED_LIST [!CLASS_C]
			-- Context parent classes containing contracts
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		deferred
		ensure
--			result_items_has_contracts_in_class: Result.for_all (agent has_contracts_in_class)
		end

	text_modifier: !ES_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]
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
		end

feature -- Element change

	set_stone (a_stone: ?STONE)
			-- <Precursor>
		do
			if stone /= a_stone then
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

	has_contracts_in_class (a_class: !CLASS_C): BOOLEAN
			-- Indicates if the context has contracts to offer for a given class.
			--
			-- `a_class': Class (Current or parent of) to determine if contracts are available in.
			-- `Result': True if there are contracts to offer; False otherwise.
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		deferred
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
					Result := True
					Result := False --not is_dirty
					if not Result then
							-- There should be sufficent editor context if the contents of the tool has been modified
						--check has_stone: has_stone end

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

feature {NONE} -- Internal implementation cache

	internal_text_modifier: ?ES_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]
			-- Cached version `text_modifier'
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
