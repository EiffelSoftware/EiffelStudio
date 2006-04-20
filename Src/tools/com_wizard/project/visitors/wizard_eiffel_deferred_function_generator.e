indexing
	description: "Eiffel deferred function generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_DEFERRED_FUNCTION_GENERATOR

inherit
	WIZARD_EIFFEL_FUNCTION_GENERATOR

	WIZARD_EIFFEL_ASSERTION_GENERATOR

create
	generate

feature -- Basic operation

	generate (a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate deferred function
		local
			tmp_arguments: STRING
		do
			func_desc := a_descriptor

			create feature_writer.make
			feature_writer.set_comment (func_desc.description)
			feature_writer.set_name (func_desc.interface_eiffel_name)

			-- Set arguments and precondition
			set_feature_result_type_and_arguments
			set_feature_assertions
			add_feature_argument_comments

			if func_desc.arguments /= Void and not func_desc.arguments.is_empty then
				func_desc.arguments.start

				if not is_paramflag_fretval (func_desc.arguments.item.flags) then
					create tmp_arguments.make (100)
					tmp_arguments.append (" (")
					tmp_arguments.append (func_desc.arguments.item.name)

					from
						func_desc.arguments.forth
					until
						func_desc.arguments.after
					loop
						if not is_paramflag_fretval (func_desc.arguments.item.flags) then
							tmp_arguments.append (", ")
							tmp_arguments.append (func_desc.arguments.item.name)
						end
						func_desc.arguments.forth
					end
					tmp_arguments.append (")")
				end
			end

			feature_writer.set_deferred
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
end -- class WIZARD_EIFFEL_DEFERRED_FUNCTION_GENERATOR

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

