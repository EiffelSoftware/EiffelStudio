note

	description: "Store and retrieve keys."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class KEYS inherit

	HASH_TABLE [STRING, STRING]

	INTERNAL
		undefine
			copy,
			is_equal
		end

	EXCEPTIONS
		rename
			class_name as exceptions_class_name
		undefine
			copy,
			is_equal
		end

create

	make

feature

	reference_key (table: ANY): ANY
			-- What is the object referred by unique
			-- attribute associated with `table'.
		require
			table_not_void: table /= Void;
			table_exits: has (table.generator)
		local
			i: INTEGER;
			key_name: detachable STRING;
			l_result: detachable like reference_key
		do
			from
				key_name := item (table.generator);
				i := 1
			until
				 l_result /= Void or else i > field_count (table)
			loop
				if key_name ~ field_name (i, table) then
					l_result := field (i, table)
				end;
				i := i + 1
			end

			check l_result /= Void end -- FIXME: impled by ...?
			Result := l_result
		ensure
			found: Result /= Void
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class KEYS


