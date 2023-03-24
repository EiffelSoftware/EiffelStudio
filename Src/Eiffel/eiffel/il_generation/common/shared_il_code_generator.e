note
	description: "Shared object that knows to generate IL code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_IL_CODE_GENERATOR

feature -- IL generator object

	il_generator: IL_CODE_GENERATOR
			-- To generate IL code. So far we only support CIL.
		once
			Result := cil_generator
		ensure
			class
		end

	cil_generator: CIL_CODE_GENERATOR
			-- Generator for CIL code
		once
				-- We keep both `INTERFACE_xx' and `SINGLE_xx' in
				-- our system for the moment in case we need to
				-- switch back to either one or the other.
			create {SINGLE_IL_CODE_GENERATOR} Result.make
			create {INTERFACE_IL_CODE_GENERATOR} Result.make
		ensure
			class
		end

feature -- IL label factory

	il_label_factory: IL_LABEL_FACTORY
			-- To create `label' in IL code.
		once
			create Result.make
		ensure
			class
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end
