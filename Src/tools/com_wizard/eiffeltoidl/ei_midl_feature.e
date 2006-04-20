indexing
	description: "MIDL feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_FEATURE

inherit
	EI_FEATURE

	WIZARD_LANGUAGES_KEYWORDS
		export
			{NONE} all
		end

	ECOM_PARAM_FLAGS

create
	make

feature -- Output

	code: STRING is
			-- Code output
		local
			l_comment: STRING
		do
			Result := ("%T%(helpstring (%"")

			l_comment := comment.twin
			l_comment.prune_all ('%N')
			l_comment.prune_all ('%R')
			l_comment.prune_all ('%"')

			Result.append (l_comment)
			Result.append ("%")%) %N%T%THRESULT ")

			Result.append (name)
			Result.append (Space_open_parenthesis)

			if not parameters.is_empty then

				from
					parameters.start
				until
					parameters.after
				loop
					Result.append (parameters.item.code)
					Result.append (Comma_space)
					parameters.forth
				end

				if result_type.is_empty then
					Result.remove (Result.count)
					Result.remove (Result.count)
				end

			end

			if not result_type.is_empty then
				Result.append (Open_bracket)
				Result.append (Out_retval)
				Result.append (Close_bracket)
				Result.append (result_type)
				Result.append (" * ")
				Result.append (Return_value_variable_name)
			end

			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
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
end -- class EI_MIDL_FEATURE

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

