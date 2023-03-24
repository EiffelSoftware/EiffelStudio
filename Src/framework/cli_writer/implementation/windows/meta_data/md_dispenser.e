note
	description: "Encapsulation of IMetaDataDispenser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_DISPENSER

inherit
	MD_DISPENSER_I

	COM_OBJECT

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make
			-- New instance of a IMetaDataDispenser.
		do
				-- Initialize COM.
			(create {CLI_COM}).initialize_com

			item := new_md_dispenser
		end

feature -- Definition

	emitter: MD_EMIT
			-- Create new scope and returns an emitter.
		do
			debug ("MD out-of-order")
				c_define_option_for_md_emit (item, 0xffffffff)
			end
			create Result.make_by_pointer (c_define_scope_for_md_emit (item))
		end

feature {NONE} -- Implementation

	new_md_dispenser: POINTER
			-- New instance of IMetaDataDispenser
		external
			"C use %"cli_writer.h%""
		end

	c_define_scope_for_md_emit (an_item: POINTER): POINTER
			-- Call `DefineScope (CLSID_CorMetaDataRuntime, 0, IID_IMetaDataEmit, (IUnknown **) &imde)'.
		external
			"C use %"cli_writer.h%""
		end

	c_define_option_for_md_emit (an_item: POINTER; val: INTEGER)
			-- Call `SetOption' to check some more errors.
		external
			"C use %"cli_writer.h%""
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class MD_DISPENSER
