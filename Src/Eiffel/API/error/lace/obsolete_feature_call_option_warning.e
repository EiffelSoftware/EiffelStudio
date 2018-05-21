note
	description: "A warning about using an option that disables reporting obsolete feature calls that should be removed."

class
	OBSOLETE_FEATURE_CALL_OPTION_WARNING

inherit
	LACE_WARNING
		redefine
			code,
			help_file_name,
			trace_single_line
		end

	SHARED_LOCALE

feature -- Access

	code: like {WARNING}.code
			-- <Precursor>
		do
			Result := {OBS_FEAT_WARN}.code
		end

	help_file_name: like {WARNING}.help_file_name
			-- <Precursor>
		do
			Result := {OBS_FEAT_WARN}.help_file_name
		end

feature

	build_explain (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add (locale.translation_in_context ("[
					Obsolete feature calls are detected, but not reported due to project configuration settings.
					
					To get the list of obsolete feature calls
						- run the code analyzer with the corresponding rule turned on, or
						- enable reporting obsolete call warnings in the project settings and recompile the project from scratch.
				]", "compiler.warning"))
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add (locale.translation_in_context ("Obsolete feature calls are not reported.", "compiler.warning"))
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
