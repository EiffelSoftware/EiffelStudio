indexing
	description: "[
		The built-in help provider types ("kinds") retrievable through a help providers service interface {HELP_PROVIDERS_S}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	HELP_PROVIDER_KINDS

feature -- Access

	frozen default_help: !UUID
			-- Default help system.
		once
				-- Compiled URI help system is the default help for now.
			Result := raw_uri
		end

	frozen chm: !UUID
			-- Compiled HTML help system.
		once
			create Result.make_from_string (chm_uuid_string)
		end

	frozen eiffel_doc: !UUID
			-- Eiffel documentation help system.
		once
			create Result.make_from_string (eiffel_doc_string)
		end

	frozen wiki: !UUID
			-- Public Eiffel Wiki help system.
		once
			create Result.make_from_string (wiki_uuid_string)
		end

	frozen raw_uri: !UUID
			-- Raw URI help system
		once
			create Result.make_from_string (raw_uri_uuid_string)
		end

	frozen pdf: !UUID
			-- PDF help system
		once
			create Result.make_from_string (pdf_uuid_string)
		end

	frozen doc: !UUID
			-- Microsoft DOC help system
		once
			create Result.make_from_string (doc_uuid_string)
		end

	frozen eis_default: !UUID
			-- Default EIS provider
		once
			create Result.make_from_string (eis_uuid_string)
		end

feature -- Constants

	chm_uuid_string: !STRING     = "E1FFE14E-B816-4675-B15D-087E948DA79A"
	eiffel_doc_string: !STRING   = "E1FFE14E-80FB-11DD-AD8B-0800200C9A66"
	wiki_uuid_string: !STRING    = "E1FFE14E-64D2-4F19-B2E5-BC121E228FE4"
	raw_uri_uuid_string: !STRING = "742EC425-77EE-4B54-9152-29E845758329"
	pdf_uuid_string: !STRING     = "BA35A9BB-5B69-4BD3-88B3-FB8DAE5CA08E"
	doc_uuid_string: !STRING     = "49CA2564-83BB-45AE-95C0-491245F4FB3C"
	eis_uuid_string: !STRING     = "309C1917-9AB0-44E0-AD42-53C2E5F7FD16"

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
