note
	description: "Summary description for {IRON_CATALOG_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_CATALOG_API

inherit
	IRON_API
		redefine
			initialize
		end

create
	make,
	make_with_layout

feature {NONE} -- Initialization

	initialize
		do
			Precursor
			create {IRON_FS_CATALOG} catalog.make (layout)
		end

	catalog: IRON_CATALOG

feature -- Access

	update
		do
			catalog.update
		end

	repositories: LIST [IRON_REPOSITORY]
		do
			Result := catalog.repositories
		end

	register_repository (a_name: READABLE_STRING_8; a_repo: IRON_REPOSITORY)
		do
			catalog.register_repository (a_name, a_repo)
		end

	unregister_repository (a_name_or_uri: READABLE_STRING_GENERAL)
		do
			catalog.unregister_repository (a_name_or_uri)
		end

	available_path_associated_with_uri (a_uri_string: READABLE_STRING_GENERAL): detachable PATH
		local
			iri: IRI
		do
			create iri.make_from_string (a_uri_string)
			Result := catalog.available_path_associated_with_uri (iri.to_uri)
		end

	packages_associated_with_name (a_name: READABLE_STRING_GENERAL): detachable LIST [IRON_PACKAGE]
		do
			Result := catalog.packages_associated_with_name (a_name)
		end

	package_associated_with_uri (a_uri_string: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
		local
			iri: IRI
		do
			create iri.make_from_string (a_uri_string)
			Result := catalog.package_associated_with_uri (iri.to_uri)
		end

	package_associated_with_id (a_id: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
		do
			Result := catalog.package_associated_with_id (a_id)
		end

feature -- Operations

	download_package (a_package: IRON_PACKAGE)
		do
			catalog.download_package (a_package)
		end

	install_package (a_package: IRON_PACKAGE)
		do
			catalog.install_package (a_package)
		end

	uninstall_package (a_package: IRON_PACKAGE)
		do
			catalog.uninstall_package (a_package)
		end


end
