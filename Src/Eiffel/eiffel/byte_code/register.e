indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- A temporary register to hold the result of an expression.

class REGISTER

inherit

	REGISTRABLE
		redefine
			get_register, free_register,
			is_temporary, is_predefined
		end;

	SHARED_BYTE_CONTEXT;

	SHARED_C_LEVEL;

create

	make

feature

	regnum: INTEGER;
			-- Which register is it ?
	
	c_type: TYPE_C;
			-- C type of the register
	
	make (ctype: TYPE_C) is
			-- Create a register of C type `ctype'.
		require
			valid_type: ctype /= Void;
			non_void_type: ctype.level /= C_void;
		do
			c_type := ctype;
			get_register;
		end;
	
	get_register is
			-- Get a register for C type `c_type'
		do
			regnum := context.register_server.get_register (c_type);
			if c_type.is_pointer then
				context.set_local_index (register_name, Current);
			end;
		ensure then
			valid_register: regnum /= 0;
		end;

	free_register is
			-- Free register used by the expression
		require else
			register_exists: regnum /= 0;
		do
			context.register_server.free_register (c_type, regnum);
		end;

	grab_register is
			-- Reserve a register for immediate use.
		do
			get_register;
			free_register;
		end;

	register_name: STRING is
			-- ASCII representation of register
		do
			create Result.make (10)
			inspect
				c_type.level
			when c_uint8 then
				Result.append ("tu8_");
			when c_uint16 then
				Result.append ("tu16_");
			when c_uint32 then
				Result.append ("tu32_");
			when c_uint64 then
				Result.append ("tu64_");
			when C_int8 then
				Result.append ("ti8_");
			when C_int16 then
				Result.append ("ti16_");
			when C_int32 then
				Result.append ("ti32_");
			when C_int64 then
				Result.append ("ti64_");
			when C_ref then
				Result.append ("tp");
			when C_real32 then
				Result.append ("tr32_");
			when C_char then
				Result.append ("tc");
			when C_wide_char then
				Result.append ("twc");
			when C_real64 then
				Result.append ("tr64_");
			when C_pointer then
				Result.append ("ta");
			end;
			Result.append(regnum.out);
		end;

	is_temporary: BOOLEAN is True
			-- Register is a temporary one.
			
	is_predefined: BOOLEAN is True
			-- It is a predefined register, since it stores temporarly
			-- object.

invariant

	not_void_type: c_type.level /= C_void;
	valid_c_type: c_type.level >= 1 and c_type.level <= C_nb_types;

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

end
