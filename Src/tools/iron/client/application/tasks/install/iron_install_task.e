note
	description: "Summary description for {IRON_INSTALL_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_INSTALL_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "install"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_INSTALL_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_INSTALL_ARGUMENTS; a_iron: IRON)
		local
			l_package: detachable IRON_PACKAGE
		do
			across
				args.resources as c
			loop
				print (m_searching (c.item))
				print_new_line
				l_package := Void
				if c.item.starts_with ("http://") or c.item.starts_with ("https://") then
					-- url
					l_package := a_iron.catalog_api.package_associated_with_uri (c.item)
				else
					-- name (or uuid) ?
					if attached a_iron.catalog_api.packages_associated_with_name (c.item) as lst and then not lst.is_empty then
						if lst.count = 1 then
							l_package := lst.first
						else
							if args.is_batch then
								print ("  -> ")
								print (m_several_packages_for_name (c.item))
								print_new_line
							else
								across
									lst as p
								loop
									-- Selection ..
									-- FIXME: to implemente
								end
							end
						end
					end
					if l_package = Void then
						l_package := a_iron.catalog_api.package_associated_with_id (c.item)
					end
				end
				if l_package = Void then
					print ("  -> ")
					print (tk_not_found)
					print_new_line
				elseif a_iron.installation_api.is_installed (l_package) then
					print ("  -> ")
					print (tk_already_installed)
					print_new_line
					print ("  [")
					print (a_iron.layout.package_installation_path (l_package).name)
					print ("]%N")
				else
					print (m_installing (l_package.human_identifier))
					print_new_line
					print ("  -> ")
					if args.is_simulation then
						print (tk_simulated)
						print_new_line
					else
						a_iron.catalog_api.install_package (l_package)
						if a_iron.installation_api.is_installed (l_package) then
							print (tk_simulated)
							print_new_line
							print ("  [")
							print (a_iron.layout.package_installation_path (l_package).name)
							print ("]%N")
						else
							print (tk_failed)
							print_new_line
						end
					end
				end
			end
		end

end
