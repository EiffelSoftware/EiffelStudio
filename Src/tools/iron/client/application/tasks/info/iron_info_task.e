note
	description: "Summary description for {IRON_INFO_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_INFO_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "info"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_SEARCH_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_SEARCH_ARGUMENTS; a_iron: IRON)
		do
			across
				args.resources as c
			loop
				print (m_title_information_for (c.item))
				print_new_line
				if c.item.starts_with ("http://") or c.item.starts_with ("https://") then
					if attached a_iron.catalog_api.package_associated_with_uri (c.item) as l_package then
						display_information (l_package, args, a_iron)
					end
				else
					if attached a_iron.catalog_api.packages_associated_with_name (c.item) as lst then
						across
							lst as p
						loop
							display_information (p.item, args, a_iron)
						end
					end
				end
				print ("%N")
			end
		end

	display_information (a_package: IRON_PACKAGE; args: IRON_ARGUMENTS; a_iron: IRON)
		do
			print (m_information_for (a_package.human_identifier, a_package.id, a_package.repository.url))
			print_new_line
			if a_iron.installation_api.is_installed (a_package) then
				print (" ")
				print (tk_installation)
				print ("=")
				print (a_iron.layout.package_installation_path (a_package).name)
				print_new_line
			end
			if attached a_package.associated_paths as l_paths and then not l_paths.is_empty then
				print (" ")
				print (tk_associated_paths)
				print (":")
				print_new_line
				across
					l_paths as c
				loop
					print ("   - ");
					print (a_package.repository.url)
					print (c.item); print ("%N")
				end
			end
			if attached a_package.items as l_items then
				across
					l_items as c
				loop
					if c.key.starts_with ("_") then
						-- ignored
						if args.verbose then
							print (" ")
							print (c.key)
							print ("=")
							print (c.item);
							print ("%N")
						end
					else
						print (" ")
						print (c.key)
						print ("=")
						print (c.item);
						print ("%N")
					end
				end
			end
		end

end
