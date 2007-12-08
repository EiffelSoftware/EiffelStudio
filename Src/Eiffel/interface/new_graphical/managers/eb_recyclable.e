indexing
	description	: "[
		Object recycler for explicit recycling of active objects enabling
		disconnection between objects/agents that the GC is unable to recognize.
		
		Note: Class provides automatic recycling of referring objects by explict use of `auto_recycle' and `delay_auto_recycle'
		      Registration to action sequences can be performed though `register_action' and will be automatically removed
		      upon recycling.
		      
		      After recycling and all referring recycable objects have been recycled all attributes are automatically detached.
		      
		Special Note: EiffelVision2 objects that are recyclable (inheriting {EB_RECYCLABLE} are automatically destoryed if you do not destory them! This is
		              true for all automatically recycled referring objects. Saying that, it's better to be explict about
		              destorying EiffelVision2 objects.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_RECYCLABLE

inherit
	USABLE_I

feature -- Basic operations

	frozen recycle is
			-- To be called when the button has became useless.
		local
			l_pool: like internal_recycle_pool
			l_recycled: ARRAYED_LIST [EB_RECYCLABLE]

		do
			if not is_recycled and not is_recycling then
					-- Prevents multiple calls.

				is_recycling := True

					-- Recycled pooled objects
				l_pool := internal_recycle_pool
				if l_pool /= Void then
					from l_pool.start until l_pool.after loop
						create l_recycled.make (0)
						(agent (a_item: ANY; a_recycled: ARRAYED_LIST [EB_RECYCLABLE])
							local
								l_entity: ANY
								l_recycable: EB_RECYCLABLE
								l_ev: EV_ANY
								retried: BOOLEAN
							do
								if not retried and a_item /= Void then
									l_entity := reveal_recyclable_item (a_item)
									if l_entity /= Void then
										l_recycable ?= l_entity
										if l_recycable /= Void and then (not l_recycable.is_recycled and not l_recycable.is_recycling) then
												-- Perform recycle
											l_recycable.recycle
											a_recycled.extend (l_recycable)
										end

										l_ev ?= l_entity
										if l_ev /= Void and not l_ev.is_destroyed then
												-- Destory EiffelVision 2 object
											l_ev.destroy
										end
									end
								end
							rescue
								retried := True
								retry
							end).call ([l_pool.item, l_recycled])
						l_pool.forth
					end
					l_pool.wipe_out
					internal_recycle_pool := Void
				end

					-- Remove from parent recycler
				if is_auto_recycled then
					if not recycler.is_recycled and not recycler.is_recycling then
						recycler.remove_auto_recycle (Current)
					else
						set_recycler (Void)
					end
				end

					-- Perform recycling of Current
				is_recycled := True
				internal_recycle

					-- Remove registered actions
				if internal_recycle_actions /= Void then
					internal_recycle_actions.do_all (agent (a_item: TUPLE [sequence: ACTION_SEQUENCE [TUPLE]; action: PROCEDURE [ANY, TUPLE]])
						local
							l_compare: BOOLEAN
						do
							l_compare := a_item.sequence.object_comparison
							a_item.sequence.compare_objects
							a_item.sequence.prune_all (a_item.action)
							if not l_compare then
								a_item.sequence.compare_references
							end
						end)
					internal_recycle_actions.wipe_out
				end

					-- Detachment processing
				if is_auto_recycled then
					if recycler = Void or else not recycler.is_recycling then
							-- Prevents auto-recycled items from being detached until all managed entities have
							-- been recycled.

							-- Detached auto-recycled items
						from l_recycled.start until l_recycled.after loop
							detach_entities (l_recycled.item)
							l_recycled.forth
						end
						l_pool.wipe_out
						internal_recycle_pool := Void
					end
				end
					-- Detach Current attributes
				internal_detach_entities

				is_recycling := False
			end
		ensure
			recycled: is_recycling or else is_recycled
			internal_recycle_pool_detached: is_recycled implies internal_recycle_pool = Void
		end

feature {NONE} -- Basic operations

	frozen detach_entities (a_recyclable: EB_RECYCLABLE) is
			-- Detaches objects from their container.
			-- Note: Please enable the debug clause recycle_and_detach to enable this feature for debugging purposes.
			--
			-- `a_recyclable': The object to detach entities for.
		require
			a_recyclable_attached: a_recyclable /= Void
		local
			l_internal: INTERNAL
			l_count, i: INTEGER
			l_any: EV_ANY
			l_skip_implementation: BOOLEAN
			l_actions: ACTION_SEQUENCE [TUPLE]
		do
			debug ("recycle_and_detach")
					-- Because of the need to destroy EiffelVision2 widgets, we need to detect
					-- and skip the detachment of {EV_ANY}.implementation.
				l_any ?= a_recyclable
				l_skip_implementation:= l_any /= Void

				create l_internal
				l_count := l_internal.field_count (a_recyclable)
				from i := 1 until i > l_count loop
					if l_internal.field_type (i, a_recyclable) = l_internal.reference_type and then (not l_skip_implementation or else not l_internal.field_name (i, a_recyclable).is_equal (once "implementation")) then
						l_actions ?= l_internal.field (i, a_recyclable)
						if l_actions /= Void then
							l_actions.wipe_out
						end

							-- Detach field (except {EV_ANY}.implementation)
						l_internal.set_reference_field (i, a_recyclable, Void)
					end
					i := i + 1
				end
			end
		end

feature {ANY} -- Extension

	frozen auto_recycle (a_object: ANY)
			-- Automatically recycles of an object when Current is recycled of.
			--
			-- `a_object': Object to dispose of when Current is disposed.
		require
			not_is_recycled: not is_recycled
			a_object_attached: a_object /= Void
		local
			l_recyclable: EB_RECYCLABLE
		do
			check
				not_recycle_pool_has_a_object: not recycle_pool.has (a_object)
			end

			recycle_pool.extend (a_object)
			l_recyclable ?= a_object
			if l_recyclable /= Void then
				l_recyclable.set_recycler (Current)
			end
		ensure
			recycle_pool_has_a_object: recycle_pool.has (a_object)
		end

	frozen delayed_auto_recycle (a_action: FUNCTION [ANY, TUPLE, ANY])
			-- Automatically recycles of an object when Current is recycled of.
			--
			-- `a_action': The action to retrieve a object for when Current is recycled.
			--             Warning: THe action should not create any objects for Current
		require
			not_is_recycled: not is_recycled
			a_action_attached: a_action /= Void
		do
			check
				not_recycle_pool_has_a_object: not recycle_pool.has (a_action)
			end

			recycle_pool.extend (a_action)
		ensure
			recycle_pool_has_a_action: recycle_pool.has (a_action)
		end

feature -- Agent assistance

	register_action (a_sequence: ACTION_SEQUENCE [TUPLE]; a_action: PROCEDURE [ANY, TUPLE]) is
			-- Registers an action sequence and automatically pools it for later removal.
			--
			-- `a_sequence': Action sequence to extend an action on.
			-- `a_action': The action to extend to the sequence.
		require
			a_sequence_attached: a_sequence /= Void
			a_action_attached: a_action /= Void
		do
			a_sequence.extend (a_action)
			recycle_actions.extend ([a_sequence, a_action])
		ensure
			a_sequence_has_action: a_sequence.has (a_action)
		end

	register_kamikaze_action (a_sequence: ACTION_SEQUENCE [TUPLE]; a_action: PROCEDURE [ANY, TUPLE]) is
			-- Registers a single-execute action sequence and automatically pools it for later removal, if it was not used.
			--
			-- `a_sequence': Action sequence to extend an action on.
			-- `a_action': The action to extend to the sequence.
		require
			a_sequence_attached: a_sequence /= Void
			a_action_attached: a_action /= Void
		do
			a_sequence.extend_kamikaze (a_action)
			recycle_actions.extend ([a_sequence, a_action])
		ensure
			a_sequence_has_action: a_sequence.has_kamikaze_action (a_action)
		end

feature {EB_RECYCLABLE} -- Removal

	frozen remove_auto_recycle (a_object: ANY)
			-- Removes a recycled entity from being automatically recycled
			--
			-- `a_object': The object to remove from the auto-recycle pool.
		require
			not_is_recycled: not is_recycled
			a_object_attached: a_object /= Void
		local
			l_recyclable: EB_RECYCLABLE
		do
			check
				recycle_pool_has_a_object: recycle_pool.has (a_object)
			end
			recycle_pool.start
			recycle_pool.prune (a_object)
			l_recyclable ?= a_object
			if l_recyclable /= Void then
				l_recyclable.set_recycler (Void)
			end
		ensure
			not_recycle_pool_has_a_object: not recycle_pool.has (a_object)
		end

feature {NONE} -- Access

	frozen recycle_pool: ARRAYED_LIST [ANY]
			-- List of items to be automatically recycled when Current is recycled
		require
			not_is_recycled: not is_recycled
		do
			Result := internal_recycle_pool
			if Result = Void then
				create Result.make (1)
				internal_recycle_pool := Result
			end
		ensure
			result_attached: Result /= Void
			esult_consistent: Result = recycle_pool
		end

	frozen recycle_actions: ARRAYED_LIST [TUPLE [sequence: ACTION_SEQUENCE [TUPLE]; a_action: PROCEDURE [ANY, TUPLE]]]
			-- List of items to be automatically recycled when Current is recycled
		require
			not_is_recycled: not is_recycled
		do
			Result := internal_recycle_actions
			if Result = Void then
				create Result.make (1)
				internal_recycle_actions := Result
			end
		ensure
			result_attached: Result /= Void
			esult_consistent: Result = recycle_actions
		end

feature {EB_RECYCLABLE} -- Access

	frozen recycler: EB_RECYCLABLE assign set_recycler
			-- Parent recycler

feature {EB_RECYCLABLE} -- Element change

	frozen set_recycler (a_recycler: like recycler)
			-- Set's parent recycler for auto-recycle.
			--
			-- `a_recycler': The parent recycler that will auto-recycle Current; Void to detach and suppress auto-recycling.
		do
			recycler := a_recycler
		ensure
			recycler_set: recycler = a_recycler
		end

feature -- Status report

	is_recycled: BOOLEAN
			-- Has current been recycled?

	is_interface_usable: BOOLEAN
			-- Dtermines if the interface was usable
		do
			Result := not is_recycled
		ensure then
			not_is_recycled: Result implies not is_recycled
		end

feature {EB_RECYCLABLE} -- Status report

	is_recycling: BOOLEAN
			-- Indicates if Current is in the process of being recycled

	frozen is_auto_recycled: BOOLEAN
			-- Indicates if Current is to be automatically recycled by another recycler
		do
			Result := recycler /= Void
		end

feature {NONE} -- Query

	frozen reveal_recyclable_item (a_object: ANY): ANY
			-- Attempts to reveal a recyclable item, which will call an agent if the object
			-- actually represents an agent call to retrieve an object for the classes Current state
			-- instead of it's initial state.
			--
			-- `a_object': The object to reveal a recyclable object for.
			-- `Result': A object that could potentially be recycled.
		require
			a_object_attached: a_object /= Void
		local
			l_action: FUNCTION [ANY, TUPLE, ANY]
		do
			l_action ?= a_object
			if l_action /= Void then
				Result := l_action.item ([])
			else
				Result := a_object
			end
		end

feature {NONE} -- Implementation

	internal_recycle is
			-- To be called when the button has became useless.
			-- Note: It's recommended that you do not detach objects here.
		deferred
		end

	internal_detach_entities is
			-- Detaches objects from their container
		do
			detach_entities (Current)
		end

feature {NONE} -- Internal implementation cache

	frozen internal_recycle_pool: like recycle_pool
			-- Cached version of `recycle_pool'
			-- Note: Do not use directly!

	frozen internal_recycle_actions: like recycle_actions
			-- Cached version of `recycle_actions'
			-- Note: Do not use directly!

invariant
	recycler_attached: is_auto_recycled implies recycler /= Void
	not_is_recycled: is_recycling implies not is_recycled

;indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EB_RECYCLABLE
