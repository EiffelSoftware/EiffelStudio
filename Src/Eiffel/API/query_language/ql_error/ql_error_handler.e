note
	description: "Error handler for Eiffel Query Language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_ERROR_HANDLER

inherit
	EXCEPTIONS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			create error_list.make
		end

feature -- Access

	error_list: LINKED_LIST [QL_ERROR]
			-- Error list

feature -- Status

	has_error: BOOLEAN
			-- Has error handler detected an error so far?
		do
			Result := not error_list.is_empty
		end

feature -- Element change

	insert_interrupt_error (a_msg: STRING_GENERAL)
			-- Insert an `interrup_error' so that current query language process
			-- can be stopped.
			-- `a_msg' contains a message.
		require
			a_msg_attached: a_msg /= Void
		local
			interrupt_error: QL_INTERRUPT_ERROR
		do
			create interrupt_error.make (a_msg)
			insert_error (interrupt_error)
			raise_error
		end

	insert_error (e: QL_ERROR)
			-- Insert `e' in `error_list'.
		require
			good_argument: e /= Void
		do
			error_list.extend (e)
			error_list.finish
		end

	raise_error
			-- Raise an exception.
		require
			has_error: has_error
		do
			raise ("Query language processing error")
		end

	checksum
			-- Check if there are errors in `error_list' and raise
			-- an error if needed.
		do
			if has_error then
				raise_error
			end
		end

	wipe_out
			-- Empty `error_list'.
		do
			error_list.wipe_out
		end

note
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
