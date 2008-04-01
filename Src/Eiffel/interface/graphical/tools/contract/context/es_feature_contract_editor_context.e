indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_FEATURE_CONTRACT_EDITOR_CONTEXT

inherit
	ES_CONTRACT_EDITOR_CONTEXT [FEATURE_STONE]
		redefine
			is_stone_usable,
			query_set_stone
		end

feature -- Access

	context_feature: !E_ROUTINE
			-- Context class for contract modifications
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			Result ?= context_stone.e_feature
		end

	context_parents: !DS_ARRAYED_LIST [!CLASS_C]
			-- Context parent classes containing contracts
		local
			l_list: LIST [CLASS_C]
			l_cursor: CURSOR
		do
			create Result.make_default
			l_list := context_feature.precursors
			if l_list /= Void then
				l_cursor := l_list.cursor
				from l_list.start until l_list.after loop
					if {l_class: !CLASS_C} l_list.item then
						Result.force_last (l_class)
					end
					l_list.forth
				end
				l_list.go_to (l_cursor)
			end
		end

feature -- Status report

	is_stone_usable (a_stone: ?STONE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ES_CONTRACT_EDITOR_CONTEXT} (a_stone)
			if a_stone /= Void and then Result then
				if {l_stone: FEATURE_STONE} a_stone then
					Result := {l_routine: E_ROUTINE} l_stone.e_feature
				else
					Result := False
				end
			end
		ensure then
			is_class_stone: (Result and a_stone /= Void) implies ({E_ROUTINE}) #? (({FEATURE_STONE}) #? a_stone).e_feature /= Void
		end

feature -- Basic operations

	query_set_stone (a_stone: ?STONE): BOOLEAN
			-- <Precursor>
		local
			l_save_prompt: ES_SAVE_FEATURES_PROMPT
			l_features: DS_ARRAYED_LIST [E_FEATURE]
			retried: BOOLEAN
		do
			if not retried then
				if not equal (stone, a_stone) then
					Result := not is_dirty
					if not Result then
							-- There should be sufficent editor context if the contents of the tool has been modified
						check has_stone: has_stone end

						-- Ask user about saving changes
						create l_features.make (1)
						l_features.put_last (context_feature)
						create l_save_prompt.make_standard_with_cancel ("The contract tool has unsaved feature(s) modifications.%NDo you wanted to save the following features?")
						l_save_prompt.features := l_features
						l_save_prompt.show_on_active_window
						if l_save_prompt.dialog_result = {ES_DIALOG_BUTTONS}.yes_button then
							commit_changes
							Result := True
						elseif l_save_prompt.dialog_result = {ES_DIALOG_BUTTONS}.no_button then
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
