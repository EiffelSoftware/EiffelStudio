indexing

	description:
		"Error when a call as an instruction is used as an expression."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class VKCN

inherit
	FEATURE_ERROR
		redefine
			build_explain
		end

feature -- Access

	code: STRING is "VKCN"
			-- Error code

	called_feature: STRING
			-- Routine being called as an expression

	data_type_string: STRING is
			-- String representing the kind of error we are handling.
		deferred
		end

feature -- Error message

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- <Precursor>
		do
			if called_feature /= Void then
				a_text_formatter.add (data_type_string)
				a_text_formatter.add (called_feature)
				a_text_formatter.add_new_line
			end
		end

feature -- Settings

	set_called_feature (a_feature_name: STRING) is
			-- Assign `f' to `feature'.
		require
			a_feature_name_not_void: a_feature_name /= Void
		do
			called_feature := a_feature_name
		ensure
			called_feature_not_void: called_feature = a_feature_name
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

end -- class VKCN
