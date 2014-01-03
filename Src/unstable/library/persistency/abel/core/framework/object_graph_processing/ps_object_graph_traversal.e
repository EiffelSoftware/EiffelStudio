note
	description: "Traverses an object graph and creates an array %
				% of OBJECT_DATA for every visited object."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_GRAPH_TRAVERSAL

inherit

	PS_ABEL_EXPORT

	OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE
		export {NONE}
			set_on_processing_object_action,
			set_on_processing_reference_action,
			set_object_action,
			set_is_skip_copy_semantics_reference,
			set_is_exception_on_copy_suppressed,
			wipe_out
		redefine
			internal_traverse
		end

create
	make

feature {NONE} -- Initialization

	make (a_root_object: ANY; a_factory: PS_METADATA_FACTORY)
			-- Initialize `Current'
		do
			create traversed_objects.make (default_size)
			factory := a_factory
			set_root_object (a_root_object)
			set_on_processing_object_action (agent on_object_agent)
			set_on_processing_reference_action (agent on_reference_agent)
			set_is_exception_on_copy_suppressed (True) -- Readonly access is sufficient.
			set_is_skip_copy_semantics_reference (True) -- We don't need the output array anyway.
			set_is_exception_propagated (True) -- We want to have exceptions...
		end

feature -- Access

	traversed_objects: ARRAYED_LIST [PS_OBJECT_WRITE_DATA]

	factory: PS_METADATA_FACTORY
			-- A factory for PS_TYPE_METADATA objects.

feature {NONE} -- Implementation

	current_index: INTEGER
			-- The index of the object that is currently being processed by the algorithm.

	internal_traverse (a_root_object: ANY)
			-- Traverse object structure starting at 'root_object' and call object_action
			-- on every object in the graph.
		local
			reflected_object: REFLECTED_REFERENCE_OBJECT
			type: PS_TYPE_METADATA
			root_object_data: PS_OBJECT_WRITE_DATA
		do
				-- Initialize the data structures first.
			traversed_objects.wipe_out
			create reflected_object.make (a_root_object)
			type := factory.create_metadata_from_type_id (reflected_object.dynamic_type)
			create root_object_data.make_with_object (traversed_objects.count + 1, reflected_object, 0, type)
			traversed_objects.extend (root_object_data)
			current_index := 0

				-- Do the actual traversal.
			Precursor (a_root_object)
		end


feature {NONE} -- Implementation: Agents

	on_object_agent (an_object: REFLECTED_OBJECT)
			-- Update the current_index before processing a new object.
		do
			current_index := current_index + 1
		ensure
			index_correct:
					-- Expanded types: The reflector is aliased because it is stable.
				traversed_objects [current_index].reflector = an_object
					-- Reference types: The object is aliased.
				or else traversed_objects [current_index].reflector.object = an_object.object
		end

	on_reference_agent (referer: REFLECTED_OBJECT; referee: REFLECTED_OBJECT)
			-- Update the {PS_OBJECT_DATA}.referers and {PS_OBJECT_DATA}.references
			-- for both `referer' and `referee'.
		require
			index_correct:
					-- Expanded types: The reflector is aliased because it is stable.
				traversed_objects [current_index].reflector = referer
					-- Reference types: The object is aliased.
				or else traversed_objects [current_index].reflector.object = referer.object
		local
			new_object: PS_OBJECT_WRITE_DATA
			found: BOOLEAN
		do

			found := False

			if not referee.is_expanded then

				across
					traversed_objects as cursor
				until
					found
				loop
					if cursor.item.reflector.object = referee.object then
						cursor.item.set_referer (current_index)
						traversed_objects [current_index].references.extend (cursor.cursor_index)
						found := True
					end
				end
			end

			if not found then
				create new_object.make_with_object (traversed_objects.count + 1, referee, traversed_objects [current_index].level + 1, factory.create_metadata_from_type_id (referee.dynamic_type))
				new_object.set_referer (current_index)
				traversed_objects.extend (new_object)
				traversed_objects [current_index].references.extend (traversed_objects.count)
			end
		ensure
			index_unchanged: current_index = old current_index
		end


feature -- Debugging output

	traversed_objects_as_string: STRING
			-- Provide a printable representation for all objects in `traversed_objects'
		local
			tagged: STRING
		do
			create Result.make_empty

			across
				traversed_objects as cursor
			loop
				Result.append ("Object at index " + cursor.cursor_index.out + ":%N")
				Result.append ("%TType: " + cursor.item.reflector.type_name + "%N")
				Result.append ("%TSemantics: ")
				if cursor.item.reflector.object.generating_type.is_expanded then
					Result.append ("copy%N")
				else
					Result.append ("alias%N")
				end

				if attached {REFLECTED_REFERENCE_OBJECT} cursor.item.reflector as ref and then ref.physical_offset > 0 then
					Result.append ("%TAddress: embedded in normal object%N")
				elseif attached {REFLECTED_COPY_SEMANTICS_OBJECT} cursor.item.reflector as ref and then ref.physical_offset > 0 then
					Result.append ("%TAddress: embedded in other copysemantics object%N")
				elseif attached {REFLECTED_COPY_SEMANTICS_OBJECT} cursor.item.reflector as ref then
					Result.append ("%TAddress: unique copy-semantics%N")
				else
					Result.append ("%TAddress: " + get_string_address (cursor.item.reflector) + "%N")
				end
				Result.append ("%TLevel: " + cursor.item.level.out + "%N")

				Result.append ("%TReferer count: " + cursor.item.referer_count.out + "%N")
				if cursor.item.referer_count > 0 then
					Result.append ("%TLast referer: " + cursor.item.last_referer.out + "%N")
				end

				Result.append ("%TReferences:  ")
				across cursor.item.references as ref_cursor loop Result.append (ref_cursor.item.out + ", ") end

				Result.put ('%N', Result.count-1)
				Result.put ('%N', Result.count)
			end
		end

feature {NONE} -- Debugging output: Implementation

	get_string_address (an_object: REFLECTED_OBJECT): STRING
			-- Try to get the address.
			-- Due to a segfault issue the result may be `not available (segfault)'
		local
			tagged: STRING
			retried: BOOLEAN
		do
			if not retried then
				tagged := an_object.tagged_out
				tagged := tagged.split ('%N').i_th (2)
				tagged := tagged.substring (tagged.last_index_of ('[', tagged.count), tagged.last_index_of (']', tagged.count))
				Result := tagged
			else
				Result := "not available (segfault)"
			end
		rescue
			retried := True
			retry
		end

invariant
	root_object_set: attached root_object
	object_action_void: not attached object_action
	on_processing_object_action_set: attached on_processing_object_action
	on_processing_reference_action_set: attached on_processing_reference_action
	ignore_exceptions: is_exception_on_copy_suppressed
	skip_copysemantics: is_skip_copy_semantics_reference
end
