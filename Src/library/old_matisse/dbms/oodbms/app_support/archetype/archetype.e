indexing
	description: "ARCHETYPE provides a framework of objects containing meta-level %
                    %information, or what is sometime called %"knowledge-level%" %
                    %information (cf operational-level information; see Martin %
                    %Fowler's %"Analysis Patterns%" for tese terms. Essentially %
                    %the archetype encodes configuration parameters for %
                    %operational objects, and is itself either programmed or %
                    %generated from configuration files (GUI config app is another %
                    %possibility). %
                    % %
                    %The ARCH_DEFINITION class provides a place for application %
                    %or database specific archetype parameters to be coded."
	keywords:    "archetype, meta-objects, knowledge, configuration"
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"

class ARCHETYPE

inherit
	APP_ENVIRONMENT

	SHARED_ODB_ACCESS

	ERROR_STATUS
	    rename
	        fail_reason as invalid_reason,
	        append_fail_reason as append_invalid_reason
	    end

creation
	make

feature -- Initialisation
	make is
		do
			-- make the specific definitions list
			!!arch_defs.make
		end

feature {CLIENT_APPLICATION} -- Archetype
	initialise is
		do
			-- set up reverse links back to arch definitions
			from arch_defs.start until arch_defs.off loop
				arch_defs.item.set_archetype(Current)
				arch_defs.forth
			end

			-- create the prototype objects
			!!rep_items.make(0)
			from arch_defs.start until arch_defs.off loop
				arch_defs.item.create_prototypes
				arch_defs.forth
			end

			-- initialise the archetype unit chains
			init_units

			-- read the bus_obj.cfg file
			init_bus_obj_config

			-- read subtype connections from database schemas into archetype units
			init_subtypes

			-- do specific initialisations
			from arch_defs.start until arch_defs.off loop
				arch_defs.item.init_structures
				arch_defs.forth
			end
		end

        is_valid:BOOLEAN is
	       do
			Result := is_basic_valid

			from arch_defs.start until not Result or arch_defs.off loop
				Result := Result and arch_defs.item.is_valid
				if not Result then
					invalid_reason.append(arch_defs.item.invalid_reason)
				end
				arch_defs.forth
			end
	       ensure
			Reason_given: not Result implies invalid_reason /= Void and then not invalid_reason.empty
	       end

	add_arch_def(an_arch_def:ARCH_DEFINITION) is
		require
			Valid_arch_def: an_arch_def /= Void
		do
			arch_defs.extend(an_arch_def)
		end


feature -- Access
	create_by_type(a_type:STRING): REP_ITEM is
		require
			Args_not_void: a_type /= Void
			has_type: has_type(a_type)
		local
			arch_unit_csr: ARCH_REP_UNIT
			type_str:STRING
		do
			type_str := clone(a_type)
			type_str.to_upper

			arch_unit_csr := rep_units_by_type.item(type_str)
			if arch_unit_csr /= Void then
				Result := arch_unit_csr.create_item
			end
		ensure
			Result_exists: Result /= Void
		end

	has_type(a_type:STRING):BOOLEAN is
		local
			type_str:STRING
		do
			type_str := clone(a_type)
			type_str.to_upper
			Result := rep_units_by_type /= Void and then rep_units_by_type.has(type_str)
		end

	bus_obj_desc(a_type:STRING): BUS_OBJ_DESC is
		require
			Has_type: has_type(a_type)
		local
			type_str:STRING
		do
			type_str := clone(a_type)
			type_str.to_upper
			Result := rep_units_by_type.item(type_str).bus_obj_desc
		ensure
			Result /= Void
		end

	unit(a_type:STRING):ARCH_REP_UNIT is
	    obsolete
	    	"Use rep_unit or db_unit instead"
	    do
		Result := rep_unit(a_type)
	    end

	rep_unit(a_type:STRING):ARCH_REP_UNIT is
		require
			Has_type: has_type(a_type)
		local
			type_str:STRING
		do
			type_str := clone(a_type)
			type_str.to_upper
			Result := rep_units_by_type.item(type_str)
		ensure
			Result /= Void
		end

	info_unit(a_type:STRING):ARCH_INFO_UNIT is
		require
			Has_type: has_type(a_type)
		local
			type_str:STRING
		do
			type_str := clone(a_type)
			type_str.to_upper
			Result ?= rep_units_by_type.item(type_str)
		ensure
	 		Result /= Void
		end

feature -- Iteration
        rep_units_start is
            do
                rep_units_by_type.start
            end

        rep_units_off:BOOLEAN is
            do
                Result := rep_units_by_type.off
            end

        rep_units_forth is
            do
                rep_units_by_type.forth
            end

        rep_units_item:ARCH_REP_UNIT is
                -- archetype unit at iteration position
            do
                Result := rep_units_by_type.item_for_iteration
            end

        rep_units_bo_desc:BUS_OBJ_DESC is
                -- business object descriptor of archetype unit at iteration position
            do
                Result := rep_units_by_type.item_for_iteration.bus_obj_desc
            end

        rep_units_key:STRING is
                -- name of class to which rep_units_item corresponds
            do
                Result := rep_units_by_type.key_for_iteration
            end

feature -- Status
        is_basic_valid:BOOLEAN is
			-- check basic validity
		do
			Result := True

			-- check that business object descriptors were read for every arch_unit
			if rep_units_by_type /= Void and then not rep_units_by_type.empty then
				from rep_units_start until rep_units_off loop
					if rep_units_bo_desc = Void then
						Result := False
						append_invalid_reason("No business object descriptor for ")
						append_invalid_reason(rep_units_item.description)
						append_invalid_reason("; ")
					end
					rep_units_forth
				end
			else
				Result := False
				append_invalid_reason("rep_units_by_type not built; ")
			end
	       end

feature {ARCH_DEFINITION} -- Structure
	rep_items:ARRAYED_LIST[REP_ITEM]

feature {NONE} -- Implementation
	arch_defs:LINKED_LIST[ARCH_DEFINITION]

	rep_units_by_type:HASH_TABLE[ARCH_REP_UNIT,STRING]

	bus_obj_file_cmt_char:CHARACTER is ';'

	init_bus_obj_config is
			-- initialise archetype units from bus_obj.cfg file
			-- FIXME: the file reading function should be generalised to a precursor of CONFIG_FILE_ACCESS, and
			-- simply used from here.
		local
			msg, path, file_name:STRING
			cfg_file:RAW_FILE
			linebuf:STRING
			pos:INTEGER
			a_desc: BUS_OBJ_DESC
			a_rep_unit:ARCH_REP_UNIT
			file:RAW_FILE
		once
			file_name := app_resource_value("business object", "config_file")

			if file_name.empty then
				!!msg.make(0)
				msg.append("No entry in ") msg.append(app_cfg_file_name) msg.append("for bus_obj_config_file in [business object]")
				log_facility.append_event("ARCHETYPE", "init_bus_obj_config", msg, Error)
			else
				path := clone(app_home_dir_name)
				path.append_character(os_directory_separator)
				path.append(file_name)

				!!msg.make(0)
				!!file.make(path)
	
				if not file.exists then
					msg.append("File ") msg.append(file_name) msg.append(" does not exist")
					log_facility.append_event("ARCHETYPE", "init_bus_obj_config", msg, Error)
				elseif not file.is_readable then
					msg.append("File ") msg.append(file_name) msg.append(" not readable")
					log_facility.append_event("ARCHETYPE", "init_bus_obj_config", msg, Error)
				else
					debug("archetype")
						io.put_string("Reading ") io.put_string(file_name) io.new_line
					end

					-- try to open the file
					from
						file.open_read
					until
						file.end_of_file
					loop
						file.readline

						-- ignore blank lines & comment lines (lines or part 
						-- lines starting with a semicolon)
						linebuf := clone(file.laststring)
						linebuf.left_adjust -- remove leading spaces
						linebuf.right_adjust -- remove trailing white space
						if not linebuf.empty then
							-- see if it is a comment
							if linebuf.item(1) /= bus_obj_file_cmt_char then
								-- must be a real line; strip out in-line comments
								pos := linebuf.index_of(bus_obj_file_cmt_char,1)
								if pos > 0 then
									linebuf.replace_substring("",pos,linebuf.count)
								end

							        -- now have a real line with no comments
							        !!a_desc.make_from_string(linebuf)
							        if not a_desc.is_valid then
								        log_facility.append_event("ARCHETYPE", "init_bus_obj_config", a_desc.invalid_reason, Error)
							        else
									if has_type(a_desc.name) then
										a_rep_unit := rep_unit(a_desc.name)
										a_rep_unit.set_bus_obj_desc(a_desc)
									else
										!!msg.make(0)
										msg.append("REP_ITEM for ") msg.append(a_desc.name) msg.append(" does not exist")
										log_facility.append_event("ARCHETYPE", "init_bus_obj_config", msg, Warning)
									end
								end
							end
						end
					end
					file.close
				end
			end
		end

	init_subtypes is
			-- create subtype relationships in archetype units
			-- FIXME: to be reviewed; needed?
		local
			schema:ODB_SCHEMA
			class_desc:ODB_CLASS_DESCRIPTOR
			parents:ARRAYED_LIST[STRING]
			a_rep_unit, parent_rep_unit:ARCH_REP_UNIT
		do
			from odb_schemas.start until odb_schemas.off loop
				schema := odb_schemas.item_for_iteration
				from schema.classes_start until schema.classes_off loop
					class_desc := schema.classes_item

					-- if schema class has an archetype entry
					if has_type(class_desc.class_name) then
						a_rep_unit := rep_unit(class_desc.class_name)
						parents := class_desc.parents

						-- assume only one parent, and use that; check if it has an archetype entry
						if has_type(parents.first) then
							parent_rep_unit := rep_unit(parents.first)
							a_rep_unit.set_parent_type(parent_rep_unit)
						end
					end
					schema.classes_forth
				end
				odb_schemas.forth 
			end
		end

	init_units is
			-- create and initialise ARCH_XXX_UNITs
		local
			an_info_item:INFO_ITEM
			a_rep_item:REP_ITEM

			a_rep_arch_unit:ARCH_REP_UNIT
		do
			-- create the units-by-name table
			!!rep_units_by_type.make(0)

			from 
			    rep_items.start
			until
			    rep_items.off
			loop
				an_info_item ?= rep_items.item
				a_rep_item ?= rep_items.item

				if an_info_item /= Void then
					!ARCH_INFO_UNIT!a_rep_arch_unit.make(an_info_item, an_info_item.generator)
					a_rep_arch_unit ?= a_rep_arch_unit
					check a_rep_arch_unit /= Void end
	 				rep_units_by_type.put(a_rep_arch_unit, a_rep_arch_unit.description)

				elseif a_rep_item /= Void then
					!ARCH_REP_UNIT!a_rep_arch_unit.make(a_rep_item, a_rep_item.generator)
					a_rep_arch_unit ?= a_rep_arch_unit
					check a_rep_arch_unit /= Void end
	 				rep_units_by_type.put(a_rep_arch_unit, a_rep_arch_unit.description)

				else
					-- SHOULD NEVER GET HERE
				end

				-- all units must have an entry here
				rep_units_by_type.put(a_rep_arch_unit, a_rep_arch_unit.description)
				rep_items.forth
			end

	    end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |            Deep Thought Informatics P/L           |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication and distribution permitted with this  |
--         | notice  intact.  Please send  modifications  and  |
--         | suggestions  to the Deep Thought Informatics, in  |
--         | the  interests  of maintenance  and improvement.  |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+
