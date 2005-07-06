indexing
	description: "Object being debugged."
	date: "$Date$"
	revision: "$Revision $"

class DEBUGGED_OBJECT_DOTNET

inherit
	DEBUGGED_OBJECT

create
	make

feature

	make (addr: like object_address; sp_lower, sp_upper: INTEGER) is
		do
		end;	

	refresh (sp_lower, sp_upper: INTEGER) is
		do
		end

	attributes: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
		end

end
