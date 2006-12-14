indexing
	description: "Identifies a given locale and optionally it's script (sometimes a locale has multiple scripts)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_LOCALE_ID

inherit
	ANY
		redefine
			is_equal
		end
	HASHABLE
		undefine
			is_equal
		end

create
	make,
	make_from_string

feature -- Creation

	make (a_language, a_region, a_script: STRING_32) is
			-- a_script is an optional parameter and normally should be void (excellent design)
		require
			language_not_void: a_language /= Void
			region_not_void: a_region /= Void
		do
			create language.make_from_string(a_language)
			create region.make_from_string(a_region)
			if a_script /= Void then
				create script.make_from_string(a_script)
			end
			set_name
		ensure
			language_set: language.is_equal(a_language)
			region_set: region.is_equal(a_region)
			script_set: (script /= Void) implies script.is_equal(a_script)
		end

	make_from_string (identifier: STRING_32) is
			-- Initialize with data in `identifier'
		require
			identifier_not_void: identifier /= Void
		local
			temp: STRING_32
			index: INTEGER
			-- script, region, language: STRING_32
			splits: LIST[STRING_32]
		do
				-- There are several ways this identifier could look
				-- Case 1: LL-RR
				-- Case 2: LL-SS-RR
				-- Case 3: LL_RR
				-- Case 4: LL_RR.Enc
				-- Case 5: LL_RR@SS  [sometimes the SS is simply variant information]
				-- LL is a two-letter language identifier from ISO 639-1 or, if there is none, a three-letter
				-- identifier from ISO 639-2/T
				-- RR is a two-letter country coding from ISO 3166-1, except when it is not (en-029 ('English (Carribean)') under Windows)
				-- SS under windows is mostly either 'Latn' or 'Cyrl'. @SS on linux is sometimes useful and sometimes meaningless
				--  ('@euro' variants seem to have no difference)

				-- first throw away everything after and with a dot
			create temp.make_from_string(identifier)
			index :=  temp.index_of ('.', 1)
			if index > 0 then
				temp.keep_head(index-1)
			end
				-- remove @ and keep SS if there
			index := temp.index_of ('@',1)
			if index > 0 then
					-- split at first @, store in script, throw away if it is "euro"
				script := temp.substring(index+1, temp.count)
--				if script.is_equal("euro") then		-- @euro -> not currency_symbol.is_equal ("EUR")
--					script := Void
--				end
				temp.keep_head(index-1)
			end
				-- So - do we have case 1,2 or 3 now?
				-- check if we have dashes or underscores
			index := temp.index_of('_',1)
			if index > 0 then
					-- Case 3
				language := temp.substring(1, index-1)
				region := temp.substring(index+1, temp.count)
			else
				splits := temp.split('-')
				inspect splits.count
				when 2  then
					language := splits.i_th(1)
					region := splits.i_th(2)
				when 3 then
					language := splits.i_th(1)
					script := splits.i_th(2)
					region := splits.i_th(3)
				else
					language := ""
					region := ""
				end
			end
			set_name
		ensure
			language_set: language /= Void
			region_set: region /= Void
		end

feature {NONE} -- Helper function

	set_name is
			-- ensure platform-independant name
		do
			name := language+"_"+region
			if script /= Void then
				name.append("@"+script)
			end
		ensure
			name_not_void: name /= Void
		end



feature  -- Informations

	language:STRING_32
	region: STRING_32
	script: STRING_32

feature	 -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- is `other' equal `Current'
		do
			Result := language.is_equal (other.language) and region.is_equal(other.region) and
						( (script /= Void and other.script /= Void) implies script.is_equal(other.script))
		end

 feature -- Hashing

 	hash_code: INTEGER is
 		do
 			Result := name.hash_code
 		end

 feature  -- Name for hashing

	name: STRING_32


 feature -- Conversion

 	language_id: I18N_LANGUAGE_ID is
 			-- Get corresponding language id
 		do
 			create Result.make(language)
 		end

invariant
	language_exists: language /= Void
	region_exists: region /= Void

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
