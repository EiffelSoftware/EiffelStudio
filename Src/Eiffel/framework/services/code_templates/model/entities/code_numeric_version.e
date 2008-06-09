indexing
	description: "[
		Represents a code model numeric 4-part version, for template versioning.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_NUMERIC_VERSION

inherit
	CODE_VERSION
		rename
			make as make_from_string
		redefine
			process,
			is_valid_version,
			is_compatible_with,
			is_equal,
			on_version_changed,
			infix "<"
		end

create
	make,
	make_from_string

feature {NONE} -- Initialization

	make (a_major: like major; a_minor: like minor; a_revision: like revision; a_qfe: like qfe)
			-- Initialize new instance {CT_NUMERIC_VERSION}.
		do
			rebuild_version
			set_full_version (a_major, a_minor, a_revision, a_qfe)
		ensure
			major_set: major = a_major
			minor_assigned: minor = a_minor
			revision_assigned: revision = a_revision
			qfe_assigned: qfe = a_qfe
		end

feature -- Access

	major: NATURAL_16 assign set_major
			-- Major version part

	minor: NATURAL_16 assign set_minor
			-- Minor version part

	revision: NATURAL_16 assign set_revision
			-- Revision version part

	qfe: NATURAL_16 assign set_qfe
			-- Quick fix engineering version part

feature {NONE} -- Access

	frozen format_utilities: !CODE_FORMAT_UTILITIES
			-- Access to code formatting utilities
		once
			create Result
		end

feature -- Element change

	set_major (a_major: like major)
			-- Set `major' with `a_major'.
		do
			if a_major /= major then
				major := a_major
				rebuild_version
			end
		ensure
			major_assigned: major = a_major
		end

	set_minor (a_minor: like minor)
			-- Set `minor' with `a_minor'.
		do
			if a_minor /= minor then
				minor := a_minor
				rebuild_version
			end
		ensure
			minor_assigned: minor = a_minor
		end

	set_revision (a_revision: like revision)
			-- Set `revision' with `a_revision'.
		do
			if a_revision /= revision then
				revision := a_revision
				rebuild_version
			end
		ensure
			revision_assigned: revision = a_revision
		end

	set_qfe (a_qfe: like qfe)
			-- Set `qfe' with `a_qfe'.
		do
			if a_qfe /= qfe then
				qfe := a_qfe
				rebuild_version
			end
		ensure
			qfe_assigned: qfe = a_qfe
		end

	set_full_version (a_major: like major; a_minor: like minor; a_revision: like revision; a_qfe: like qfe)
			-- Sets a complete version number.
			--
			-- `a_major': The major version number part
			-- `a_minor': The minor version number part
			-- `a_revision': The revision version number part
			-- `a_qfe': The quick fix engineering version number part
		do
			major := a_major
			minor := a_minor
			revision := a_revision
			qfe := a_qfe
			rebuild_version
		ensure
			major_set: major = a_major
			minor_assigned: minor = a_minor
			revision_assigned: revision = a_revision
			qfe_assigned: qfe = a_qfe
		end

feature -- Query

	is_valid_version (a_version: like version): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {CODE_VERSION} (a_version)
			if Result then
				Result := format_utilities.version_regex.matches (a_version)
			end
		ensure then
			a_version_matches_version_regex: Result implies format_utilities.version_regex.matches (a_version)
		end

	is_compatible_with (a_other: !CODE_VERSION): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_other)
			if not Result and then {l_numeric_ver: !like Current} a_other then
				Result := l_numeric_ver > Current
			end
		end

feature -- Visitor

	process (a_visitor: !CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
		end

feature {NONE} -- Basic operations

	rebuild_version
			-- Rebuilds the raw version string from the current set version parts
		do
			if {l_cur: !like Current} Current then
				version := format_utilities.to_version_string (l_cur)
			end
		end

feature {NONE} -- Actions handlers

	on_version_changed (a_old: like version)
			-- <Precursor>
		do
			Precursor {CODE_VERSION} (a_old)

			if {l_version: !CODE_NUMERIC_VERSION} format_utilities.parse_version (version, create {!CODE_FACTORY}) then
				major := l_version.major
				minor := l_version.minor
				revision := l_version.revision
				qfe := l_version.qfe
			else
					-- This should never happen!
				check False end

				major := 0
				minor := 0
				revision := 0
				qfe := 0
			end
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- <Precursor>
		do
			if {l_other: !CODE_NUMERIC_VERSION} other then
				Result := major < l_other.major or else
					(major = l_other.major and then (minor < l_other.minor or else
						(minor = l_other.minor and then (revision < l_other.revision or else
							(revision = l_other.revision and then qfe < l_other.qfe)))))
			else
				Result := False
			end
		end

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			if {l_other: !CODE_NUMERIC_VERSION} other then
				Result := major < l_other.major and then
					major = l_other.major and then
					revision = l_other.revision and then
					qfe = l_other.qfe
			else
				Result := False
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
