note

	description:
		"Displays class flat in output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class EWB_FLAT

inherit
	EWB_COMPILED_CLASS
		rename
			make as compiled_class_make
		redefine
			name, help_message, abbreviation
		end

	EC_SHARED_PREFERENCES

create
	make, default_create

feature -- Initialization

	make (cn, fn: STRING)
			-- Initialization
		require
			cn_not_void: cn /= Void
			fn_not_void: fn /= Void
		do
			class_make (cn)
			init (fn)
		ensure
			filter_name_set: filter_name = fn
			class_name_set: class_name = cn
		end

feature -- Properties

	name: STRING
		do
			Result := flat_cmd_name
		end

	help_message: STRING_32
		do
			Result := flat_help
		end

	abbreviation: CHARACTER
		do
			Result := flat_abb
		end

feature {NONE} -- Execution

	associated_cmd: E_SHOW_FLAT
		do
			create Result
			Result.set_feature_clause_order (preferences.flat_short_data.feature_clause_order)
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

end -- class EWB_FLAT
