indexing
	description: "Class representing an Eiffel class of the %
				% application as described in the common directory %
				% BUILDGEN\common."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	APPLICATION_CLASS

inherit

	EV_LIST_ITEM
		redefine
			make_with_text, is_equal
		end

	COMPARABLE
		redefine
			is_equal
		end

creation
	make_with_text

feature -- Creation

	make_with_text (par: EV_LIST; txt: STRING) is
			-- Create a class with the name `txt'.
		require else
			class_name_not_void: txt /= Void
			class_name_not_empty: not txt.empty
		do
			class_name := txt
			create query_list.make
			create command_list.make
			create routine_list.make
			create generated_routines.make
			{EV_LIST_ITEM} Precursor (par, txt)
		end

feature -- Attributes

	class_name: STRING
			-- Name of the class

	query_list: LINKED_LIST [APPLICATION_QUERY]
			-- List of queries

	command_list: LINKED_LIST [APPLICATION_COMMAND]
			-- List of commands

	routine_list: LINKED_LIST [APPLICATION_ROUTINE]
			-- List of routines

	generated_routines: LINKED_LIST [APPLICATION_ROUTINE]

feature -- Access

	add_command (a_command: APPLICATION_COMMAND) is
			-- Add `a_command' to the list of commands.
		require
			valid_command: a_command /= Void
		do
			command_list.extend (a_command)
		end

	add_query (a_query: APPLICATION_QUERY) is
			-- Add `a_query' to the list of queries.
		require
			valid_query: a_query /= Void 
		do
			query_list.extend (a_query)
		end

	add_routine (a_routine: APPLICATION_ROUTINE) is
			-- Add `a_routine' to the list of routines.
		require
			valid_routine: a_routine /= Void 
		do
			routine_list.extend (a_routine)
		end

	add_generated_routine (a_routine: APPLICATION_ROUTINE) is
			-- Add `a_routine' to the list of routines.
		require
			valid_routine: a_routine /= Void 
		do
			generated_routines.extend (a_routine)
		end
	
-- feature -- SCROLLABLE_LIST_ELEMENT
-- 
-- 	value: STRING  is
-- 			-- String that appears in a scrollable list.
-- 		do
-- 			Result := class_name
-- 		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Equality.
		do
			Result := class_name.is_equal (other.class_name)
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Less than
		do
			Result := class_name < other.class_name
		end

end -- class APPLICATION_CLASS

