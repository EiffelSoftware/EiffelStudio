note

	description: "Translate an Eiffel type to a SQL type."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class TRANSLATE inherit

	EXT_INTERNAL

feature

	to_sql (r_any: ANY): STRING
			-- Convert `r_any' type on a SQL type.
		require
			r_any_not_void: r_any /= Void
		do
			if is_integer (r_any) then
				Result := "integer"
			elseif is_real (r_any) then
				Result := "float"
			elseif is_double (r_any) then
				Result := "float"
			elseif is_boolean (r_any) then
				Result := "varchar (1)"
			elseif is_character (r_any) then
				Result := "varchar (1)"
			elseif is_string (r_any) then
				Result := "varchar (255)"
			elseif is_date (r_any) then
				Result := "date"
			else
				Result := "UNKNOW TYPE"
			end
		ensure
			result_not_void: Result /= Void
		end;

	is_simple_type (r_any: ANY): BOOLEAN
			-- `r_any' is a simple type?
		require
			r_any_not_void: r_any /= Void
		do
			Result := 
			is_integer (r_any) or else
			is_real (r_any) or else
			is_double (r_any) or else
			is_boolean (r_any) or else
			is_character (r_any) or else
			is_string (r_any) or else
			is_date (r_any)
		ensure
			Result = (
			is_integer (r_any) or else
			is_real (r_any) or else
			is_double (r_any) or else
			is_boolean (r_any) or else
			is_character (r_any) or else
			is_string (r_any) or else
			is_date (r_any))
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


end -- class TRANSLATE


