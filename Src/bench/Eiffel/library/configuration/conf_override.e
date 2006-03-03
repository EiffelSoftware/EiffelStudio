indexing
	description: "Clusters that override other groups."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_OVERRIDE

inherit
	CONF_CLUSTER
		redefine
			process, is_group_equivalent,
			is_override
		end

create
	make

feature -- Status

	is_override: BOOLEAN is
			-- Is this an override?
		once
			Result := True
		end


feature -- Access, stored in configuration file

	override: ARRAYED_LIST [CONF_GROUP]
			-- The groups that this cluster overrides.
			-- override.is_empty => overrides everything

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_override (an_override: like override) is
			-- Set `override' to `an_override'.
		require
			an_override_not_void: an_override /= Void
		do
			override := an_override
		ensure
			override_set: override = an_override
		end

	add_override (a_group: CONF_GROUP) is
			-- Add an override.
		require
			a_group_not_void: a_group /= Void
		do
			if override = Void then
				create override.make (1)
			end
			override.extend (a_group)
		end


feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN is
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := Precursor (other) and then equal_override (override, other.override)
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_group (Current)
			a_visitor.process_override (Current)
		end

feature {NONE} -- Implementation

	equal_override (a, b: like override): BOOLEAN is
			-- Are `a' and `b' equal?
		do
			if a = b then
				Result := True
			end
			if not Result and a /= Void and b /= Void then
				from
					Result := True
					a.start
					b.start
				until
					not Result or a.after or b.after
				loop
					Result := equal (a.item.name, b.item.name)
					a.forth
					b.forth
				end
			end
		end

end
