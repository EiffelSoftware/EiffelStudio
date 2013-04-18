note
	description: "Summary description for {IRON_UPDATE_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_UPDATE_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "update"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_UPDATE_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_UPDATE_ARGUMENTS; a_iron: IRON)
		do
			print ("Updating iron data ...%N")
			if args.is_simulation then

			else
				a_iron.catalog_api.update
			end
		end

end
