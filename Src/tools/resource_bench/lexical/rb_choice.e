indexing
	description:
		"Constructs whose specimens are specimens of constructs %
		%chosen among a specified list."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RB_CHOICE

inherit
	CHOICE
		redefine
			raise_syntax_error
		end

	ERROR_HANDLING
		undefine
			is_equal, copy
		end
		
	WEL_MESSAGE_BOX
		undefine
			is_equal, copy
		end

	WEL_MB_CONSTANTS	
		undefine
			is_equal, copy
		end

feature {NONE} -- Implementation

	raise_syntax_error (s: STRING) is
			-- Print error message s.
		local
			s2 : STRING
		do  
			if not has_error then
				set_has_error (true)

				!! s2.make (50)
				s2.append (" (line ")
				s2.append_integer (document.token.line_number)
				s2.append ("): ")

				s2.append (s)
				s2.append (" in ")
				s2.append (construct_name)
				if parent /= Void then
					s2.append (" in ") 
					s2.append (parent.construct_name)
				end

				error_message_box (s2, Mb_ok + Mb_iconstop )
			end
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
end -- class CHOICE
