indexing
	description: "Class used to store context structures."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class S_CONTEXT

inherit
	SHARED_STORAGE_INFO

feature -- Access

	context (par: CONTEXT): CONTEXT is
			-- EiffelBuild context corresponding
			-- to Current.
		do
			Result.set_internal_name (internal_name)
			Result.set_parent (par)
			Result.set_retrieved_node (Current)
			if for_import.item then
					-- Record context with this identifier
					-- for the S_CONTXT_ELMT object.
				Result.set_next_identifier
				debug ("STORER_CHECK")
					io.error.putstring ("setting new identifier for context ")
					io.error.putstring (internal_name)
					io.error.new_line
				end
			else
				Result.set_identifier (identifier)
			end
			debug ("STORER")
				if par /= Void
				and then not par.is_a_group
				and then context_table.has (identifier)
				then
					io.error.putstring ("**** Error: Context already exists: ")
					io.error.putstring (internal_name)
					io.error.putstring (" ****")
					io.error.new_line
				else
					io.error.putstring ("Creating ")
					io.error.putstring (Result.internal_name)
					io.error.putstring (" id: ")
					io.error.putint (Result.identifier)
					if Result.is_in_a_group then
						io.error.putstring (" is in a group")
					end
					io.error.new_line
				end
			end
		end

	identifier: INTEGER

	internal_name: STRING

	visual_name: STRING

	arity: INTEGER

	set_attributes (c: CONTEXT) is
			-- Set the attributes of `c'
			-- to the stored values
		do
			if visual_name /= Void then
				c.retrieve_set_visual_name (visual_name)
			end
		end

feature {NONE} -- Storage

	save_attributes (node: CONTEXT) is
		do
			internal_name := node.entity_name
			visual_name := node.visual_name
			identifier := node.identifier
			debug ("STORER_CHECK") 
				io.error.putstring ("storing: ")
				io.error.putstring (internal_name)
				io.error.putstring (" id: ")
				io.error.putint (identifier)
				io.error.new_line
			end
			arity := node.arity
		end

	Not_set: INTEGER is -1

feature -- Debugging

	trace is
		do
			io.error.putstring (" int: ")
			io.error.putstring (internal_name)
			io.error.putstring (" id: ")
			io.error.putint (identifier)
			if visual_name /= Void then
				io.error.putstring (" vn: ")
				io.error.putstring (visual_name)
			end
		end

end -- class S_CONTEXT

