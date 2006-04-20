indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Records common properties of Eiffel sub-expressions, which can
-- be put in temporary registers (expression spliting).

deferred class REGISTRABLE 
	
feature 

	register: REGISTRABLE is
			-- Where expression is stored.
		do
		end;
	
	set_register (r: REGISTRABLE) is
			-- Set current register to `r'
		do
		end;

	c_type: TYPE_C is
			-- Associated C type
		deferred
		end;

	register_name: STRING is
			-- The ASCII representation of the register
		deferred
		end;

	context: BYTE_CONTEXT is
			-- Context in which generation occurs
		deferred
		end;

	get_register is
			-- Ask for a new register.
		do
		end;

	free_register is
			-- Free register for use by others.
		do
		end;
	
	print_register is
			-- Generates the C representation of `register'
		do
			context.buffer.put_string (register_name)
		end;

	propagate (r: REGISTRABLE) is
			-- Propagates the target of assignment `r' to avoid
			-- an extra temporary variable.
		do
		end;

	is_result: BOOLEAN is
			-- Is register the Result entity ?
		do
		end;

	is_inlined_result: BOOLEAN is
			-- Is register the inlined Result entity ?
		do
		end;

	is_current: BOOLEAN is
			-- Is register the Current entity ?
		do
		end;

	is_inlined_current: BOOLEAN is
			-- Is register the inlined Current entity ?
		do
		end;

	is_argument: BOOLEAN is
			-- Is register an argument entity ?
		do
		end;

	is_predefined: BOOLEAN is
			-- Is Current a predefined entity ?
		do
			Result := is_local or else is_argument or else is_result or else is_current;
		end;

	is_special: BOOLEAN is
			-- Is register Result or Current ?
		do
		end;

	is_local: BOOLEAN is
			-- Is register a local entity ?
		do
		end;

	is_temporary: BOOLEAN is
			-- Is register a temporary one ?
		do
		end;

	No_register: VOID_REGISTER is
			-- Special entity for no register
		once
			create Result;
		end;

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
