indexing
	description: "Class used to store state circles."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class S_BEHAVIOR

inherit
	SHARED_STORAGE_INFO

creation
	make

feature {NONE} -- Initialization 

	make (b: BEHAVIOR) is
		local
			stored_input: S_EVENT_ELMT
			stored_output: S_COMMAND_ELMT
		do
			identifier := b.identifier
			internal_name := b.label
			create input_list.make
			create output_list.make
			from
				b.start
			until
				b.off
			loop
				create stored_input.make (b.input)
				create stored_output.make (b.output)
				input_list.put_right (stored_input)
				output_list.put_right (stored_output)
				input_list.forth
				output_list.forth
				b.forth
			end
		end

feature {S_STATE} -- Access

	identifier: INTEGER

	behavior: BEHAVIOR is
		do
			Result := behavior_table.item (identifier)
			if Result = Void then
					-- Behavior has not been retrieved yet
				create Result.make
				if for_import.item then
					Result.set_internal_name ("")
				else
					Result.set_internal_name (internal_name)
				end
				from
					input_list.start
					output_list.start
				until
					input_list.after
				loop
					Result.add (input_list.item.event, output_list.item.command)
					input_list.forth
					output_list.forth
				end
				behavior_table.put (Result, identifier)
			end
		end

feature {NONE} -- Implemention

	input_list: LINKED_LIST [S_EVENT_ELMT]

	output_list: LINKED_LIST [S_COMMAND_ELMT]

	internal_name: STRING

end -- class S_BEHAVIOR

