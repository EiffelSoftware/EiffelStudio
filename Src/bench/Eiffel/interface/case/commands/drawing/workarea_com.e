indexing

	description: 
		"Root ancestor of all callbacks used in workareas.";
	date: "$Date$";
	revision: "$Revision $"

deferred class WORKAREA_COM

inherit

	SON_COM
		rename
			parent_object as workarea
		redefine
			workarea
		end

feature {NONE} -- Properties

	workarea: WORKAREA
			-- Associated workarea

end -- class WORKAREA_COM
