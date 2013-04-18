note
	description: "Summary description for {IRON_TESTING_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_TESTING_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "testing"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			lst: ARRAYED_LIST [IRON_PACKAGE]
			lst_to_uninstall: ARRAYED_LIST [IRON_PACKAGE]
			l_uri: URI
		do
			create lst.make (5)
			create lst_to_uninstall.make (5)

			print ("= Testing =%N")
			print ("== Update catalog ==%N")
			a_iron.catalog_api.update

			print ("== available repositories ==%N")
			across
				a_iron.catalog_api.repositories as c
			loop
				print ("  Repository [" + c.item.uri.string + c.item.version + ")%N")
				display_packages (Void, c.item)
				across
					c.item as p
				loop
					lst.force (p.item)
--					print ("  - package [" + p.item.human_identifier + "]%N")
				end
			end

			display_installed_packages (a_iron)
			across
				a_iron.installation_api.installed_packages as p
			loop
				lst_to_uninstall.force (p.item)
			end

			print ("== Operations ==%N")

			if not lst_to_uninstall.is_empty then
				across
					lst_to_uninstall as p
				loop
					print ("* Uninstall ["+ p.item.human_identifier +"] ==%N")
					a_iron.catalog_api.uninstall_package (p.item)
				end
			end
			if not lst.is_empty then
				across
					lst as p
				loop
					print ("* Download ["+ p.item.human_identifier +"] ==%N")
					a_iron.catalog_api.download_package (p.item)
				end
			end
			if not lst.is_empty then
				across
					lst as p
				loop
					print ("* Install ["+ p.item.human_identifier +"] ==%N")
					a_iron.catalog_api.install_package (p.item)
				end
			end

			create l_uri.make_from_string ("http://localhost:9090/7.3/eiffel.com/library/preferences/xml_pref-safe.ecf")
			print ("* Path associated with "+ l_uri.string +" ?%N")

			if attached a_iron.installation_api.local_path_associated_with_uri (l_uri.string) as l_path then
				print ("  -> Installed: " + l_path.name + "%N")
			elseif attached a_iron.catalog_api.available_path_associated_with_uri (l_uri.string) as l_path then
				print ("  -> Available: " + l_path.name + "%N")
			else
				print ("  -> Not found%N")
			end
		end

	display_installed_packages (a_iron: IRON)
		do
			display_packages ("== Installed packages ==", a_iron.installation_api.installed_packages)
		end

	display_packages (a_title: detachable READABLE_STRING_8; lst: ITERABLE [IRON_PACKAGE])
		do
			if a_title /= Void then
				print (a_title)
				print ("%N")
			end
			across
				lst as c
			loop
				print ("  - package [" + c.item.human_identifier + "]")
				print ("%N")
				across
					c.item.associated_paths as cur
				loop
					print ("%T"+ c.item.repository.url + cur.item +"%N")
				end
			end
		end

end
