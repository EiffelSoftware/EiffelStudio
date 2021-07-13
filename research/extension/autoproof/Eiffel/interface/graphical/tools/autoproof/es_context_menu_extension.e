note
	description: "An implementation of a context menu extension service."

class
	ES_CONTEXT_MENU_EXTENSION

inherit
	CONTEXT_MENU_EXTENSION_S
	DISPOSABLE_SAFE
	EB_SHARED_PIXMAPS
	SHARED_LOCALE

feature -- Modification

	extend_feature
		(f: E_FEATURE;
		extender: PROCEDURE [
			READABLE_STRING_32, -- name
			STRING, -- icon
			BOOLEAN, -- is_sensitive
			PROCEDURE -- action
		])
			-- <Precursor>
		local
			is_running: BOOLEAN
		do
			if
				attached verifier.service as s and then
				f.associated_feature_i.has_code
			then
				is_running := s.is_running
				extender
					(if is_running then
						locale.translation_in_context ("Verify with AutoProof (running)", "menu.feature")
					else
						locale.translation_in_context ("Verify with AutoProof", "menu.feature")
					end,
					icon_pixmaps.verifier_verify_feature_name,
					not is_running,
					agent s.verify_feature (f))
			end
		end

	extend_class (c: CLASS_C; extender:
		PROCEDURE [
			READABLE_STRING_32, -- name
			READABLE_STRING_8, -- icon
			BOOLEAN, -- is_sensitive
			PROCEDURE -- action
		])
			-- <Precursor>
		local
			is_running: BOOLEAN
		do
			if attached verifier.service as s then
				is_running := s.is_running
				extender
					(if is_running then
						locale.translation_in_context ("Verify with AutoProof (running)", "menu.class")
					else
						locale.translation_in_context ("Verify with AutoProof", "menu.class")
					end,
					icon_pixmaps.verifier_verify_class_name,
					not is_running,
					agent s.verify_class (c))
			end
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

feature {NONE} -- Service access

	verifier: SERVICE_CONSUMER [VERIFIER_S]
			-- Access to the verfier service.
		once
			create Result
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
