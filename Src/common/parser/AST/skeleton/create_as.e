class CREATE_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like clients; f: like feature_list) is
			-- Create a new CREATION clause AST node.
		do
			clients := c
			feature_list := f
		ensure
			clients_set: clients = c
			feature_list_set: feature_list = f
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_create_as (Current)
		end

feature -- Attributes

	clients: CLIENT_AS
			-- Client list

	feature_list: EIFFEL_LIST [FEATURE_NAME]
			-- Feature list

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if clients /= Void then
				Result := clients.start_location
			elseif feature_list /= Void then
				Result := feature_list.start_location
			else
				Result := null_location
			end
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if feature_list /= Void then
				Result := feature_list.end_location
			elseif clients /= Void then
				Result := clients.end_location
			else
				Result := null_location
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (clients, other.clients) and
				equivalent (feature_list, other.feature_list)
		end

feature -- Access

	has_feature_name (f: FEATURE_NAME): BOOLEAN is
			-- Is `f' present in current creation?
		local
			cur: CURSOR
		do
			cur := feature_list.cursor
			
			from
				feature_list.start
			until
				feature_list.after or else Result
			loop
				Result := feature_list.item <= f and feature_list.item >= f
				feature_list.forth
			end

			feature_list.go_to (cur)
		end

feature {COMPILER_EXPORTER} -- Convenience

	set_feature_list (f: like feature_list) is
		do
			feature_list := f
		end

	set_clients (c: like clients) is
		do
			clients := c
		end

end -- class CREATE_AS
