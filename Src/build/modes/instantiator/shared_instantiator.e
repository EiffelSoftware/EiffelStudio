indexing
	description: "Class containing a COMMAND_INSTANTIATOR used %
				% either to instanciated commands or to generate %
				% the code for COMMAND_INSTANTIATOR."
	id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_INSTANTIATOR

feature

	command_instantiator: COMMAND_INSTANTIATOR is
		once
			!! Result.make
		end

end -- class SHARED_INSTANTIATOR
