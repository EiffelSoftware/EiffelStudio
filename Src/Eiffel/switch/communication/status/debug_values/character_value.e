indexing

	description:
		"Run time value representing a character."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class CHARACTER_VALUE

inherit
	DEBUG_BASIC_VALUE [CHARACTER]
		redefine
			type_and_value, dump_value,
			debug_value_type_id
		end

	CHARACTER_ROUTINES
		undefine
			is_equal
		end

create {DEBUG_VALUE_EXPORTER}
	make, make_attribute

feature -- Access

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		local
			val: ANY
			cval: CHARACTER_REF
		do
			val := value
			cval ?= val
			if cval /= Void then
				Result := Debugger_manager.Dump_value_factory.new_character_value (cval.item, Dynamic_class)
			end
		end

feature {NONE} -- Output

	type_and_value: STRING_32 is
			-- Return a string representing `Current'.
		do
			create Result.make (30)
			Result.append (dynamic_class.name_in_upper)
			Result.append (Equal_slash)
			Result.append (value.code.out)
			Result.append (Slash_colon)
			Result.append (char_text (value))
			Result.append (Quote)
		end

feature {NONE} -- Constants

	Equal_slash: STRING is " = /"
	Slash_colon: STRING is "/ : %'"
	Quote: STRING is "%'";

feature {DEBUGGER_TEXT_FORMATTER_VISITOR} -- Debug value type id

	debug_value_type_id: INTEGER is
		do
			Result := character_value_id
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CHARACTER_VALUE
