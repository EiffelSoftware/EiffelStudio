note
	description: "Summary description for {IRON_SEARCH_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_SEARCH_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "search"
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
		local
			s,t: READABLE_STRING_32
		do
			across
				args.resources as c
			loop
				print ("Search %"")
				print (c.item)
				print ("%" ...%N")
				if c.item.starts_with ("http://") or c.item.starts_with ("https://") then
					if attached a_iron.installation_api.local_path_associated_with_uri (c.item) as l_path then
						print ("# Installed:%N  ")
						print (l_path.name)
						print ("%N")
					end
					if attached a_iron.catalog_api.available_path_associated_with_uri (c.item) as l_path then
						print ("# Available:%N  ")
						print (l_path.name)
						print ("%N")
					end
				else
					if attached a_iron.installation_api.packages_associated_with_name (c.item) as lst then
						print ("# Installed inside %"")
						s := a_iron.layout.packages_path.name
						print (s)
						print ("%":%N")
						across
							lst as p
						loop
							print (" - ")
--							print (p.item.human_identifier)
							t := a_iron.layout.package_installation_path (p.item).name
							print (t.substring (s.count + 2, t.count))
							print ("%N")
						end
					end
					if attached a_iron.catalog_api.packages_associated_with_name (c.item) as lst then
						print ("# Available:%N")
						across
							lst as p
						loop
							print (" - ")
							print (p.item.human_identifier)
							print ("%N")
						end
					end
				end
				print ("%N")
			end
		end

end
