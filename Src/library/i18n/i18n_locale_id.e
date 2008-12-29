note
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

feature {NONE} -- Initialization

	make (a_language, a_region, a_script: STRING_32)
			-- Initialize locale id.
			--
			-- `a_language': Language of locale, e.g. 'en'
			-- `a_region': Region of locale, e.g. 'us'
			-- `a_script': An optional parameter for the locale, e.g. 'Latn' for latin script
		require
			language_not_void: a_language /= Void
			region_not_void: a_region /= Void
		do
			create language.make_from_string (a_language)
			create region.make_from_string (a_region)
			if a_script /= Void then
				create script.make_from_string (a_script)
			end
			set_name
		ensure
			language_set: language.is_equal (a_language)
			region_set: region.is_equal (a_region)
			script_set: script /= Void implies script.is_equal (a_script)
		end

	make_from_string (identifier: STRING_32)
			-- Initialize locale id with identifier.
			--
			-- There are several ways this identifier could look
			-- Case 1: LL-RR
			-- Case 2: LL-SS-RR
			-- Case 3: LL_RR
			-- Case 4: LL_RR.Enc
			-- Case 5: LL_RR@SS  [sometimes the SS is simply variant information]
			-- Case 6: LL_RR.Enc@SS
			-- LL is a two-letter language identifier from ISO 639-1 or, if there is none, a three-letter
			-- identifier from ISO 639-2/T
			-- RR is a two-letter country coding from ISO 3166-1, except when it is not (en-029 ('English (Carribean)') under Windows)
			-- SS under windows is mostly either 'Latn' or 'Cyrl'. @SS on linux is sometimes useful and sometimes meaningless
			--  ('@euro' variants seem to have no difference)
			-- Enc is ignored
			--
			-- `identifier': An identifier in one of the recognised formats
		require
			identifier_not_void: identifier /= Void
		local
			temp: STRING_32
			index: INTEGER
			splits: LIST [STRING_32]
		do
			create temp.make_from_string(identifier)
				-- remove @ and keep SS if there
			index := temp.index_of ('@',1)
			if index > 0 then
					-- split at first @, store in script, throw away if it is "euro"
				script := temp.substring(index+1, temp.count)
--				if script.is_equal("euro") then		-- @euro -> not currency_symbol.is_equal ("EUR")
--					script := Void
--				end
				temp.keep_head (index-1)
			end

				-- Keep Enc, and remove dot and anything after dot.
			index :=  temp.index_of ('.', 1)
			if index > 0 then
				encoding := temp.substring(index+1, temp.count)
				temp.keep_head (index-1)
			end

				-- So - do we have case 1,2 or 3 now?
				-- check if we have dashes or underscores
			index := temp.index_of ('_',1)
			if index > 0 then
					-- Case 3
				language := temp.substring (1, index-1)
				region := temp.substring (index+1, temp.count)
			else
				splits := temp.split('-')
				inspect splits.count
				when 1 then
					language := splits.i_th (1)
					region := ""
				when 2  then
					language := splits.i_th (1)
					region := splits.i_th (2)
				when 3 then
					language := splits.i_th (1)
					script := splits.i_th (2)
					region := splits.i_th (3)
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

feature  -- Access

	name: STRING_32
			-- Full locale id of the form LL_RR@SS
			-- where LL is language code,
			-- RR is region code and
			-- SS is optional script

	full_name: STRING_32
			-- `name' plus encoding

	language: STRING_32
			-- Language of locale id

	region: STRING_32
			-- Region of locale id

	script: STRING_32
			-- Script of locale id (optional)

 	language_id: I18N_LANGUAGE_ID
 			-- Language ID corresponding to current locale id
 		do
 			create Result.make (language)
 		ensure
 			language_id_not_void: Result /= Void
 		end

 	hash_code: INTEGER
 			-- Hash code value
 		do
 			Result := name.hash_code
 		end

feature	 -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := language.is_equal (other.language) and
						region.is_equal (other.region) and
						equal (script, other.script)
		end

feature {NONE} -- Implementation

	encoding: STRING_32
			-- Encoding of locale id (optional)

	set_name
			-- Set `name' to a platform independent name.
		require
			language_not_void: language /= Void
			region_not_void: region /= Void
		do
			name := language.twin
			full_name := language.twin
			if not region.is_empty then
				name.append ("_"+region)
				full_name.append ("_"+region)
			end
			if encoding /= Void then
				full_name.append ("."+encoding)
			end
			if script /= Void then
				name.append("@"+script)
				full_name.append("@"+script)
			end
		ensure
			name_not_void: name /= Void
			name_not_void: full_name /= Void
		end

invariant

	name_not_void: name /= Void
	name_not_void: full_name /= Void
	language_not_void: language /= Void
	region_not_void: region /= Void

note
	library:   "Internationalization library"
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
