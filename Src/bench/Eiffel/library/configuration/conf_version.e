indexing
	description: "Version number."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_VERSION

inherit
	comparable

create
	make,
	make_version

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

	infix "<" (other: like Current): BOOLEAN is
			-- Compare
		do
			Result := major < other.major or
				(major = other.major and minor < other.minor) or
				(major = other.major and minor = other.minor and release < other.release) or
				(major = other.major and minor = other.minor and release = other.release and build < other.build)
		end

end
