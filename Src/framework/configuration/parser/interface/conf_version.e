indexing
	description: "Version number."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_VERSION

inherit
	COMPARABLE
		undefine
			is_equal
		redefine
			out
		end

	ANY
		redefine
			out
		end

create
	make,
	make_version,
	make_from_string

feature {NONE} -- Initialization

	make is
			-- Create with default version number.
		do
			major := 0
			minor := 0
			release := 0
			build := 1
		end

	make_version (a_major, a_minor, a_release, a_build: NATURAL_16) is
			-- Create a version.
		do
			major := a_major
			minor := a_minor
			release := a_release
			build := a_build
		end

	make_from_string (a_version: STRING) is
			-- Parse `a_version' or set an error
			-- Has to be of format XXX.XXX.XXX.XXX where only the first part is obligatory.
			-- regexp to match it is \d*(\.\d*){0,3}
		require
			a_version_not_void: a_version /= Void
		local
			l_parts: LIST [STRING]
			l_version: ARRAY [NATURAL_16]
		do
			create l_version.make (1, 4)
			l_parts := a_version.split ('.')
			if l_parts.count = 0 or l_parts.count > 4 then
				is_error := True
			else
				from
					l_parts.start
				until
					is_error or l_parts.after
				loop
					if l_parts.item.is_natural_16 then
						l_version[l_parts.index] := l_parts.item.to_natural_16
					else
						is_error := True
					end
					l_parts.forth
				end
			end

			if not is_error then
				make_version (l_version[1], l_version[2], l_version[3], l_version[4])
			end
		end

feature -- Status

	is_error: BOOLEAN
			-- Was there an error?

feature -- Access, stored in configuration file

	major: NATURAL_16
			-- The major version.

	minor: NATURAL_16
			-- The minor version.

	release: NATURAL_16
			-- The release version.

	build: NATURAL_16
			-- The build version.

	version: STRING is
			-- The complete version.
		do
			create Result.make_empty
			Result.append_integer (major)
			Result.append_character ('.')
			Result.append_integer (minor)
			Result.append_character ('.')
			Result.append_integer (release)
			Result.append_character ('.')
			Result.append_integer (build)
		end

	company: STRING
			-- The company.

	product: STRING
			-- The product.

	trademark: STRING
			-- The trademark.

	copyright: STRING
			-- The copyright

feature {CONF_ACCESS}  -- Update, stored in configuration file

	increase_major is
			-- Increase `major'.
		do
			major := major + 1
		ensure
			major_greater: old (major) < major
		end

	increase_minor is
			-- Increase `minor'.
		do
			minor := minor + 1
		ensure
			minor_greater: old (minor) < minor
		end

	increase_release is
			-- Increase `release'.
		do
			release := release + 1
		ensure
			release_greater: old (release) < release
		end

	increase_build is
			-- Increase `build'.
		do
			build := build + 1
		ensure
			build_greater: old (build) < build
		end

	set_major (a_major: like major) is
			-- Set `major' to `a_major'
		do
			major := a_major
		ensure
			major_set: major = a_major
		end

	set_minor (a_minor: like minor) is
			-- Set `minor' to `a_minorr'
		do
			minor := a_minor
		ensure
			minor_set: minor = a_minor
		end

	set_release (a_release: like release) is
			-- Set `release' to `a_release'
		do
			release := a_release
		ensure
			release_set: release = a_release
		end

	set_build (a_build: like build) is
			-- Set `build' to `a_build'
		do
			build := a_build
		ensure
			build_set: build = a_build
		end

	set_company (a_company: like company) is
			-- Set `company' to `a_company'.
		do
			company := a_company
		ensure
			company_set: company = a_company
		end

	set_product (a_product: like product) is
			-- Set `producat' to `a_product'.
		do
			product := a_product
		ensure
			product_set: product = a_product
		end

	set_trademark (a_trademark: like trademark) is
			-- Set `trademark' to `a_trademark'.
		do
			trademark := a_trademark
		ensure
			trademark_set: trademark = a_trademark
		end

	set_copyright (a_copyright: like copyright) is
			-- Set `copyright' to `a_copyright'.
		do
			copyright := a_copyright
		ensure
			copyright_set: copyright = a_copyright
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN is
			-- Compare
		do
			Result := major < other.major or
				(major = other.major and minor < other.minor) or
				(major = other.major and minor = other.minor and release < other.release) or
				(major = other.major and minor = other.minor and release = other.release and build < other.build)
		end

feature -- Output

	out: STRING is
			-- New string with printable representation.
		local
			l_ext: STRING
		do
			Result := version

			create l_ext.make_empty
			if product /= Void and then not product.is_empty then
				l_ext.append (product+" ")
			end
			if company /= Void and then not company.is_empty then
				l_ext.append (company+" ")
			end
			if copyright /= Void and then not copyright.is_empty then
				l_ext.append ("(c) "+copyright+" ")
			end
			if trademark /= Void and then not trademark.is_empty then
				l_ext.append ("(tm) "+trademark+" ")
			end
			if not l_ext.is_empty then
				l_ext.prune_all_trailing (' ')
				Result.append (" ("+l_ext+")")
			end
		end

indexing
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
