indexing
	description: "This class provides a mapping between Java and Eiffel objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class JAVA_OBJECT_TABLE 

create
	make

feature {NONE} -- Initialization

	make is
			-- Create a table for Eiffel proxies of Java object
		do
			create table.make (511)
		end

feature -- Access

	item (object: POINTER): JAVA_OBJECT is
			-- find a Eiffel proxy for an Java object
		require
			object_not_void: object /= default_pointer
		do
			Result := table.item (object)
		end

feature -- Element change

	put (object: JAVA_OBJECT) is
			-- Add a new object to the table
		require
			object_not_void: object /= Void
			object_alive: object.exists
		local
			it: JAVA_OBJECT
			ex: EXCEPTIONS
		do
			it := table.item (object.java_object_id)
			if it = Void then
				table.put (object, object.java_object_id)
			elseif (it /= object) then
				create ex
				ex.raise ("Attempted to insert duplicate Eiffel object")
			end
		ensure
			inserted: table.has (object.java_object_id)
		end

feature {NONE}

	table: HASH_TABLE [JAVA_OBJECT, POINTER]
			-- Table of objects

invariant
	table_not_void: table /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

