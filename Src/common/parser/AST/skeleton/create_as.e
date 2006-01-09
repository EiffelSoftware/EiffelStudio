class CREATE_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like clients; f: like feature_list; c_as: like create_creation_keyword) is
			-- Create a new CREATION clause AST node.
		do
			clients := c
			feature_list := f
			create_creation_keyword := c_as
		ensure
			clients_set: clients = c
			feature_list_set: feature_list = f
			create_creation_keyword_set: create_creation_keyword = c_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_create_as (Current)
		end

feature -- Roundtrip

	create_creation_keyword: KEYWORD_AS
			-- Keyword "create" or "creation" associated with this structure

feature -- Attributes

	clients: CLIENT_AS
			-- Client list

	feature_list: EIFFEL_LIST [FEATURE_NAME]
			-- Feature list

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if clients /= Void then
					Result := clients.complete_start_location (a_list)
				elseif feature_list /= Void then
					Result := feature_list.complete_start_location (a_list)
				else
					Result := null_location
				end
			else
				Result := create_creation_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if feature_list /= Void then
				Result := feature_list.complete_end_location (a_list)
			elseif clients /= Void then
				Result := clients.complete_end_location (a_list)
			elseif a_list = Void then
					-- Non-roundtrip mode
				Result := null_location
			else
					-- Roundtrip mode
				Result := create_creation_keyword.complete_end_location (a_list)
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
