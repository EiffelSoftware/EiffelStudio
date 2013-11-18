note
	description: "This class collects settings about how ABEL should handle an object graph."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"
	documentation: "[
		Documentation of the object graph depth concept:
			Each operation on a repository has a depth parameter. The depth indicates how much of an object should be loaded.
			
			A depth of 1 for example means that only the basic types of an object (Numbers, Booleans and Strings)
			should be loaded/inserted/updated, but no referenced object. A depth of 2 means that, additionally to the basic types,
			all referenced objects  should be loaded/stored as if the repository operation has been called on them with 
			object graph depth 1 (you can already see how to continue this for higher numbers...)
			
			There is a special value for the depth: Object_graph_depth_infinite means that an object has to be loaded completely,
			i.e. that there are no more Void references.
			
			The system's default values are Object_graph_depth_infinite for inserting and reading objects, and a depth of 1 for
			updates and deletions. These default values can be overwritten for a whole repository in {REPOSITORY}.default_object_graph_settings
			
			Note: On some repositories the actual object graph depth will be ignored, and it will always use Object_graph_depth_infinite
			instead.
	]"
	TODO: "Some settings are constant right now. They should get implemented in the future"

class
	PS_OBJECT_GRAPH_SETTINGS

create
	make

feature -- Query settings

--	query_depth: INTEGER
			-- Object graph depth for queries, or reading objects in general.

feature -- Insert settings

	insert_depth: INTEGER
			-- Object graph depth for inserts.

	is_update_during_insert_enabled: BOOLEAN = False
			-- Should an object be updated, if it is already in the database and it is referenced by a new object?

	custom_update_depth_during_insert: INTEGER
			-- The object graph depth that should be applied for an update to an object, which is found during insert and is already in the database.
		do
			Result := update_depth
		end

feature -- Update settings

	update_depth: INTEGER
			-- Object graph depth for updates.
			-- Updates are somewhat special: For depth 1, the system will look at references and update them if they point to another object than before, but it will not
			-- call update on the referenced object. In addition, if an update operation finds a new (= not previously loaded) object, it will insert it
			-- if is_isert_during_update_enabled is True.

	update_last_references: BOOLEAN = True
			-- Should the last (Depth = 1) references be updated?
			-- Note: This only covers the references (-> foreign keys) to objects, not the referenced object itself.

	is_insert_during_update_enabled: BOOLEAN = True
			-- Should the system automatically insert objects which are not present in the database and found during an update?

	custom_insert_depth_during_update: INTEGER
			-- The object graph depth that should be applied to insert an object which is found during an update, but isn't yet in the database.
		do
			Result := insert_depth
		end

	throw_error_for_unknown_objects: BOOLEAN
			-- If a new object is found an (is_insert_during_update_enabled = False), should an error be thrown for a new object?
			-- If not, the reference is set to NULL in the database.
		require
			no_automatic_insert: not is_insert_during_update_enabled
		do
			Result := False
		end

feature -- Deletion settings

	delete_depth: INTEGER
			-- Object graph depth for deletion.

feature -- Modification

--	set_query_depth (depth: INTEGER)
--			-- Change the object graph depth for queries.
--		require
--			valid_depth: is_valid_depth (depth)
--		do
--			query_depth := depth
--		end

	set_insert_depth (depth: INTEGER)
			-- Change the object graph depth for insertion.
		require
			valid_depth: is_valid_depth (depth)
		do
			insert_depth := depth
		end

	set_update_depth (depth: INTEGER)
			-- Change the object graph depth for updates.
		require
			valid_depth: is_valid_depth (depth)
		do
			update_depth := depth
		end

	set_delete_depth (depth: INTEGER)
			-- Change the object graph depth for deletion.
		require
			valid_depth: is_valid_depth (depth)
		do
			delete_depth := depth
		end

feature -- Status

	is_valid_depth (depth: INTEGER): BOOLEAN
			-- Is `depth' in a valid range?
		do
			Result := depth >= Minimum_depth or depth = Object_graph_depth_infinite
		end

feature -- Creation

	make, reset_to_default
			-- Create a new OBJECT_GRAPH_DEPTH object with our system's default values.
		do
--			query_depth := Object_graph_depth_infinite
			insert_depth := Object_graph_depth_infinite
			update_depth := Object_graph_depth_infinite
			delete_depth := Minimum_depth
		end

feature -- Constants

	Minimum_depth: INTEGER = 1
			-- The smallest possible object graph depth.

	Object_graph_depth_infinite: INTEGER = -1
			-- Load/store full object.

invariant
--	valid_query_depth: is_valid_depth (query_depth)
	valid_insert_depth: is_valid_depth (insert_depth)
	valid_update_depth: is_valid_depth (update_depth)
	valid_delete_depth: is_valid_depth (delete_depth)

end
