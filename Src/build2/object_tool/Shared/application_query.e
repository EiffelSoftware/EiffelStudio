indexing
	description: "Class describing the notion of a query, that is %
				% either an attribute or a function without argument."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	APPLICATION_QUERY

inherit

	EV_LIST_ITEM

creation
	make

feature -- Creation

	make (q_name, q_type: STRING) is
			-- Create a query with name `q_name' and returned
			-- type `q_type'.
		require
			valid_query_name: q_name /= Void and then not q_name.empty
			valid_query_type: q_type /= Void and then not q_type.empty
		do
			default_create
			query_name := q_name
			query_type := q_type
			set_text (value)
		end

feature -- Attributes

	query_name: STRING
			-- Name of query

	query_type: STRING
			-- Name of the returned type

	possible_commands: LINKED_LIST [APPLICATION_COMMAND]
			-- Possible commands to change the current query.

	possible_routines: LINKED_LIST [APPLICATION_ROUTINE]
			-- Possible routines to change the current query
			-- (for boolean query).

feature -- Access

	value: STRING is
			-- Value displayed in a scrollable list.
		do
			create Result.make (10)
			Result.append (query_name)
			Result.append (": ")
			Result.append (query_type)
		end

	sort_possible_methods (application: APPLICATION_CLASS) is
			-- Sort application methods and list of compatible methods
			-- containing the name of the query.
		local
			command: APPLICATION_COMMAND
			routine: APPLICATION_ROUTINE
		do
			create possible_commands.make
			create possible_routines.make
			from
				application.command_list.start
			until
				application.command_list.after
			loop
				command := application.command_list.item
				if command /= Void then
					if not query_type.is_equal ("STRING")
					and then not query_type.is_equal ("INTEGER")
					and then not query_type.is_equal ("BOOLEAN")
					or else command.argument_type.is_equal (query_type) then
						if command.command_name.substring_index (query_name, 1) > 0 then
							possible_commands.put_front (command)
						else
							possible_commands.extend (command)
						end
					end
				end
				application.command_list.forth
			end
			if query_type.is_equal ("BOOLEAN") then
				from
					application.routine_list.start
				until
					application.routine_list.after
				loop
					routine := application.routine_list.item
					if routine.argument_list.empty then
						if routine.routine_name.substring_index (query_name, 1) > 0 then
							possible_routines.put_front (routine)
						else
							possible_routines.extend (routine)
						end	
					end
					application.routine_list.forth
				end
			end
		end

end -- class APPLICATION_QUERY
