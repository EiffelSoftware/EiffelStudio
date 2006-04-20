indexing
	description: "Objects that compress all used ids in Build.%
		%This ensures that they are contiguous."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_ID_COMPRESSOR

inherit

	GB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_components

feature {NONE} -- Creation

	components: GB_INTERNAL_COMPONENTS

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature -- Basic operation

	compress_all_id is
			-- Compress all ids used in system, so they
			-- are contiguous.
		local
			objects: ARRAYED_LIST [GB_OBJECT]
			counter: INTEGER
			objects_without_ids: BOOLEAN
			current_object: GB_OBJECT
			original_id: INTEGER
		do
			components.system_status.set_object_structure_changing
				-- First, intialization.
			create existing_ids.make (50)
			create deleted_ids.make (50)
			objects := components.object_handler.objects.linear_representation
			objects.merge_right (components.object_handler.deleted_objects.linear_representation)
				-- Firstly, store all ids into an array
			objects.do_all (agent record_id)
				-- Now create lookup table.
			create lookup.make (existing_ids.count)
				-- Populate `look_up'.
			from
				counter := 1
			until
				counter > existing_ids.count
			loop
					-- If existing id is 0, then it means that
					-- we are dealing with an old save, and as such there
					-- were no ids in the system, so ignore.
				if existing_ids @ counter /= 0  then
					lookup.put (counter, existing_ids @ counter)
				else
					objects_without_ids := True
				end
				counter := counter + 1
			end

			from
				objects.start
			until
				objects.off
			loop
				if components.object_handler.deleted_objects.has (objects.item.id) then
					deleted_ids.put (objects.item.id, objects.item.id)
				end
				objects.forth
			end

			components.object_handler.objects.clear_all
			components.object_handler.deleted_objects.clear_all

				-- Now update all ids stored in objects.
			from
				objects.start
			until
				objects.off
			loop
				current_object := objects.item
				original_id := current_object.id
				current_object.update_internal_id_references (lookup)

				if deleted_ids.has (original_id) then
					components.object_handler.deleted_objects.put (current_object, current_object.id)
				else
					components.object_handler.objects.put (current_object, current_object.id)
				end

				objects.forth
			end
			components.id_handler.set_current_id_counter (objects.count + 1)


				-- Now, if `objects_without_ids' is `True', it means
				-- that some of the objects referenced in the save file
				-- do not have ids (an old save file). So we must now add ids
				-- to all of these objects.
				--| FIXME should probably happen before the replacing of objects.
			from
				objects.start
			until
				objects.off
			loop
				if objects.item.id = 0 then
					objects.item.assign_id
				end
				objects.forth
			end
			components.system_status.set_object_structure_changed
		ensure
			lists_not_changed: old components.object_handler.objects.count = components.object_handler.objects.count and
				old components.object_handler.deleted_objects.count = components.object_handler.deleted_objects.count
		end

	shift_all_ids_upwards is
			-- For every id in system, shift higher.
			-- Used when importing projects, so we do not get
			-- a clash between the current and new ids.
		local
			linear_objects: LINEAR [GB_OBJECT]
		do
			linear_objects := components.object_handler.objects.linear_representation
			from
				linear_objects.start
			until
				linear_objects.off
			loop
				shift_id (linear_objects.item)
				shift_referer_ids (linear_objects.item)
				linear_objects.forth
			end
		end

	shift_object_ids_updwards (an_object: GB_OBJECT) is
			-- For `an_object' and all child objects recursively, shift their
			-- ids upwards by `amount_to_shift_ids_during_import'.
		require
			an_object_not_void: an_object /= Void
			is_new_object: not components.object_handler.objects.has_item (an_object) and not components.object_handler.deleted_objects.has_item (an_object)
			no_instance_referers: an_object.instance_referers.is_empty
		local
			recursive_children: ARRAYED_LIST [GB_OBJECT]
			current_object: GB_OBJECT
		do
			an_object.set_id (an_object.id + amount_to_shift_ids_during_import)
			create recursive_children.make (50)
			an_object.all_children_recursive (recursive_children)
			from
				recursive_children.start
			until
				recursive_children.off
			loop
				current_object := recursive_children.item
				current_object.set_id (current_object.id + amount_to_shift_ids_during_import)
				recursive_children.forth
			end
		end

	shift_referer_ids (an_object: GB_OBJECT) is
			-- For all `instance_referers' of `an_object', shift their
			-- ids upwards by `amount_to_shift_ids_during_import'.
		require
			an_object_not_void: an_object /= Void
		local
			linear: LINEAR [INTEGER]
			new_value: INTEGER
		do
			linear := an_object.instance_referers.linear_representation
				-- Remove all entries from the `instance_referers'.
			an_object.instance_referers.clear_all
			from
				linear.start
			until
				linear.off
			loop
				new_value := linear.item + amount_to_shift_ids_during_import
					-- Insert the new referer back into `instance_referers'.
				an_object.instance_referers.put (new_value, new_value)
				linear.forth
			end
		ensure
			instance_referers_count_not_changed: old an_object.instance_referers.count = an_object.instance_referers.count
		end

	shift_id (an_object: GB_OBJECT) is
			-- Adjust id of `an_object' upwards by `amount_to_shift_ids_during_import'.
		require
			an_object_not_void: an_object /= Void
			object_already_exists: components.object_handler.objects.has (an_object.id) or components.object_handler.deleted_objects.has (an_object.id)
		local
			in_objects: BOOLEAN
		do
			in_objects := components.object_handler.objects.has (an_object.id)
			if in_objects then
				components.object_handler.objects.remove (an_object.id)
			else
				components.object_handler.deleted_objects.remove (an_object.id)
			end
			an_object.set_id (an_object.id + amount_to_shift_ids_during_import)
			if in_objects then
				components.object_handler.objects.put (an_object, an_object.id)
			else
				components.object_handler.deleted_objects.put (an_object, an_object.id)
			end
		end

	compress_object_id (an_object: GB_OBJECT; start_value: INTEGER) is
			-- Compress all ids of `an_object' and all children, so
			-- they are contiguous, starting at `start_value'.
		require
			an_object_not_void: an_object /= Void
		local
			objects: ARRAYED_LIST [GB_OBJECT]
			counter: INTEGER
		do
				-- Older systems may contain objects with no ids.
				-- If an object has an id of 0, then it means that
				-- it was originally created before ids were added
				-- to Build
			if an_object.id /= 0 then
				create existing_ids.make (50)
				create objects.make (50)
				objects.extend (an_object)
				an_object.all_children_recursive (objects)

					-- Firstly, store all ids into an array
				objects.do_all (agent record_id)
					-- Now create lookup table.
				create lookup.make (existing_ids.count)
					-- Populate `look_up'.
				from
					counter := 1
				until
					counter > existing_ids.count
				loop
					lookup.put (counter + start_value - 1, existing_ids @ counter)
					counter := counter + 1
				end

					-- Now update all ids stored in objects.
				from
					objects.start
				until
					objects.off
				loop
					objects.item.update_internal_id_references (lookup)
					objects.forth
				end
				components.id_handler.set_current_id_counter (components.id_handler.current_id_counter + objects.count)
			end
		end

feature {GB_COMPONENT} -- implementation

	lookup: HASH_TABLE [INTEGER, INTEGER]
			-- All ids original position in `exising_ids',
			-- hashed on the id.

	existing_ids: ARRAYED_LIST [INTEGER]
			-- All ids before compression

	deleted_ids: HASH_TABLE [INTEGER, INTEGER]
		-- All ids that are contained within `deleted_objects' at start.

feature {NONE} -- Implementation

	record_id (an_object: GB_OBJECT) is
			-- Add `id' of `an_object' to `existing_ids'.
		require
			an_object_not_void: an_object /= Void
		do
			existing_ids.extend (an_object.id)
				-- Firstly, store all ids into an array.
		ensure
			added: existing_ids.has (an_object.id)
		end

indexing
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


end -- class GB_ID_COMPRESSOR
