indexing
	description: "Implementation of DB_FORMAT"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_FORMAT [G -> DATABASE create default_create end]

inherit

	HANDLE_SPEC [G]

feature -- Conversion

	boolean_format (object: BOOLEAN): STRING is
			-- String representation in SQL of `object'
		do
			if object.item then
				Result := db_spec.True_representation
			else
				Result := db_spec.False_representation
			end		
		end

	date_format (object: DATE_TIME): STRING is
			-- String representation in SQL of `object'
		local
			d_str: STRING
		do
			create d_str.make(20) 
			d_str := db_spec.date_to_str (object)
			date_buffer.wipe_out
			date_buffer.append (d_str)
			Result := date_buffer
		ensure then
			Result = date_buffer
		end
	
	string_format (object: STRING): STRING is
			-- String representation in SQL of `object'
		do
			Result := db_spec.string_format (object)
		end

feature {NONE} -- Status report

	date_buffer: STRING is
			-- String constant
		once
			create Result.make (20)
		end

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




end -- class DATABASE_FORMAT


