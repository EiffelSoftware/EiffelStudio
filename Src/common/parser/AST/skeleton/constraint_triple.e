indexing
	description:
		"[
			Objects that represent a contraint triple structure:
			TE_CONSTRAIN, TYPE_AS, EIFFEL_LIST [FEATURE_NAME]
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTRAINT_TRIPLE

create
	make

feature{NONE} -- Initialization

	make (k_as: SYMBOL_AS; t_as: TYPE_AS; a_list: EIFFEL_LIST [FEATURE_NAME]) is
			-- Create new CONSTRAINT_TRIPLE sturcture.
		do
			constrain_symbol := k_as
			type := t_as
			feature_name_list := a_list
		ensure
			constrain_symbol_set: constrain_symbol = k_as
			type_set: type = t_as
			feature_name_list_set: feature_name_list = a_list
		end

feature -- Access

	constrain_symbol: SYMBOL_AS
			-- Constrain keyword

	type: TYPE_AS

	feature_name_list: EIFFEL_LIST [FEATURE_NAME]

end
