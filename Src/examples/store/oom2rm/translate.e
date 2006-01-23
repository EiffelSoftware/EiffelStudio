indexing

	description: "Translate an Eiffel type to a SQL type."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class TRANSLATE inherit

	EXT_INTERNAL
		export
			{NONE} traversal
		end;

feature

	to_sql (some: ANY): STRING is
			-- Convert `some' type on a SQL type.
		require
			some_not_void: some /= Void
		do
			if is_integer (some) then
				Result := "integer"
			elseif is_real (some) then
				Result := "float"
			elseif is_double (some) then
				Result := "float"
			elseif is_boolean (some) then
				Result := "varchar (1)"
			elseif is_character (some) then
				Result := "varchar (1)"
			elseif is_string (some) then
				Result := "varchar (255)"
			elseif is_date (some) then
				Result := "date"
			else
				Result := "UNKNOW TYPE"
			end
		ensure
			result_not_void: Result /= Void
		end;

	is_simple_type (some: ANY): BOOLEAN is
			-- `some' is a simple type?
		require
			some_not_void: some /= Void
		do
			Result := 
			is_integer (some) or else
			is_real (some) or else
			is_double (some) or else
			is_boolean (some) or else
			is_character (some) or else
			is_string (some) or else
			is_date (some)
		ensure
			Result = (
			is_integer (some) or else
			is_real (some) or else
			is_double (some) or else
			is_boolean (some) or else
			is_character (some) or else
			is_string (some) or else
			is_date (some))
		end;
			
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


end -- class TRANSLATE


