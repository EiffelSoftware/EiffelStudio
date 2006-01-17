indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred class DEBUG_I 

feature 

	is_yes: BOOLEAN is
			-- Is the debug option value `yes' ?
		do
			-- Do nothing
		end;

	is_no: BOOLEAN is
			-- Is the  debug option value `no' ?
		do
			-- Do nothing
		end;

	is_partial: BOOLEAN is
			-- Is the debug option a list of tag ?
		do
			-- Do nothing
		end;

	is_debug (tag: STRING): BOOLEAN is
			-- Is the debug compatible with tag `tag' ?
		deferred
		end;

	trace is
			-- Debug purpose
		deferred
		end;

	generate (buffer: GENERATION_BUFFER; id: INTEGER) is
			-- Generate assertion value in `buffer'.
		require
			good_argument: buffer /= Void;
		deferred
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for current debug level
		deferred
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
