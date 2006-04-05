indexing
	description: "Encapsulation of a C external extension."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class IL_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS

	SHARED_IL_CONSTANTS

create
	initialize

feature -- Initialization

	initialize (a_language_type, a_type: INTEGER; a_sig: SIGNATURE_AS; a_class: ID_AS) is
			-- Create IL_EXTENSION_AS node.
		require
			a_type: valid_type (a_type)
			a_class_not_void: a_class /= Void
		do
			type := a_type
			sig := a_sig
			base_class := a_class
		ensure
			type_set: type = a_type
			base_class_set: base_class = a_class
		end

feature -- Properties

	type: INTEGER
			-- Type of IL external.
			--| See SHARED_IL_CONSTANTS for all types constants.

	sig: SIGNATURE_AS
			-- Associated signature of IL external

	base_class: STRING
			-- Name of IL class where feature is defined

feature -- Get the C extension

	extension_i: IL_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			create Result
			init_extension_i (Result)
			Result.set_type (type)
			Result.set_base_class (base_class)
			if sig /= Void then
				Result.set_argument_types (sig.arguments_id_array)
				if sig.return_type_id /= 0 and sig.return_type_id /= Void_name_id then
					Result.set_return_type (sig.return_type_id)
				end
			end
		end

feature {NONE} -- Constants

	void_name_id: INTEGER is
			-- Value for `System.Void'.
		local
			l_names_heap: like names_heap
		once
			l_names_heap := names_heap
			l_names_heap.put ("System.Void")
			Result := l_names_heap.found_item
		ensure
			result_not_null: Result > 0
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

end -- class IL_EXTENSION_AS

