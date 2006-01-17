indexing
 
	description:
		"Options explicitely set in the Ace file"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"
 
class ACE_OPTIONS

feature -- Properties

	has_assertion: BOOLEAN
	has_hide: BOOLEAN
	has_profile: BOOLEAN
	has_external_profile: BOOLEAN
	has_trace: BOOLEAN

	has_dead_code_removal: BOOLEAN
	array_optimization: BOOLEAN
	inlining: BOOLEAN
	collect: BOOLEAN
	exception_trace: BOOLEAN
	precompiled: BOOLEAN
	override_cluster: BOOLEAN

feature -- Setting

	set_has_assertion (b: BOOLEAN) is
			-- Set `has_assertion' to `b'.
		do
			has_assertion := b
		end

	set_has_hide (b: BOOLEAN) is
			-- Set `has_hide' to `b'.
		do
			has_hide := b
		end

	set_has_profile (b: BOOLEAN) is
			-- Set `has_profile' to `b'.
		do
			has_profile := b
		end

	set_has_external_profile (b: BOOLEAN) is
		do
			has_external_profile := b
		end

	set_has_trace (b: BOOLEAN) is
			-- Set `has_trace' to `b'.
		do
			has_trace := b
		end

feature -- Default value

	reset is
			-- Reset all the boolean values to `False'.
			--| We do not reset the value of `has_multithreaded' because
			--| we want to keep the previous value to know wether or not
			--| we will launch a C-compilation.
		do
			has_assertion := False
			has_hide := False
			has_profile := False
			has_external_profile := False
			has_trace := False

			has_dead_code_removal := False
			array_optimization := False
			inlining := False
			collect := False
			exception_trace := False
			precompiled := False
			override_cluster := False
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ACE_OPTIONS
