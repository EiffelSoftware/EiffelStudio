note
	description: "[
		Contains basic data about webapp that can be sent over sockets.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_WEBAPP_BEAN

create
	make,
	make_with_config

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_config (create {XC_WEBAPP_CONFIG}.make_empty)
		ensure
			config_attached: app_config /= Void
		end

	make_with_config (a_webapp_config: XC_WEBAPP_CONFIG)
			-- Initialization for `Current'.
		require
			a_webapp_config_attached: a_webapp_config /= Void
		do
			app_config := a_webapp_config
			is_disabled := False
			dev_mode := False
			sessions := 0
		ensure
			config_attached: app_config /= Void
		end

feature -- Access

	app_config: XC_WEBAPP_CONFIG
		-- Contains info about the webapp

	is_disabled: BOOLEAN assign set_is_disabled
		-- Disabled webapps do not translate/compile/run

	is_enabled: BOOLEAN assign set_is_enabled
			-- Enabled webapps do translate/compile/run
		do
			Result := not is_disabled
		end

	is_running: BOOLEAN assign set_is_running
		-- Is running

	is_generating: BOOLEAN assign set_is_generating
		-- Is generating

	is_translating: BOOLEAN assign set_is_translating
		-- Is translating

	is_compiling_webapp: BOOLEAN assign set_is_compiling_webapp
		-- Is compiling webapp

	is_compiling_servlet_gen: BOOLEAN assign set_is_compiling_servlet_gen
		-- Is compiling servlet_gen

	sessions: NATURAL assign set_sessions
		-- How many sessions the webapp is currently serving

	dev_mode: BOOLEAN assign set_dev_mode
			-- In developing mode all webapps are translated and compiled bevore run by the server

feature -- Access

	status: STRING
			-- Returns the status in words
		do
			if is_disabled then
				Result := "Disabled"
			elseif is_translating then
				Result := "Translating"
			elseif is_compiling_webapp then
				Result := "Compiling Webapp"
			elseif is_compiling_servlet_gen then
				Result := "Compiling Servlet_gen"
			elseif is_generating then
				Result := "Generating"
			elseif is_running then
				Result := "Running"
			else
				Result := "Stopped"
			end
		end

feature -- Status report

feature -- Status setting

	set_sessions (a_sessions: NATURAL)
			-- Sets sessions
		do
			sessions := a_sessions
		ensure
			set: equal (sessions, a_sessions)
		end

	set_is_compiling_webapp (a_is_compiling_webapp: like is_compiling_webapp)
			-- Sets is_compiling_webapp.
		require
			a_is_compiling_webapp_attached: a_is_compiling_webapp /= Void
		do
			is_compiling_webapp := a_is_compiling_webapp
		ensure
			is_compiling_webapp_set: equal (is_compiling_webapp, a_is_compiling_webapp)
		end

	set_is_compiling_servlet_gen (a_is_compiling_servlet_gen: like is_compiling_servlet_gen)
			-- Sets is_compiling_servlet_gen.
		require
			a_is_compiling_servlet_gen_attached: a_is_compiling_servlet_gen /= Void
		do
			is_compiling_servlet_gen := a_is_compiling_servlet_gen
		ensure
			is_compiling_servlet_gen_set: equal (is_compiling_servlet_gen, a_is_compiling_servlet_gen)
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

	set_is_enabled (a_is_enabled: BOOLEAN)
		do
			is_disabled := not a_is_enabled
		ensure
			set: equal (is_enabled, a_is_enabled)
		end

	set_dev_mode (a_dev_mode: BOOLEAN)
			-- Sets dev_mode
		do
			dev_mode := a_dev_mode
		ensure
			set: equal (dev_mode, a_dev_mode)
		end

	set_is_generating (a_is_generating: like is_generating)
			-- Sets is_generating.
		require
			a_is_generating_attached: a_is_generating /= Void
		do
			is_generating := a_is_generating
		ensure
			is_generating_set: equal (is_generating, a_is_generating)
		end

feature -- Basic operations

	copy_from_bean : XC_WEBAPP_BEAN
			-- Creates a copy of an other webapp bean
		do
			create Result.make_with_config (current.app_config)
			Result.is_compiling_webapp := current.is_compiling_webapp
			Result.is_compiling_servlet_gen := current.is_compiling_servlet_gen
			Result.is_generating := current.is_generating
			Result.is_disabled := current.is_disabled
			Result.is_running := current.is_running
			Result.is_translating := current.is_translating
			Result.dev_mode := current.dev_mode
			Result.sessions := current.sessions
		ensure
			result_attached: Result /= Void
		end

invariant
	config_attached: app_config /= Void
end

