indexing
	description: "Abstract description of an .NET class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_CLASS_AS

inherit
	SHARED_TEXT_ITEMS

create
	make

feature {NONE} -- Initialization

	make (a_consumed: CONSUMED_TYPE) is
		require
			a_consumed_not_void: a_consumed /= Void
		do
			class_name := a_consumed.eiffel_name
			dotnet_name := a_consumed.dotnet_name
			constructors := a_consumed.constructors
			entities := a_consumed.flat_entities
			is_deferred := a_consumed.is_deferred or a_consumed.is_interface
			is_frozen := a_consumed.is_frozen
			is_expanded := a_consumed.is_expanded
			initialize (a_consumed)
		ensure
			class_name_set: class_name /= Void
			dotnet_name_set: dotnet_name /= Void
			constructors_set: constructors /= Void
			entities_set: entities /= Void
		end

	initialize (a_consumed: CONSUMED_TYPE) is
			-- Initialize information for Current pertaining to 'a_consumed'.
		require
			a_consumed_not_void: a_consumed /= Void
		do
			set_ancestors (a_consumed)
			set_fields
			set_events
			set_properties
		end

feature -- Access

	class_name: STRING
			-- Class name.

	dotnet_name: STRING
			-- Full .NET name.

	entities: ARRAY [CONSUMED_ENTITY]
			-- All field, procedure and function implemented/inherited.

	constructors: ARRAY [CONSUMED_CONSTRUCTOR]
			-- Class constructors.

	ancestors: ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]
			-- Class ancestors.

	fields: ARRAYED_LIST [CONSUMED_FIELD]
			-- Class fields.

	events: ARRAYED_LIST [CONSUMED_EVENT]
			-- Class events.

	properties: ARRAYED_LIST [CONSUMED_PROPERTY]
			-- Class properties.

	is_expanded: BOOLEAN
			-- Is Current expanded?

	is_deferred: BOOLEAN
			-- Is Current deferred?

	is_frozen: BOOLEAN
			-- Is Current frozen?

	is_short: BOOLEAN
			-- Is Current format type short?

	loop_counter: INTEGER
			-- Reusable loop counter

	ctxt: DOTNET_CLASS_CONTEXT
			-- Associated class context.

feature -- Status report

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

feature -- Status Setting

	set_is_short is
			-- Set format type to short (no inheritance).
		do
			is_short := True
		ensure
			is_short_set: is_short
		end

	set_ancestors (a_consumed: CONSUMED_TYPE) is 
			-- Set all ancestors for the .NET class.
		require
			a_consumed_not_void: a_consumed /= Void
		local
			l_c_parent: CONSUMED_REFERENCED_TYPE
		do
			create ancestors.make (5)
			if a_consumed.parent /= Void then
				ancestors.extend (a_consumed.parent)
			end
			if not a_consumed.interfaces.is_empty then
				from
					loop_counter := 1
				until
					loop_counter = a_consumed.interfaces.count
				loop
					l_c_parent ?= a_consumed.interfaces.item (loop_counter)
					if l_c_parent /= Void then
						ancestors.extend (l_c_parent)
					end
					loop_counter := loop_counter + 1
				end
			end
		ensure
			ancestors_set: ancestors /= Void
		end

	set_fields is
			-- Set the fields for the .NET class.
		local
			l_c_field: CONSUMED_FIELD
		do
			create fields.make (5)
			from
				loop_counter := 1
			until
				loop_counter = entities.count
			loop
				if entities.item (loop_counter).is_field then
					l_c_field ?= entities.item (loop_counter)
					fields.extend (l_c_field)
				end
				loop_counter := loop_counter + 1
			end
		ensure
			fields_set: fields /= Void
		end

	set_events is
			-- Set the events for the .NET class.
		local
			l_c_event: CONSUMED_EVENT
		do
			create events.make (5)
			from 
				loop_counter := 1
			until
				loop_counter = entities.count
			loop
				if entities.item (loop_counter).is_event then
					l_c_event ?= entities.item (loop_counter)
					events.extend (l_c_event)
				end
				loop_counter := loop_counter + 1
			end
		ensure
			events_set: events /= Void
		end

	set_properties is
			-- Set the properties for the .NET class.
		local
			l_c_property: CONSUMED_PROPERTY
		do
			create properties.make (5)
			from
				loop_counter := 1
			until
				loop_counter = entities.count
			loop
				if entities.item (loop_counter).is_property then
					l_c_property ?= entities.item (loop_counter)
					properties.extend (l_c_property)
				end
				loop_counter := loop_counter + 1
			end
		ensure
			properties_set: properties /= Void
		end

feature -- Formatting

	format (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Perform formatting of current using `a_ctxt'.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			a_ctxt.put_front_text_item (ti_Before_class_declaration)
			format_indexes (a_ctxt)
			format_header (a_ctxt)
			format_ancestors (a_ctxt)
			format_constructors (a_ctxt)
			format_features (a_ctxt)
			a_ctxt.new_line
			a_ctxt.put_text_item (ti_Before_class_end)
			a_ctxt.put_text_item (ti_End_keyword)
			a_ctxt.put_text_item (ti_After_class_end)
			a_ctxt.put_text_item (ti_After_class_declaration)
		end

feature {NONE} -- Formatting

	format_indexes (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format indexes, i.e. class description.
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			l_member_info: MEMBER_INFORMATION
			l_summary: LIST [STRING]
		do
			l_member_info := a_ctxt.assembly_info.find_type (dotnet_name)
			a_ctxt.put_text_item (ti_Before_indexing)
			a_ctxt.put_text_item (ti_Indexing_keyword)
			a_ctxt.indent
			a_ctxt.new_line
			a_ctxt.set_separator (Void)
			a_ctxt.set_new_line_between_tokens
			a_ctxt.put_string_item ("description: %"")
			a_ctxt.put_string_item (dotnet_name)
			a_ctxt.put_string_item ("%"")
			a_ctxt.new_line
			a_ctxt.put_string_item ("summary: %"")
			l_summary := a_ctxt.parse_summary (l_member_info.summary)
			from
				l_summary.start
			until
				l_summary.after
			loop
				a_ctxt.put_string_item (l_summary.item)
				l_summary.forth
				if l_summary.after then
					a_ctxt.put_string_item ("%"")
					a_ctxt.new_line
				else
					a_ctxt.new_line
				end
			end
			a_ctxt.put_text_item (ti_After_indexing)
			a_ctxt.exdent
			a_ctxt.new_line
		end

	format_header (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format header, ie classname and generics.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			a_ctxt.put_text_item (ti_Before_class_header)
			if is_expanded then
				a_ctxt.put_text_item (Ti_expanded_keyword)
				a_ctxt.put_space
			end
			if is_deferred then
				a_ctxt.put_text_item (Ti_deferred_keyword)
				a_ctxt.put_space
			elseif is_frozen then
				a_ctxt.put_text_item (Ti_frozen_keyword)
				a_ctxt.put_space
			end
			a_ctxt.put_text_item (ti_Class_keyword)
			a_ctxt.put_space
			a_ctxt.put_text_item (ti_Interface_keyword)
			a_ctxt.indent
			a_ctxt.new_line
			a_ctxt.put_classi (a_ctxt.class_i)
			a_ctxt.put_text_item (ti_After_class_header)
			a_ctxt.exdent
			a_ctxt.new_line
		end

	format_ancestors (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format class ancestors, if short.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			if is_short and ancestors /= Void and not ancestors.is_empty then
				a_ctxt.put_text_item (Ti_before_inheritance)
				a_ctxt.new_line
				a_ctxt.put_text_item (Ti_inherit_keyword)
				a_ctxt.new_line
				a_ctxt.indent
				from
					ancestors.start
				until
					ancestors.after
				loop
					a_ctxt.put_classi (a_ctxt.class_i.type_from_consumed_type (ancestors.item))
					a_ctxt.new_line
					ancestors.forth
				end
				a_ctxt.exdent
			end
		end

	format_constructors (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format constructors.
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			f_constructor: CONSUMED_CONSTRUCTOR
		do
			if not constructors.is_empty then 
				a_ctxt.put_text_item (Ti_before_creators)
				a_ctxt.new_line
				a_ctxt.put_text_item (Ti_create_keyword)
				a_ctxt.new_line
				--a_ctxt.new_line
				from
					loop_counter := 1
				until
					loop_counter > constructors.count
				loop
					f_constructor := constructors.item (loop_counter)
					a_ctxt.set_separator (ti_comma)
					a_ctxt.indent
					a_ctxt.format_feature (f_constructor)
					a_ctxt.exdent
					a_ctxt.new_line
					loop_counter := loop_counter + 1
				end
			end
			a_ctxt.put_text_item (Ti_after_creators)
		end

	format_features (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format all features.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			format_feature_category (a_ctxt, "Initialization")
			format_feature_category (a_ctxt, "Access")
			format_feature_category (a_ctxt, "Status Setting")
			format_feature_category (a_ctxt, "Query")
			format_feature_category (a_ctxt, "Commands")
--			format_feature_category (a_ctxt, "Events")
		end

	format_feature_category (a_ctxt: DOTNET_CLASS_CONTEXT; a_category: STRING) is
			-- Format features in 'a_category'.
		require
			a_ctxt_not_void: a_ctxt /= Void
			a_category_not_void: a_category /= Void
		do
			if a_category.is_equal ("Access") then
				format_access_features (a_ctxt)
			elseif a_category.is_equal ("Initialization") then
				format_initialization_features (a_ctxt)
			elseif a_category.is_equal ("Status Setting") then
				 format_status_setting_features (a_ctxt)
			elseif a_category.is_equal ("Query") then
				format_queries (a_ctxt)
			elseif a_category.is_equal ("Commands") then
				format_commands (a_ctxt)
			elseif a_category.is_equal ("Events") then
				format_events (a_ctxt)
			end
		end

	format_feature_header (a_ctxt: DOTNET_CLASS_CONTEXT; a_header: STRING) is
			-- Format feature for category found in 'a_header'
		require
			a_ctxt_not_void: a_ctxt /= Void
			has_a_header: a_header /= Void
		do
			a_ctxt.new_line
			a_ctxt.put_text_item (Ti_feature_keyword)
			a_ctxt.put_comment_text (" -- " + a_header)
			a_ctxt.new_line
		end

	format_initialization_features (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format 'Initialization' features.
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			not_empty: BOOLEAN
		do
			from
				loop_counter := 1
			until
				loop_counter > constructors.count
			loop
				if not not_empty then
					not_empty := True
					format_feature_header (a_ctxt, "Initialization")
				end
				a_ctxt.format_feature (constructors.item (loop_counter))
				a_ctxt.new_line
				loop_counter := loop_counter + 1
			end
		end

	format_access_features (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format 'Access' features.
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			l_c_function: CONSUMED_FUNCTION
			not_empty: BOOLEAN
		do
			from
				loop_counter := 1
			until
				loop_counter = entities.count
			loop
				l_c_function ?= entities.item (loop_counter)
				if
					(entities.item (loop_counter).is_field) or
					(l_c_function /= Void and 
					(l_c_function.eiffel_name.substring (1, 4).is_equal ("get_") and
					l_c_function.arguments.is_empty))
				then
					if not not_empty then
						not_empty := True
						format_feature_header (a_ctxt, "Access")
					end
					a_ctxt.format_feature (entities.item (loop_counter))
				end
				loop_counter := loop_counter + 1
			end
		end

	format_status_setting_features (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format 'Status Setting' features
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			l_c_procedure: CONSUMED_PROCEDURE
			not_empty: BOOLEAN
		do
			from
				loop_counter := 1
			until
				loop_counter = entities.count
			loop
				l_c_procedure ?= entities.item (loop_counter)
				if
					l_c_procedure /= Void and 
					(l_c_procedure.eiffel_name.substring (1, 4).is_equal ("set_") and 
					l_c_procedure.arguments.count = 1)
				then
					if not not_empty then
						not_empty := True
						format_feature_header (a_ctxt, "Status Setting")
					end
					a_ctxt.format_feature (entities.item (loop_counter))
				end
				loop_counter := loop_counter + 1
			end
		end

	format_queries (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format 'Query' features
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			l_c_function: CONSUMED_FUNCTION
			not_empty: BOOLEAN
		do
			from
				loop_counter := 1
			until
				loop_counter = entities.count
			loop
				l_c_function ?= entities.item (loop_counter)
				if
					l_c_function /= Void and 
					( (l_c_function.eiffel_name.substring (1, 4).is_equal ("get_") or
					(l_c_function.eiffel_name.substring (1, 3).is_equal ("is_")) ) and 
					l_c_function.arguments.count >= 1)
				then
					if not not_empty then
						not_empty := True
						format_feature_header (a_ctxt, "Queries")
					end
					a_ctxt.format_feature (entities.item (loop_counter))
				end
				loop_counter := loop_counter + 1
			end
		end

	format_commands (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format 'Commands' features
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			l_c_procedure: CONSUMED_PROCEDURE
			not_empty: BOOLEAN
		do
			from
				loop_counter := 1
			until
				loop_counter = entities.count
			loop
				l_c_procedure ?= entities.item (loop_counter)
				if
					l_c_procedure /= Void and 
					(l_c_procedure.eiffel_name.substring (1, 4).is_equal ("set_") and 
					l_c_procedure.arguments.count > 1)
				then
					if not not_empty then
						not_empty := True
						format_feature_header (a_ctxt, "Commands")
					end
					a_ctxt.format_feature (entities.item (loop_counter))
				end
				loop_counter := loop_counter + 1
			end
		end

	format_events (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format 'Events' features
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			l_c_entity: CONSUMED_ENTITY
			not_empty: BOOLEAN
		do
			from
				loop_counter := 1
			until
				loop_counter = entities.count
			loop
				l_c_entity ?= entities.item (loop_counter)
				if
					l_c_entity /= Void and 
					l_c_entity.is_property_or_event
				then
					if not not_empty then
						not_empty := True
						format_feature_header (a_ctxt, "Events")
					end
					a_ctxt.format_feature (entities.item (loop_counter))
				end
				loop_counter := loop_counter + 1
			end
		end

invariant
	class_name_not_void: class_name /= Void
	dotnet_name_not_void: dotnet_name /= Void
	constructors_not_void: constructors /= Void
	entities_not_void: entities /= Void
	ancestors_not_void: ancestors /= Void
	fields_not_void: fields /= Void
	properties_not_void: properties /= Void
	events_not_void: events /= Void

end -- class DOTNET_CLASS_AS
