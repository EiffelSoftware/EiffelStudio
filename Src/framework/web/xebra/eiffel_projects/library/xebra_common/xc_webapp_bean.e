note
	description: "[
		Contains basic data about webapp that can be sent over sockets.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_WEBAPP_BEAN

create
	make

feature {NONE} -- Initialization

	make (a_webapp_config: XC_WEBAPP_CONFIG)
			-- Initialization for `Current'.
		require
			a_webapp_config_attached: a_webapp_config /= Void
		do
			app_config := a_webapp_config
			is_disabled := false
		ensure
			config_attached: app_config /= Void
		end

feature -- Access

	app_config: XC_WEBAPP_CONFIG
		-- Contains info about the webapp

	is_disabled: BOOLEAN assign set_is_disabled
		-- Disabled webapps do not translate/compile/run

	is_running: BOOLEAN assign set_is_running
		-- Is running

	is_translating: BOOLEAN assign set_is_translating
		-- Is translating

	is_compiling: BOOLEAN assign set_is_compiling
		-- Is compiling


feature -- Access

	status: STRING
			-- Returns the status in words
		do
			if is_disabled then
				Result := "Disabled"
			elseif is_translating then
				Result := "Translating"
			elseif is_compiling then
				Result := "Compiling"
			elseif is_running then
				Result := "Running"
			else
				Result := "Stopped"
			end
		end


feature -- Status report

feature -- Status setting

	set_is_compiling (a_is_compiling: BOOLEAN)
			-- Sets is_compiling
		do
			is_compiling := a_is_compiling
		ensure
			set: equal (is_compiling, a_is_compiling)
		end

	set_is_running (a_is_running: BOOLEAN)
			-- Sets is_running
		do
			is_running := a_is_running
		ensure
			set: equal (is_running, a_is_running)
		end

	set_is_translating (a_is_translating: BOOLEAN)
			-- Sets is_translating
		do
			is_translating := a_is_translating
		ensure
			set: equal (is_translating, a_is_translating)
		end


	set_is_disabled (a_is_disabled: BOOLEAN)
			-- Sets is_disabled
		do
			is_disabled := a_is_disabled
		ensure
			set: equal (is_disabled, a_is_disabled)
		end

feature -- Basic operations

	copy_from_bean : XC_WEBAPP_BEAN
			-- Creates a copy of an other webapp bean
		do
			create Result.make (current.app_config)

			Result.is_compiling := current.is_compiling
			Result.is_disabled := current.is_disabled
			Result.is_running := current.is_running
			Result.is_translating := current.is_translating
		ensure
			result_attached: Result /= Void
		end


feature {NONE} -- Implementation

invariant
	config_attached: app_config /= Void
end

