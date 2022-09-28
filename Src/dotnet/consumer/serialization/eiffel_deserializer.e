note
	description: "Retrieve objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EIFFEL_DESERIALIZER

inherit
	SED_MULTI_OBJECT_SERIALIZATION
		undefine
			log_last_exception
		redefine
			deserialize
		end

	SHARED_LOGGER
		export
			{NONE} all
		undefine
			default_create
		end

feature -- Basic Operations

	deserialize (path: READABLE_STRING_GENERAL; a_pos: INTEGER)
		local
			jd: CONSUMED_OBJECT_FROM_JSON
			p: PATH
			f: RAW_FILE
			fetched: BOOLEAN
		do
			if {EIFFEL_CONSUMER_SERIALIZATION}.is_json_storage then
				create p.make_from_string (path)
				create f.make_with_path (p)
				if f.exists then
--					create {CONSUMED_OBJECT_FROM_JSON_DBG} jd.make
					create jd.make
					deserialized_object := jd.from_json_file_at (f, a_pos)
					if jd.has_error then
						successful := False
					else
						fetched := deserialized_object /= Void
						successful := fetched and then not jd.has_error
					end
				end
			end
			if not fetched then
					-- Try SED retrieval
				Precursor (path, a_pos)
			end
		end

feature {NONE} -- Implementation


note
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


end
