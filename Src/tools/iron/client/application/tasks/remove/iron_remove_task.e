note
	description: "Summary description for {IRON_REMOVE_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REMOVE_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "remove"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_REMOVE_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_REMOVE_ARGUMENTS; a_iron: IRON)
		local
			l_package: detachable IRON_PACKAGE
		do
			across
				args.resources as c
			loop
				print ("Search %"")
				print (c.item)
				print ("%" ... %N")

				l_package := Void
				if c.item.starts_with ("http://") or c.item.starts_with ("https://") then
					-- url
					l_package := a_iron.installation_api.package_associated_with_uri (c.item)
				else
					-- name (or uuid) ?
					if attached a_iron.installation_api.packages_associated_with_name (c.item) as lst and then not lst.is_empty then
						if lst.count = 1 then
							l_package := lst.first
						else
							print ("  -> several packages are named %"")
							print (c.item)
							print ("%": %N")
							if args.is_batch then
								-- FIXME: to implemente .. selection
							else
								across
									lst as p
								loop
									print ("    ")
									print (p.cursor_index.out)
									print (") ")
									print (p.item.human_identifier)
									print (": id %"")
									print (p.item.id)
									print ("%"%N")
								end
							end
						end
					end
					if l_package = Void then
						l_package := a_iron.installation_api.package_associated_with_id (c.item)
					end
				end
				if l_package = Void then
					print ("  -> not found !%N")
				elseif not a_iron.installation_api.is_installed (l_package) then
					print ("  -> not installed !%N")
				else
					print ("Removing %"")
					print (l_package.human_identifier)
					print ("%" from %"")
					print (a_iron.layout.package_installation_path (l_package).name)
					print ("%"%N")

					if args.is_simulation then
						print ("  -> similated ...%N")
					else
						a_iron.catalog_api.uninstall_package (l_package)
						if a_iron.installation_api.is_installed (l_package) then
							print ("  -> failed .%N")
						else
							print ("  -> succeed !%N")
						end

					end
				end
			end
		end

end
