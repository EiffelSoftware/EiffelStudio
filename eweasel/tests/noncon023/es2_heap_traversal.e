note
	description: "Summary description for {ES2_OBJECT_GRAPH_TRAVERSAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES2_HEAP_TRAVERSAL

inherit
	ES2_OBJECT_TRAVERSAL

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			visited_objects := new_sequence
		end

feature {NONE} -- Access

	object: ANY
			-- Object currently being traversed
		require
			traversing: is_traversing
		deferred
		ensure
			result_attached: Result /= Void
		end

	visited_objects: SEQUENCE [ANY]
			-- Visited (marked) objects.

feature {NONE} -- Status report

	is_traversing: BOOLEAN
			-- Is an object currently being traversed?
		deferred
		end

	is_skip_transient: BOOLEAN
			-- Shall transient fields be skipped?

feature {NONE} -- Status setting

	forth
			-- Make next object in queue available in `object'.
		require
			traversing: is_traversing
		deferred
		end

feature {NONE} -- Element change

	put (an_object: ANY)
			-- Queue `an_object' to be traversed.
		deferred
		end

feature {NONE} -- Basic operations

	process_field (an_object: ANY; a_field_index: INTEGER)
			-- <Precursor>
		do
			if
				field_type (a_field_index, an_object) = {INTERNAL}.reference_type and
				not (is_skip_transient and is_field_transient (a_field_index, an_object))
			then
				process_reference (field (a_field_index, an_object))
			end
		end

	process_special_field (a_special: SPECIAL [detachable ANY]; a_field: INTEGER_32)
			-- <Precursor>
		do
			if is_special_any_type (dynamic_type (a_special)) then
				process_reference (a_special[a_field])
			end
		end

	process_tuple_field (a_tuple: TUPLE; a_field: INTEGER_32)
			-- <Precursor>
		do
			if a_tuple.is_reference_item (a_field) then
				process_reference (a_tuple.reference_item (a_field))
			end
		end

	process_reference (a_reference: detachable ANY)
			-- Process reference
		require
			traversing: is_traversing
		do
			if
				a_reference /= Void and then not a_reference.generating_type.is_expanded and then
				not is_marked (a_reference)
			then
				mark (a_reference)
				put (a_reference)
			end
		end

feature {NONE} -- Factory

	new_sequence: SEQUENCE [ANY]
		do
			create {ARRAYED_LIST [ANY]} Result.make (default_sequence_size)
		end

feature {NONE} -- Constants

	default_sequence_size: INTEGER = 200

end
