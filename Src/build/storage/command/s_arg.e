indexing
	description: "Used to store a formal argument (formal %
				% part of aan ARG_INSTANCE object)."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class S_ARG 

inherit

	SHARED_STORAGE_INFO

creation

	make
	
feature 

	make (arg: ARG) is
		do
			type := arg.type.identifier;
			if not (arg.parent_type = Void) then
				parent_type := arg.parent_type.identifier
			end;
		end;

	argument: ARG is
		do
			!! Result.storage_init (context_type_table.item (type))
			if parent_type > 0 then
				Result.set_parent (command_table.item (parent_type))
			elseif parent_type < 0 then
				Result.set_parent (predefined_command_table.item (- parent_type))
			end;
		end;

	
feature {NONE}

	type: INTEGER;

	parent_type: INTEGER;

end

