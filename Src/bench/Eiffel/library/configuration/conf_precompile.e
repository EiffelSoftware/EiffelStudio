indexing
	description: "Precompiles are almost the same as libraries, except that on the first build they load the date as initial point for the incremental compilation"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_PRECOMPILE

inherit
	CONF_LIBRARY
		redefine
			is_precompile,
			process,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_location: like location; a_target: CONF_TARGET) is
			-- Create associated to `a_target'.
		do
			target := a_target
			is_valid := True
			set_name (a_name)
			set_location (a_location)
		end

feature -- Status

	is_precompile: BOOLEAN is
			-- Is this a precompile?
		once
			Result := True
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_group (Current)
			a_visitor.process_precompile (Current)
		end

end
