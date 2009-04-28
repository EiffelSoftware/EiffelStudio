note
	description: "Summary description for {XS_COMPILE_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XS_COMPILE_SERVICE

inherit
	XU_DEBUG_OUTPUTTER
	XU_ERROR_OUTPUTTER

create
	make

feature {NONE} -- Initialization

	make (a_webapps: HASH_TABLE [XS_WEBAPP, STRING])
			-- Initialization for `Current'.
		do
			webapps := a_webapps
		ensure
			webapps_set: webapps = a_webapps
		end

feature --

	webapps: HASH_TABLE [XS_WEBAPP, STRING]


feature -- Status setting

	compile (a_name: STRING): BOOLEAN
			-- Makes sure the webapp is compiled
			-- Returns false if it could not be compiled
		do
			dprint ("'XS_COMPILE_SERVICE.compile' not implemented, assuming '" + a_name + "' is compiled!",1)
--			if attached {XS_WEBAPP} webapps[a_name] as webapp then
--				dprint ("webapp was found!",3)

--				if webapp.is_running then
--					eprint ("cannot recompile running webapp")
--				end
--			end


--			dprint ("Checking if webapp exists..",3)
--			eprint ("not found")

--			dprint ("Has to be recompiled.",3)

--			dprint ("Compiling...",3)
--			eprint ("could not compile")

			Result := True

		end


	run (a_name: STRING): BOOLEAN
			-- Makes sure the webapp is running
			-- Returns False if it could not be run
		do
			dprint ("'XS_COMPILE_SERVICE.run' not implemented, assuming '" + a_name + "' is running",1)
--			if attached {XS_WEBAPP} webapps[a_name] as webapp then
--				dprint ("webapp was found!",3)
--			end


--			dprint ("Checking if webapp exists..",3)
--			eprint ("not found")

--			dprint ("Has to be launched.",3)

--			dprint ("Launching...",3)
--			eprint ("could not run!!!!")

			Result := True

		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
