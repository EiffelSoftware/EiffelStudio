note
	description: "Removes all agent criteria from a composite criterion tree."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_AGENT_CRITERION_ELIMINATOR_PLUGIN

inherit
	PS_PLUGIN

feature

	before_write (object: PS_BACKEND_OBJECT; transaction: PS_INTERNAL_TRANSACTION)
		do
		end

	before_retrieve (args: TUPLE[type: PS_TYPE_METADATA; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]]; transaction: PS_INTERNAL_TRANSACTION): like args
		local
			eliminator: PS_AGENT_CRITERION_ELIMINATOR
--			printer: PS_CRITERION_PRINTER
		do
			if attached args.criterion as crit then
				create eliminator
--				create printer
--				print ("Before:%N%T" + printer.visit (crit) + "%N")
				Result := [args.type, eliminator.visit(crit), args.attributes]
--				print ("After:%N%T" + printer.visit (eliminator.visit(crit)) + "%N")
			else
				Result := args
			end
		end

	after_retrieve (object: PS_BACKEND_OBJECT; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction:PS_INTERNAL_TRANSACTION)
		do
		end

end
