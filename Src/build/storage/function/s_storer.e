indexing
	description: "Class used to store and retrieve states."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class S_STORER 

inherit

	STORABLE_HDL
	SHARED_APPLICATION
	SHARED_STORAGE_INFO

feature {S_STORER}

	stored_data: LINKED_LIST [S_STATE]
	
feature 

	retrieved_data: LINKED_LIST [STATE]

	file_name: STRING is
		do
			Result := Environment.states_file_name
		end

	tmp_store (dir_name: STRING) is
		require
			valid_dir_name: dir_name /= Void
		do
			retrieved := Void
			build_stored_data
			tmp_store_by_name (dir_name)
			stored_data := Void
		end

	
feature {NONE}

	build_stored_data is
		local
			s: S_STATE
			state_list: LINKED_LIST [STATE]
		do
			!!stored_data.make
			from
				state_list := Shared_app_graph.states
				state_list.start
			until
				state_list.after
			loop
				!!s.make (state_list.item)
				stored_data.extend (s)
				state_list.forth
			end
		end

	
feature 

	retrieve (dir_name: STRING) is
		local
			sb: S_STATE
			b: STATE
		do
			retrieve_by_name (dir_name)
			stored_data := retrieved.stored_data
			!!retrieved_data.make
			from
				stored_data.start
			until
				stored_data.after
			loop
				sb := stored_data.item
				b := sb.state
				state_table.put (b, sb.identifier)
				retrieved_data.extend (b)
				stored_data.forth
			end
		end

feature {STORER} -- Interface commands

	update_interface is
			-- Add commands to the interface.
		do
			from
				retrieved_data.start
			until
				retrieved_data.after
			loop
				retrieved_data.item.update_interface_from_storage
				retrieved_data.forth
			end
		end
end
