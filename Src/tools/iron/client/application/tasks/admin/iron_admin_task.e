note
	description: "Summary description for {IRON_ADMIN_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_ADMIN_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "admin"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_ADMIN_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_ADMIN_ARGUMENTS; a_iron: IRON)
		do
			print ("Updating iron data ...%N")
			if args.is_simulation then

			else
				a_iron.catalog_api.update
			end
		end

end
