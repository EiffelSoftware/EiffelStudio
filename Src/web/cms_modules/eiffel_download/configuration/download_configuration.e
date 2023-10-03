note
	description: "Summary description for {DOWNLOAD_CONFIGURATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_CONFIGURATION

feature -- Access

	hidden: BOOLEAN
			-- Do not list the download entries

	published: BOOLEAN
			-- Is published?

	mirror: detachable READABLE_STRING_8
		-- url mirror.

	products: detachable ARRAYED_LIST [DOWNLOAD_PRODUCT]
		-- Possible list of product downloads.

	sorted_products: detachable LIST [DOWNLOAD_PRODUCT]
		local
			l_sort: QUICK_SORTER [DOWNLOAD_PRODUCT]
			l_comp: COMPARABLE_COMPARATOR [DOWNLOAD_PRODUCT]
		do
			if attached products as l_products then
				Result := l_products
				create l_comp
				create l_sort.make (l_comp)
				l_sort.reverse_sort (Result)
			end
		end

	public_products: detachable ARRAYED_LIST [DOWNLOAD_PRODUCT]
			-- Possible list of public product downloads.
		do
			if attached products as lst then
				create Result.make (lst.count)
				across
					lst as ic
				loop
					if ic.item.public then
						Result.force (ic.item)
					end
				end
				if Result.is_empty then
					Result := Void
				end
			end
		end

	sorted_public_products: detachable LIST [DOWNLOAD_PRODUCT]
		local
			l_sort: QUICK_SORTER [DOWNLOAD_PRODUCT]
			l_comp: COMPARABLE_COMPARATOR [DOWNLOAD_PRODUCT]
		do
			if attached public_products as l_products then
				Result := l_products
				create l_comp
				create l_sort.make (l_comp)
				l_sort.reverse_sort (Result)
			end
		end

feature -- Element Change

	set_hidden (b: BOOLEAN)
		do
			hidden := b
		end

	set_published (b: BOOLEAN)
		do
			published := b
		end

	set_mirror (a_mirror: like mirror)
			-- Set `mirror' with `a_mirror'.
		do
			mirror := a_mirror
		ensure
			mirror_set: mirror = a_mirror
		end

	set_products (a_products: like products)
			-- Possible list of product downloads.			
		do
			products := a_products
		end

	add_product (a_product: DOWNLOAD_PRODUCT)
			-- Add a product 'a_product' to the list of products 'products'.
		local
			l_products: like products
		do
			l_products := products
			if l_products /= Void then
				l_products.put_front (a_product)
			else
				create {ARRAYED_LIST [DOWNLOAD_PRODUCT]} l_products.make (1)
				l_products.put_front (a_product)
			end
			products := l_products
		end

feature -- Access

	first_number: READABLE_STRING_32
		do
			if
				attached products as lst and then
				not lst.is_empty
			then
				Result := lst.first.number
			end
			if Result = Void then
				Result := ""
			end
		end

feature -- Conversion

	to_json_representation: STRING_8
		local
			jo: JSON_OBJECT
			jarr,jmirrors: JSON_ARRAY
			jprod: JSON_OBJECT
			jfiles: JSON_ARRAY
			jdl, jlic: JSON_OBJECT
			prod: DOWNLOAD_PRODUCT
			dl: DOWNLOAD_PRODUCT_OPTIONS
			vis: JSON_PRETTY_STRING_VISITOR
			l_cfg_mirror: READABLE_STRING_GENERAL
		do
			create jo.make_with_capacity (2)

			create Result.make_from_separate ("{%N")
			if hidden then
				jo.put_boolean (True, "hidden")
			end
			if published then
				jo.put_boolean (True, "published")
			else
				jo.put_boolean (False, "published")
			end
			if attached mirror as m then
				l_cfg_mirror := m
				jo.put_string (m, "mirror")
			end
			if attached products as l_products and then not l_products.is_empty then
				create jarr.make (l_products.count)
				across
					l_products as ic
				loop
					prod := ic.item
					create jprod.make_with_capacity (20)
					if attached prod.id as l_id then
						jprod.put_string (l_id, "id")
					end
					if attached prod.name as l_name then
						jprod.put_string (l_name, "name")
					end
					if attached prod.version as l_version then
						jprod.put_string (l_version, "version")
					end
					if attached prod.release as l_release then
						jprod.put_string (l_release, "release")
					end
					if attached prod.date as l_date then
						jprod.put_string (l_date, "date")
					end
					if attached prod.sub_directory as l_sub_directory then
						jprod.put_string (l_sub_directory, "sub_directory")
					end
					if attached prod.number as l_number then
						jprod.put_string (l_number, "number")
					end
					if attached prod.build as l_build then
						jprod.put_string (l_build, "build")
					end
					if attached prod.icon as l_icon then
						jprod.put_string (l_icon, "icon")
					end
					if prod.public then
						jprod.put_boolean (prod.public, "public")
					end
					if prod.evaluation then
						jprod.put_boolean (prod.evaluation, "for_evaluation")
					end
					if attached prod.mirror as l_mirror then
						if l_cfg_mirror /= Void and then l_cfg_mirror.same_string (l_mirror) then
								-- Keep main mirror as info.
						else
							jprod.put_string (l_mirror, "mirror")
						end
					end
					if attached prod.mirrors as l_mirrors then
						if
							l_mirrors.count = 1 and then
							( attached prod.mirror as l_mirror and then l_mirror.same_string_general (l_mirrors.first)
							  or else l_cfg_mirror /= Void and then l_cfg_mirror.same_string (l_mirrors.first)
							)
						then
								-- Ignore
						else
							create jmirrors.make (l_mirrors.count)
							across
								l_mirrors as m_ic
							loop
								jmirrors.extend (create {JSON_STRING}.make_from_string_general (m_ic.item))
							end
							jprod.put (jmirrors, "mirrors")
						end
					end
					if attached prod.license as lic then
						create jlic.make_with_capacity (2)
						jlic.put_string (lic.name, "name")
						jlic.put_string (lic.url, "url")
						jprod.put (jlic, "license")
					end
					if attached prod.download_link_pattern as l_download_link_pattern then
						jprod.put_string (l_download_link_pattern, "download_link_pattern")
					end

					create jfiles.make_empty
					if attached prod.downloads as l_files then
						across
							l_files as dl_ic
						loop
							dl := dl_ic.item
							create jdl.make_empty
							if dl.hidden then
								jdl.put_boolean (True, "hidden")
							end
							if attached dl.platform as l_platform then
								jdl.put_string (l_platform, "platform")
							end
							if attached dl.filename as l_filename then
								jdl.put_string (l_filename, "filename")
							end
							if attached dl.size as l_size then
								jdl.put_string (l_size.out, "size")
							end
							if attached dl.hash as l_hash then
								jdl.put_string (l_hash, "hash")
							end
							if attached dl.link as l_link then
								jdl.put_string (l_link, "link")
							end
							if attached dl.key as l_key then
								jdl.put_string (l_key, "cdkey")
							end
							jfiles.extend (jdl)
						end
					end
					jprod.put (jfiles, "download")
					jarr.extend (jprod)
				end
				jo.put (jarr, "products")
			end
			create Result.make (2048)
			create vis.make_custom (Result, 2, 0)
			vis.visit_json_object (jo)
		end

end
