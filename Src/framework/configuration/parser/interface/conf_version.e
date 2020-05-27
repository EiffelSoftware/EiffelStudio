note
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
		end

	ANY

create
	make,
	make_version,
	make_from_string

feature {NONE} -- Initialization

	make
			-- Create with default version number.
		do
			major := 0
			minor := 0
			release := 0
			build := 1
		end

	make_version (a_major, a_minor, a_release, a_build: NATURAL_16)
			-- Create a version.
		do
			major := a_major
			minor := a_minor
			release := a_release
			build := a_build
		end

	make_from_string (a_version: READABLE_STRING_GENERAL)
			-- Parse `a_version' or set an error
			-- Has to be of format XXX.XXX.XXX.XXX where only the first part is obligatory.
			-- regexp to match it is \d*(\.\d*){0,3}
		require
			a_version_not_void: a_version /= Void
		local
			l_parts: LIST [READABLE_STRING_GENERAL]
			l_version: ARRAY [NATURAL_16]
		do
			create l_version.make_filled ({NATURAL_16}0, 1, 4)
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

	is_two_digit_minimum_minor: BOOLEAN
			-- Is current minor version printed on at least 2 digits?
		obsolete "Use `minimum_length_for_minor` [2017-05-31]"
		do
			Result := minimum_length_for_minor = 2
		end

	minimum_length_for_major: NATURAL_8
			-- Minimum length of current `major` string representation.

	minimum_length_for_minor: NATURAL_8
			-- Minimum length of current `minor` string representation.

	minimum_length_for_release: NATURAL_8
			-- Minimum length of current `release` string representation.

	minimum_length_for_build: NATURAL_8
			-- Minimum length of current `build` string representation.

feature -- Output

	append_major (s: STRING_32)
			-- Append major version part to `s`.
		do
			append_natural_16_to (major, minimum_length_for_major, s)
		end

	append_minor (s: STRING_32)
			-- Append minor version part to `s`.
		do
			append_natural_16_to (minor, minimum_length_for_minor, s)
		end

feature -- Access, stored in configuration file

	major: NATURAL_16
			-- The major version.
			-- Use `append_major` for output.

	minor: NATURAL_16
			-- The minor version.
			-- Use `append_minor` for output.

	release: NATURAL_16
			-- The release version.

	build: NATURAL_16
			-- The build version.

	version: STRING_32
			-- The complete version.
		do
			create Result.make_empty
			append_major (Result)
			Result.append_character ('.')
			append_minor (Result)
			Result.append_character ('.')
			append_natural_16_to (release, minimum_length_for_release, Result)
			Result.append_character ('.')
			append_natural_16_to (build, minimum_length_for_build, Result)
		end

	company: detachable STRING_32
			-- The company.

	product: detachable STRING_32
			-- The product.

	trademark: detachable STRING_32
			-- The trademark.

	copyright: detachable STRING_32
			-- The copyright

feature -- Settings

	set_is_two_digit_mimimum_minor (v: BOOLEAN)
			-- Set `is_two_digit_minimum_minor' to `v'.
		obsolete "Use `set_minimum_length_for_minor` [2017-05-31]"
		do
			if v then
				minimum_length_for_minor := 2
			else
				minimum_length_for_minor := 0
			end
		ensure
			is_two_digit_minimum_minor_set: is_two_digit_minimum_minor = v
		end

	set_minimum_length_for_major (v: NATURAL_8)
			-- Set `minimum_length_for_major' to `v'.
		do
			minimum_length_for_major := v
		ensure
			minimum_length_for_major_length_set: minimum_length_for_major = v
		end

	set_minimum_length_for_minor (v: NATURAL_8)
			-- Set `minimum_length_for_minor' to `v'.
		do
			minimum_length_for_minor := v
		ensure
			minimum_length_for_minor_length_set: minimum_length_for_minor = v
		end

	set_minimum_length_for_release (v: NATURAL_8)
			-- Set `minimum_length_for_release' to `v'.
		do
			minimum_length_for_release := v
		ensure
			minimum_length_for_release_length_set: minimum_length_for_release = v
		end

	set_minimum_length_for_build (v: NATURAL_8)
			-- Set `minimum_length_for_build' to `v'.
		do
			minimum_length_for_build := v
		ensure
			minimum_length_for_build_length_set: minimum_length_for_build = v
		end

feature {CONF_ACCESS}  -- Update, stored in configuration file

	increase_major
			-- Increase `major'.
		do
			major := major + 1
		ensure
			major_greater: old (major) < major
		end

	increase_minor
			-- Increase `minor'.
		do
			minor := minor + 1
		ensure
			minor_greater: old (minor) < minor
		end

	increase_release
			-- Increase `release'.
		do
			release := release + 1
		ensure
			release_greater: old (release) < release
		end

	increase_build
			-- Increase `build'.
		do
			build := build + 1
		ensure
			build_greater: old (build) < build
		end

	set_major (a_major: like major)
			-- Set `major' to `a_major'
		do
			major := a_major
		ensure
			major_set: major = a_major
		end

	set_minor (a_minor: like minor)
			-- Set `minor' to `a_minorr'
		do
			minor := a_minor
		ensure
			minor_set: minor = a_minor
		end

	set_release (a_release: like release)
			-- Set `release' to `a_release'
		do
			release := a_release
		ensure
			release_set: release = a_release
		end

	set_build (a_build: like build)
			-- Set `build' to `a_build'
		do
			build := a_build
		ensure
			build_set: build = a_build
		end

	set_company (a_company: like company)
			-- Set `company' to `a_company'.
		do
			company := a_company
		ensure
			company_set: company = a_company
		end

	set_product (a_product: like product)
			-- Set `producat' to `a_product'.
		do
			product := a_product
		ensure
			product_set: product = a_product
		end

	set_trademark (a_trademark: like trademark)
			-- Set `trademark' to `a_trademark'.
		do
			trademark := a_trademark
		ensure
			trademark_set: trademark = a_trademark
		end

	set_copyright (a_copyright: like copyright)
			-- Set `copyright' to `a_copyright'.
		do
			copyright := a_copyright
		ensure
			copyright_set: copyright = a_copyright
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Compare
		do
			Result := major < other.major or
				(major = other.major and minor < other.minor) or
				(major = other.major and minor = other.minor and release < other.release) or
				(major = other.major and minor = other.minor and release = other.release and build < other.build)
		end

feature -- Output

	text: STRING_32
			-- New string with printable representation.
		local
			l_ext: STRING_32
			s: detachable READABLE_STRING_32
		do
			Result := version

			create l_ext.make_empty
			s := product
			if s /= Void and then not s.is_empty then
				l_ext.append (s)
				l_ext.append_character (' ')
			end
			s := company
			if s /= Void and then not s.is_empty then
				l_ext.append (s)
				l_ext.append_character (' ')
			end

			s := copyright
			if s /= Void and then not s.is_empty then
				l_ext.append ({STRING_32} "(c) ")
				l_ext.append (s)
				l_ext.append_character (' ')
			end

			s := trademark
			if s /= Void and then not s.is_empty then
				l_ext.append ({STRING_32} "(tm) ")
				l_ext.append (s)
				l_ext.append_character (' ')
			end

			if not l_ext.is_empty then
				l_ext.prune_all_trailing (' ')
				Result.append ({STRING_32} " (")
				Result.append (l_ext)
				Result.append_character (')')
			end
		end

feature {NONE} -- Implementation

	append_natural_16_to (v: NATURAL_16; a_min_len: NATURAL_8; a_output: STRING_32)
			-- Append natural 16 value `v` to a_output with a minimum of `a_min_len` digits.
		local
			n: INTEGER
		do
			n := v.out.count
			if n < a_min_len then
				from
					n := a_min_len - n
				until
					n = 0
				loop
					a_output.append_character ('0')
					n := n - 1
				end
			end
			a_output.append_natural_16 (v)
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
