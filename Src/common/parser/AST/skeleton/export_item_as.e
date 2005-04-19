class EXPORT_ITEM_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like clients; f: like features) is
			-- Create a new EXPORT_ITEM AST node.
		require
			c_not_void: c /= Void
			f_not_void: f /= Void
		do
			clients := c
			features := f
		ensure
			clients_set: clients = c
			features_set: features = f
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_export_item_as (Current)
		end

feature -- Attributes

	clients: CLIENT_AS
			-- Client list

	features: FEATURE_SET_AS
			-- Feature set

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := clients.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := features.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (clients, other.clients) and
				equivalent (features, other.features)
		end

invariant
	clients_not_void: clients /= Void
	features_not_void: features /= Void

end -- class EXPORT_ITEM_AS
