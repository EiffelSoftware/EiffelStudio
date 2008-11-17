indexing
	description: "[
		A help provider service {HELP_PROVIDERS_S} implementation used in querying help service providers based on available providers described in {HELP_PROVIDER_KINDS}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	HELP_PROVIDERS

inherit
	SAFE_AUTO_DISPOSABLE
		redefine
			safe_dispose
		end

	HELP_PROVIDERS_S

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize help providers service
		do
			create providers.make_default
			create activate_providers.make_default
		end

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN)
			-- <Precursor>
		local
			l_keys: DS_BILINEAR_CURSOR [!UUID]
		do
			if a_disposing then
					-- Remove and clean up all providers
				l_keys := providers.keys.new_cursor
				from l_keys.start until l_keys.after loop
				 	unregister_provider (l_keys.item)
				 	l_keys.forth
				end
				check
					providers_is_empty: providers.is_empty
					activate_providers_is_empty: activate_providers.is_empty
				end
			end
			internal_help_providers := Void
			Precursor {SAFE_AUTO_DISPOSABLE} (a_disposing)
		ensure then
			internal_help_providers_detached: internal_help_providers = Void
		end

feature -- Access

	help_providers: !DS_BILINEAR [!HELP_PROVIDER_I]
			-- <Precursor>
		local
			l_result: like internal_help_providers
			l_list: DS_ARRAYED_LIST [!HELP_PROVIDER_I]
			l_keys: DS_BILINEAR_CURSOR [!UUID]
			l_providers: like providers
		do
			l_result := internal_help_providers
			if l_result = Void then
				l_providers := providers
				create l_list.make (l_providers.count)

				l_keys := l_providers.keys.new_cursor
				from l_keys.start until l_keys.after loop
					check
						is_provider_available: is_provider_available (l_keys.item)
					end
					l_list.put_last (help_provider (l_keys.item))
					l_keys.forth
				end
				Result := l_list
				internal_help_providers := l_list
			else
				Result := l_result
			end
		end

feature {NONE} -- Access

	providers: !DS_HASH_TABLE [FUNCTION [ANY, TUPLE [providers: !HELP_PROVIDERS_S], !HELP_PROVIDER_I], !UUID]
			-- Table of registered help providers

	activate_providers: !DS_HASH_TABLE [!HELP_PROVIDER_I, !UUID]
			-- Table of registered help providers, which have been requested

feature -- Query

	help_provider (a_kind: !UUID): !HELP_PROVIDER_I
			-- <Precursor>
		local
			l_service: !HELP_PROVIDERS_S
		do
				-- Bad hack relying on one compiler bug to circumvent another compiler bug.
			if activate_providers.has (a_kind) then
				Result := activate_providers.item (a_kind)
			else
				l_service := Current
				Result := providers.item (a_kind).item ([l_service])
				Result.set_kind (a_kind)
				activate_providers.force_last (Result, a_kind)
			end
		ensure then
			activate_providers_has_a_kind: activate_providers.has (a_kind)
			result_kind_set: Result.kind.is_equal (a_kind)
		end

	is_provider_available (a_kind: !UUID): BOOLEAN
			-- <Precursor>
		do
			Result := providers.has (a_kind)
		end

feature -- Basic operations

	register_provider_with_activator (a_kind: !UUID; a_activator: FUNCTION [ANY, TUPLE [providers: !HELP_PROVIDERS_S], !HELP_PROVIDER_I])
			-- <Precursor>
		do
			providers.force_last (a_activator, a_kind)
		ensure then
			internal_help_providers_reset: internal_help_providers = Void or else
				internal_help_providers /~ old internal_help_providers
		end

	unregister_provider (a_kind: !UUID)
			-- <Precursor>
		do
			providers.remove (a_kind)
			if activate_providers.has (a_kind) then
					-- Clean up provider
				if {l_disposable: !DISPOSABLE} activate_providers.item (a_kind) then
					l_disposable.dispose
				end

					-- Remove active provider
				activate_providers.remove (a_kind)
			end
		ensure then
			internal_help_providers_reset: internal_help_providers = Void or else
				internal_help_providers /~ old internal_help_providers
			not_activate_providers_has_a_kind: not activate_providers.has (a_kind)
		end

feature {NONE} -- Implementation: Internal cache

	internal_help_providers: ?like help_providers
			-- Cached version of `help_providers'
			-- Note: Never use directly!

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
