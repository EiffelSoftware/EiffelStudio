indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Lifetime.LeaseState"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	LEASE_STATE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen initial: LEASE_STATE is
		external
			"IL enum signature :System.Runtime.Remoting.Lifetime.LeaseState use System.Runtime.Remoting.Lifetime.LeaseState"
		alias
			"1"
		end

	frozen null: LEASE_STATE is
		external
			"IL enum signature :System.Runtime.Remoting.Lifetime.LeaseState use System.Runtime.Remoting.Lifetime.LeaseState"
		alias
			"0"
		end

	frozen expired: LEASE_STATE is
		external
			"IL enum signature :System.Runtime.Remoting.Lifetime.LeaseState use System.Runtime.Remoting.Lifetime.LeaseState"
		alias
			"4"
		end

	frozen active: LEASE_STATE is
		external
			"IL enum signature :System.Runtime.Remoting.Lifetime.LeaseState use System.Runtime.Remoting.Lifetime.LeaseState"
		alias
			"2"
		end

	frozen renewing: LEASE_STATE is
		external
			"IL enum signature :System.Runtime.Remoting.Lifetime.LeaseState use System.Runtime.Remoting.Lifetime.LeaseState"
		alias
			"3"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

	from_integer (a_value: INTEGER): like Current is
		do
			--Built-in
		end

	to_integer: INTEGER is
		do
			--Built-in
		end

end -- class LEASE_STATE
