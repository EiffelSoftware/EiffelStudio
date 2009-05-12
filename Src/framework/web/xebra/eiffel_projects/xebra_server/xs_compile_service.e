note
	description: "Summary description for {XS_COMPILE_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XS_COMPILE_SERVICE

inherit
	XU_SHARED_OUTPUTTER


create
	make

--feature {NONE} -- Initialization

--	make (a_server_config: XS_CONFIG)
--			-- Initialization for `Current'.
--		do
--			server_config := a_server_config
--		ensure
--			server_config_set: server_config = a_server_config
--		end

--feature -- Access

--	server_config: XS_CONFIG

--feature -- Operations


--	can_compile (a_name: STRING): BOOLEAN
--			-- Returns true if there is a compiler available
--		require
--			webapp_exists: exists (a_name)
--		do
--			Result := False
--			if attached {XS_WEBAPP} server_config.webapps[a_name] as webapp then
--				Result := webapp.can_compile
--			end
--		end

--	can_run (a_name: STRING): BOOLEAN
--			-- Returns true if there is a webapplication available
--		require
--			webapp_exists: exists (a_name)
--		do
--			Result := False
--			if attached {XS_WEBAPP} server_config.webapps[a_name] as webapp then
--				Result := webapp.can_run
--			end
--		end


--	compile (a_name: STRING): BOOLEAN
--			-- Returns true if the webapp is compiled
--			-- Initiates compiling the webapp if its not compiled
--		require
--			webapp_exists: exists (a_name)
--		do
--			Result := False
--			if attached {XS_WEBAPP} server_config.webapps[a_name] as webapp then
--				Result := webapp.compile
--			end
--		end


--	run (a_name: STRING): BOOLEAN
--			-- Returns true if the webapp is running
--			-- Initiates launching the webapp if its not running
--		require
--			webapp_exists: exists (a_name)
--		do
--			Result := False
--			if attached {XS_WEBAPP} server_config.webapps[a_name] as webapp then
--				Result := webapp.run
--			end
--		end

--feature -- Status

--	exists (a_name: STRING): BOOLEAN
--			-- Checks if the webapps exists in the configuration
--		do
--			Result := attached {XS_WEBAPP} server_config.webapps[a_name]
--		end

----	is_launch_failed (a_name: STRING): BOOLEAN
----			-- Checks if a webapp has failed to launch
----		require
----			webapp_exists: exists (a_name)
----		do
----			Result := False
----			if attached {XS_WEBAPP} server_config.webapps[a_name] as webapp then
----				Result := webapp.is_launch_failed
----			end
----		end

----	is_compiling_failed (a_name: STRING): BOOLEAN
----			-- Checks if a webapp has failed to compile
----		require
----			webapp_exists: exists (a_name)
----		do
----			Result := False
----			if attached {XS_WEBAPP} server_config.webapps[a_name] as webapp then
----				Result := webapp.is_compiling_failed
----			end
----		end

--feature -- Element change


end
