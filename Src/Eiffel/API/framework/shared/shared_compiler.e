indexing
	description: "[
		Shared access to an initialized compiler
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SHARED_COMPILER

feature -- Access

	frozen compiler: COMPILER is
			-- Access to global compiler instance
		do
			Result := internal_complier.item
		end

feature {COMPILER} -- Element change

	frozen set_compiler (a_compiler: COMPILER) is
			-- Site shared `compiler' using `a_compiler'
		require
			a_compiler_attached: a_compiler /= Void
			compiled_unattached: compiler = Void
		local
			l_shared_provider: SHARED_SERVICE_PROVIDER
			l_provider: SERVICE_PROVIDER
			l_site: SITE [SERVICE_PROVIDER]
		do
			internal_complier.put (a_compiler)

				-- Site compiler with global service heap
			l_site := a_compiler
			create l_shared_provider
			l_provider := l_shared_provider.service_provider
			l_site.set_site (l_provider)
		ensure
			compiler_set: compiler = a_compiler
		end

feature {NONE} -- Internal implementation cache

	frozen internal_complier: CELL [COMPILER] is
			-- Cached version of `compiler'
			-- Note: Do not use directly!
		once
			create Result
		end

invariant
	compiler_attached: compiler /= Void
	compiler_is_initialized: compiler.is_initialized

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

end -- class {SHARED_COMPILER}
