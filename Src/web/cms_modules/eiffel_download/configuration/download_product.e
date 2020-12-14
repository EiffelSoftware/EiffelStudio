note
	description: "Summary description for {DOWNLOAD_PRODUCT}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_PRODUCT

inherit
	COMPARABLE
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			public := True -- Default
		end

feature -- Access

	associated_configuration: detachable DOWNLOAD_CONFIGURATION

	mirror: like default_mirror
		do
			Result := default_mirror
			if Result = Void and attached associated_configuration as cfg then
				Result := cfg.mirror
			end
		end

feature -- Access

	license: detachable TUPLE [name: READABLE_STRING_32; url: READABLE_STRING_32]
			-- Product License

	mirrors: detachable  LIST [READABLE_STRING_8]
			-- Product mirrors

	default_mirror: detachable READABLE_STRING_8
			-- Default mirror

	evaluation: BOOLEAN
			-- Is for evaluation?

	public: BOOLEAN
			-- is public?

	icon: detachable READABLE_STRING_32
			-- Product icon

	sub_directory: detachable READABLE_STRING_32
			-- Product subdirectory.

	date: detachable READABLE_STRING_32
			-- Product date.

	release: detachable READABLE_STRING_32
			-- Product release.

	version: detachable READABLE_STRING_32
			-- Product version

	name: detachable READABLE_STRING_32
			-- Product name.

	id: detachable READABLE_STRING_32
			-- Product id.

	number: detachable READABLE_STRING_32
			-- Number of the version example: 13.11

	build: detachable READABLE_STRING_32
			-- Build description 		

	download_link_pattern: detachable READABLE_STRING_32
			-- Download link pattern.

	downloads: detachable LIST [DOWNLOAD_PRODUCT_OPTIONS]
			-- Possible list of download options.

	downloads_count: INTEGER
		do
			if attached downloads as lst then
				Result := lst.count
			end
		end

feature -- Access

	full_versioned_name: STRING_32
		do
			if attached name as l_name then
				create Result.make_from_string (l_name)
			elseif attached id as l_id then
				create Result.make_from_string (l_id)
			else
				create Result.make_from_string ("product")
			end
			if attached number as n then
				Result.append_character ('-')
				Result.append (n)
			end
			if attached build as l_build then
				Result.append_character ('-')
				Result.append (l_build)
			end
		end

feature -- Element change

	set_associated_configuration (cfg: like associated_configuration)
		do
			associated_configuration := cfg
		end

	set_license (a_license: like license)
			-- Assign `license' with `a_license'.
		do
			license := a_license
		ensure
			license_assigned: license = a_license
		end

	set_mirrors (a_mirrors: READABLE_STRING_8)
			-- Assign `mirrors' with tab separated `a_mirrors'.
		do
			across
				a_mirrors.split ('%T') as ic
			loop
				add_mirror (ic.item)
			end
		end

	add_mirror (a_mirror: READABLE_STRING_8)
		local
			l_mirrors: LIST [READABLE_STRING_8]
		do
			l_mirrors := mirrors
			if l_mirrors = Void then
				create {ARRAYED_LIST [READABLE_STRING_8]} l_mirrors.make (1)
				mirrors := l_mirrors
			end
			l_mirrors.extend (a_mirror)
			if default_mirror = Void then
				default_mirror := a_mirror
			end
		end

	set_evaluation (an_evaluation: like evaluation)
			-- Assign `evaluation' with `an_evaluation'.
		do
			evaluation := an_evaluation
		ensure
			evaluation_assigned: evaluation = an_evaluation
		end

	set_public (a_public: like public)
			-- Assign `public' with `a_public'.
		do
			public := a_public
		ensure
			public_assigned: public = a_public
		end

	set_icon (an_icon: like icon)
			-- Assign `icon' with `an_icon'.
		do
			icon := an_icon
		ensure
			icon_assigned: icon = an_icon
		end

	set_sub_directory (a_sub_directory: like sub_directory)
			-- Assign `sub_directory' with `a_sub_directory'.
		do
			sub_directory := a_sub_directory
		ensure
			sub_directory_assigned: sub_directory = a_sub_directory
		end

	set_date (a_date: like date)
			-- Assign `date' with `a_date'.
		do
			date := a_date
		ensure
			date_assigned: date = a_date
		end

	set_release (a_release: like release)
			-- Assign `release' with `a_release'.
		do
			release := a_release
		ensure
			release_assigned: release = a_release
		end

	set_version (a_version: like version)
			-- Assign `version' with `a_version'.
		do
			version := a_version
		ensure
			version_assigned: version = a_version
		end

	set_name (a_name: like name)
			-- Assign `name' with `a_name'.
		do
			name := a_name
		ensure
			name_assigned: name = a_name
		end

	set_id (an_id: like id)
			-- Assign `id' with `an_id'.
		do
			id := an_id
		ensure
			id_assigned: id = an_id
		end

	set_number (a_number: like number)
			-- Assign `number' with `a_number'.
		do
			number := a_number
		ensure
			number_assigned: number = a_number
		end

	set_build (a_build: like build)
			-- Assign `build' with `a_build'.
		do
			build := a_build
		ensure
			build_assigned: build = a_build
		end

	set_download_link_pattern (p: like download_link_pattern)
		do
			download_link_pattern := p
		end

	set_downloads (a_downloads: like downloads)
		do
			downloads := a_downloads
		end

feature -- Comparision

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := attached number as l_number and then attached other.number as l_other_number and then l_number < l_other_number
		end

end
