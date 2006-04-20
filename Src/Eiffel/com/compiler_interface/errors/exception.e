indexing
	description: "Object to represent an exception"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_EXCEPTION
	
inherit
	ANY
	
	IEIFFEL_EXCEPTION_IMPL_STUB
		redefine
			inner_exception,
			message,
			exception_code
		end
	
	EXCEPTIONS
		rename
			raise as raise_exceptions
		export
			{NONE} all
		end

creation
	make,
	make_with_child

feature {NONE} -- Implementation
		
	make (a_message: STRING; a_exception_code: INTEGER) is
			-- create execption with message `a_message'
		require
			non_void_message: a_message /= Void
			valid_message: not a_message.is_empty
			valid_exception_code: a_exception_code >= 0
		do
			message := clone (a_message)
			exception_code := a_exception_code
		ensure
			message_set: message.is_equal (a_message)
			exception_code_set: exception_code = a_exception_code
		end
		
	make_with_child (a_message: STRING; a_exception: COMPILER_EXCEPTION; a_exception_code: INTEGER) is
			-- create exception with inner child exception `a_exception'
		require
			non_void_message: a_message /= Void
			valid_message: not a_message.is_empty
			non_void_exception: a_exception /= Void
		do
			make (a_message, a_exception_code)
			inner_exception := a_exception
		ensure
			message_set: message.is_equal (a_message)
			non_void_inner_exception: inner_exception /= Void
			inner_exception_set: inner_exception.is_equal (a_exception)
			exception_code_set: exception_code = a_exception_code
		end		

feature -- Access

	inner_exception: COMPILER_EXCEPTION
			-- child exception

	message: STRING
			-- execption message
	
	exception_code: INTEGER 
			-- code for exception

feature -- Status setting
		
	set_inner_exception (a_exception: COMPILER_EXCEPTION) is
			-- set `inner_exception' to `a_exception'
		require
			non_void_exception: a_exception /= Void
		do
			inner_exception := a_exception
		ensure
			non_void_inner_exception: inner_exception /= Void
			inner_exception_set: inner_exception.is_equal (a_exception)
		end
		
feature -- Basic operations

	raise is
			-- raises current exception
		do
			raise_exceptions (message)
		end

invariant
	non_void_message: message /= Void

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
end -- class COMPILER_EXCEPTION
