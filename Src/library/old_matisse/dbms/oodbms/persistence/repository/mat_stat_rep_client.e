indexing
    description: "Static database client for MATISSE repository. Each %
                 %instance corresponds obtains the entire contents of the%
                 %object stream, once only on initialisation, and stores%
                 %the result locally. All subsequent access is from the%
                 %local storage; no modification is allowed."
    keywords:    "database, repository, matisse"
    revision:    "%%A%%"
    source:      "%%P%%"
	copyright:    "See notice at end of class"

class MAT_STAT_REP_CLIENT

inherit
	STAT_REP_CLIENT
		rename
			make as stat_client_make
		undefine
			index_names
		end

	MAT_REP_CLIENT
		rename
			make as mat_client_make
		end

creation
	make

feature -- Initialisation
	make(a_ref_item:like ref_item; a_rep_name:STRING)  is
		do
			-- make rep client
			rep_client_make(a_ref_item, a_rep_name)

			-- Matisse initialisation
			mat_client_make

			-- Static client initialisation
			stat_client_make

			-- populate the internal storage
			populate(Void)
		end

feature -- Implementation
	populate_source(a_source: like source) is
			-- one-off query to Matisse database to get all items
		local
			i: INTEGER
			mt_obj:MT_OBJECT
			key_attribute:MT_ATTRIBUTE
			key_value:STRING
			an_ext_storable:EXT_STORABLE
			limit_counter:STREAM_COUNTER
			idf_table_oid:INTEGER_REF
			a_rep_item: like ref_item
			msg:STRING
			class_desc:ODB_CLASS_DESCRIPTOR
		do
			-- make internal storage
			!!source.make

			start_transaction("populate_source")
			start_query(True)

			-- set index criteria depending on direction
			index_start_criteria.put(First_key,1)
			index_end_criteria.put(Last_key,1)

			-- set the limit counter up and attach it to the selection object
			!!limit_counter.make(sanity_limit)
			selection.set_action(limit_counter)

			-- PERFORM QUERY
			stream.execute(selection)
			!!stream_result.make
			selection.set_container(stream_result)

			-- LOAD the RESULTS
			if selection.is_ok then
				selection.load_result    -- also closes the index stream
	
				if not stream_result.empty then
					from 
						stream_result.start 
					until 
						stream_result.off or last_op_fail
					loop
						mt_obj ?= stream_result.item.data
						if mt_obj /= Void then
							class_desc := odb_schema.class_descriptor_by_name(rep_class.name)
							!!key_attribute.make(class_desc.db_field_name("stored_table_id"))
							idf_table_oid ?= key_attribute.value(mt_obj)
							check Result_oid_exists: idf_table_oid /= Void end
							if idf_table_oid.item > 0 then
								!!an_ext_storable
								an_ext_storable ?= an_ext_storable.retrieve(idf_table_oid.item)
						    		if an_ext_storable  /= Void then
									a_rep_item ?= an_ext_storable
									check Result_is_info_item: a_rep_item /= Void end

									-- add to local storage
									source.extend(a_rep_item)
								else
									set_fail_reason("populate_source: retrieved object exists but not an REP_ITEM")
								end
							else
							    set_fail_reason("populate_source: retrieved object exists but has not IDF_TABLE")
							end
						else
							set_fail_reason("populate_source: Void object returned")
						end
						stream_result.forth
					end
				else
					msg := "populate_source: no objects returned between keys <"
					msg.append(First_key) msg.append("> and <")
					msg.append(Last_key) msg.append(">")
					set_fail_reason(msg)
				end
			else
				build_fail_reason("Make", "selection not ok", rep_session.error_message,rep_session.error_code)
			end

			end_transaction("populate_source")
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
