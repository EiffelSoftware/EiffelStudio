note
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

	boolean_format (object: BOOLEAN): STRING
			-- String representation in SQL of `object'
		do
			if object.item then
				Result := db_spec.True_representation
			else
				Result := db_spec.False_representation
			end
		end

	date_format (object: DATE_TIME): STRING
			-- String representation in SQL of `object'
		require
			object_not_void: object /= Void
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

	string_format (object: STRING): STRING
			-- String representation in SQL of `object'
		obsolete
			"Use `string_format_32' instead [2017-11-30]."
		require
			object_not_void: object /= Void
		do
			Result := string_format_32 (object.as_string_8).as_string_8
		end

	string_format_32 (object: READABLE_STRING_GENERAL): STRING_32
			-- String representation in SQL of `object'
		require
			object_not_void: object /= Void
		do
			Result := db_spec.string_format_32 (object)
		end

feature {NONE} -- Status report

	date_buffer: STRING
			-- String constant
		once
			create Result.make (20)
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DATABASE_FORMAT


