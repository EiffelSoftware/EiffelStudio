note
	description: "[
		A utility class to facilitate synchornization of multiple stonable objects ({ES_STONABLE_I}),
		so when a stone changes on one all are synchronized to use the same stone.
		
		Note: Object is recyclable, please recycle!
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_STONE_SYNCHRONIZER

inherit
	ES_RECYCLABLE

create
	make

feature {NONE} -- Initialization

	make (a_primary: like primary_object)
			-- Initialize a synchorinizer with a primary object, which will be used to perform validation/
			-- applicability checks when setting a stone.
			--
			-- `a_primary': A stonable object used to perform stone setting checks.
		do
			primary_object := a_primary
			create managed_objects.make (0)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			managed_objects.wipe_out
		ensure then
			managed_objects_is_empty: managed_objects.is_empty
		end

feature -- Access

	primary_object: ES_STONABLE_I
			-- The primary stonable object, used to perform stonable queries on.

feature {NONE} -- Access

	managed_objects: ARRAYED_LIST [ES_STONABLE_I]
			-- List of currently managed stonable objects.

feature -- Status report

	is_synchronized_object (a_stonable: ES_STONABLE_I): BOOLEAN
			-- Determines if a stonable object is already being synchronized with the current synchronizer
		do
			Result := is_interface_usable and then managed_objects.has (a_stonable)
		ensure
			is_interface_usable: Result implies is_interface_usable
			managed_objects_has_a_stonable: Result implies managed_objects.has (a_stonable)
		end

feature -- Status report

	is_raising_events: BOOLEAN
			-- Indicates if the primary object stone change actions have been subscribed to.

	is_synchronizing: BOOLEAN
			-- Indicates if stone synchronization is in progress.

feature -- Extension

	extend (a_stonable: ES_STONABLE_I)
			-- Adds a stonable object to the list of managed stonable objects. Once added the stonable
			-- object will react to any stone changes by the primary or any other manager objects. It
			-- will also notify any other managed object when it changes.
			--
			-- `a_stonable': The stonable object to stop synchronization for.
		require
			is_interface_usable: is_interface_usable
			a_stonable_attached: a_stonable /= Void
			not_is_primary_object: a_stonable /= primary_object
			a_stonable_is_interface_usable: a_stonable.is_interface_usable
			not_a_stonable_is_synchronized_object: not is_synchronized_object (a_stonable)
		do
				-- Extends the stonable object from the managed objects.
			managed_objects.extend (a_stonable)

			if not is_raising_events then
					-- Register the primary object for first time use.
				register_action (primary_object.stone_changed_actions, agent on_stone_changed)
				is_raising_events := True
			end
				-- Register the change actions on the extended stonable object.
			register_action (a_stonable.stone_changed_actions, agent on_stone_changed)
		ensure
			is_raising_events: is_raising_events
			a_stonable_is_synchronized_object: is_synchronized_object (a_stonable)
		end

feature -- Removal

	prune (a_stonable: ES_STONABLE_I)
			-- Removes a stonable object from the list of managed stonable objects. Once removed the stonable
			-- object will not react to any stone changes by the primary or any other manager objects.
			--
			-- `a_stonable': The stonable object to stop synchronization for.
		require
			is_interface_usable: is_interface_usable
			a_stonable_attached: a_stonable /= Void
			not_is_primary_object: a_stonable /= primary_object
			is_raising_events: is_raising_events
			a_stonable_is_synchronized_object: is_synchronized_object (a_stonable)
		do
				-- Removed the stonable object from the managed objects.
			managed_objects.prune (a_stonable)

			if a_stonable.is_interface_usable then
					-- Unregister the change actions on the extended stonable object.
				unregister_action (a_stonable.stone_changed_actions, agent on_stone_changed)
			end
		end

feature {NONE} -- Action handlers

	on_stone_changed (a_sender: ES_STONABLE_I; a_old_stone: detachable STONE)
			-- Called when a stone has changed in one of the contexts.
			--
			-- `a_sender': The stonable object sending the change action.
			-- `a_old_stone': The old stone, prior to the change.
		require
			is_interface_usable: is_interface_usable
			a_sender_attached: a_sender /= Void
			a_sender_is_interface_usable: a_sender.is_interface_usable
		local
			l_primary: like primary_object
			l_objects: like managed_objects
			l_stone: detachable STONE
			l_can_set: BOOLEAN
		do
			if not is_synchronizing then
					-- We are not already synchronizing.
				l_stone := a_sender.stone
				l_primary := primary_object

					-- Synchronization can re-occur when a stonable object has been registered with another
					-- synchronizer object.
				if a_sender /= primary_object then
						-- The notification does not come from the primary object so we have to check if the stone
						-- can be set.
					check managed_objects_has_a_sender: managed_objects.has (a_sender) end
						-- If the stone was set with a query, we need to be sure it's applicable for the primary stone.
					if l_primary.stone /= l_stone then
						l_can_set := l_primary.is_stone_usable (l_stone)
						if l_can_set then
							l_can_set := not a_sender.is_setting_stone_with_query or else l_primary.query_set_stone (a_sender.stone)
						end

						if l_can_set then
								-- Se the new stone
							l_primary.set_stone (l_stone)
						else
								-- The stone cannot be set, revert.
							if a_sender.is_stone_usable (a_old_stone) then
								a_sender.set_stone (a_old_stone)
							else
								check False end
							end
						end
					end
				else
					l_can_set := True
				end

				if l_can_set then
					l_objects := managed_objects
					if not l_objects.is_empty then
						l_objects := l_objects.twin
						from l_objects.start until l_objects.after or a_old_stone = l_stone loop
							if attached l_objects.item as l_stonable and then l_stonable.is_interface_usable then
								if l_stonable.stone /= l_stone and then l_stonable.is_stone_usable (l_stone) then
										-- Set the new stone. There is no need to use any query routine because this is performed
										-- on the primary object.
									l_stonable.set_stone (l_stone)
								end
							end
								-- Re-fetch the stone incase the stone was revert due to another synchronizer. In this case
								-- we should exit the loop.
							l_stone := a_sender.stone

							l_objects.forth
						end
					end
				end
				is_synchronizing := False
			end
		end

invariant
	primary_object_attached: primary_object /= Void
	managed_objects_attached: managed_objects /= Void

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
