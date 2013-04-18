note
	description: "Summary description for {IRON_LIST_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_LIST_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "list"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_LIST_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_LIST_ARGUMENTS; a_iron: IRON)
		local
			l_packages: detachable LIST [IRON_PACKAGE]
		do
			if a_iron.catalog_api.repositories.is_empty then
				print (m_warning_no_repository)
				print_new_line
			end
			if args.only_installed then
				l_packages := a_iron.installation_api.installed_packages
				if l_packages /= Void and then not l_packages.is_empty then
					print (m_installed_packages)
					print_new_line
					across
						l_packages as p
					loop
						print ("  ")
						print (tk_package)
						print (": ")
						print (p.item.human_identifier)
						print_new_line
					end
				else
					print (m_no_installed_package)
					print_new_line
				end
			else
				if attached a_iron.catalog_api.repositories as l_repositories and then not l_repositories.is_empty then
					print (m_available_packages)
					print_new_line

					across
						l_repositories as c
					loop
						l_packages := c.item.available_packages
						print ("  ")
						if l_packages /= Void and then not l_packages.is_empty then
							print (m_repository (c.item.uri.string, c.item.version))
							print_new_line
							across
								l_packages as p
							loop
								print ("  - ")
								print (tk_package)
								print (": ")
								print (p.item.human_identifier)
								print_new_line

								across
									p.item.associated_paths as cur
								loop
									print ("  # ")
									print (cur.item)
									print_new_line
								end
							end
						else
							print (m_repository_without_package (c.item.uri.string, c.item.version))
							print_new_line
						end
					end
				end
			end
		end

end
