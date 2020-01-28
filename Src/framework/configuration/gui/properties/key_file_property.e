note
	description: "Property for msil key files, that allow to choose an existing file or if an non existing file is choosen it will be created."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	KEY_FILE_PROPERTY

inherit
	FILE_PROPERTY
		rename
			make as make_property
		redefine
			dialog_ok
		end

create
	make

feature {NONE} -- Creation

	make (version: like il_version; property_name: like name)
			-- Create a new key file property of name `property_name` with version `version`.
		do
			il_version := version
			make_property (property_name)
		ensure
			il_version_set: il_version = version
		end

feature -- Access

	il_version: STRING_32
			-- Il version to use if we create a new key file.

feature -- Update

	set_il_version (a_version: like il_version)
			-- Set `il_version' to `a_version'.
		require
			a_version_ok: a_version /= Void and then not a_version.is_empty
		do
			il_version := a_version
		ensure
			il_version_set: il_version = a_version
		end

feature {NONE} -- Actions

	dialog_ok (a_dial: EV_FILE_OPEN_DIALOG)
			-- If dialog is closed with ok.
		local
			l_file: RAW_FILE
			l_key_generator: IL_KEY_GENERATOR
		do
			check
				il_version_set: il_version /= Void and then not il_version.is_empty
			end
			Precursor {FILE_PROPERTY}(a_dial)
			if attached value as v then
				create l_file.make_with_name (v)
				if not l_file.exists and l_file.is_creatable then
					create l_key_generator
					l_key_generator.generate_key (v, il_version)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
