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
			is_group_equivalent,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_location: like location; a_target: CONF_TARGET) is
			-- Create associated to `a_target'.
		do
			target := a_target
			set_name (a_name)
			set_precompile_location (a_location)
			set_location (a_location)
		end

feature -- Status

	is_precompile: BOOLEAN is
			-- Is this a precompile?
		once
			Result := True
		end

feature -- Access, stored in config file.

	precompile_location: CONF_LOCATION
			-- Location of the precompile.

feature -- Update, stored in config file.

	set_precompile_location (a_location: like precompile_location) is
			-- Set `precompile_location' to `a_location'.
		do
			precompile_location := a_location
		ensure
			precompile_location_set: precompile_location = a_location
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN is
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := Precursor (other) and then equal (precompile_location, other.precompile_location)
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_group (Current)
			a_visitor.process_precompile (Current)
		end

end
