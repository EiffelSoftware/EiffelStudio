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
			dotnet_name := a_consumed.dotnet_name
			entities := a_consumed.flat_entities
			is_deferred := a_consumed.is_deferred or a_consumed.is_interface
			is_frozen := a_consumed.is_frozen
			is_expanded := a_consumed.is_expanded
			initialize (a_consumed)
		ensure
			dotnet_name_set: dotnet_name /= Void
			entities_set: entities /= Void
			deferred_set: is_deferred implies (a_consumed.is_deferred or a_consumed.is_interface)
		end

	initialize (a_consumed: CONSUMED_TYPE) is
			-- Initialize information for Current pertaining to 'a_consumed'.
		require
			a_consumed_not_void: a_consumed /= Void
		do
			set_constructors (a_consumed)
			set_ancestors (a_consumed)
			initialize_feature_categories
		end

	initialize_feature_categories is
			-- Initialize the features by category for formatting.
		do
			create access_features.make (5)
			create status_setting_features.make (5)
			create query_features.make (5)
			create command_features.make (5)
			create events_features.make (5)
			create hidden_features.make (5)
			from
				loop_counter := 1
			until
				loop_counter = entities.count
			loop
				if entities.item (loop_counter).is_event_type then
					events_features.extend (entities.item (loop_counter))
				elseif entities.item (loop_counter).is_hidden_type then
					hidden_features.extend (entities.item (loop_counter))
				elseif entities.item (loop_counter).is_access_type then					
					access_features.extend (entities.item (loop_counter))
				elseif entities.item (loop_counter).is_status_setting_type then
					status_setting_features.extend (entities.item (loop_counter))
				elseif entities.item (loop_counter).is_query_type then
					query_features.extend (entities.item (loop_counter))
				elseif entities.item (loop_counter).is_command_type then
					command_features.extend (entities.item (loop_counter))
				else
					if misc_features = Void then
						create misc_features.make (5)
					end
					misc_features.extend (entities.item (loop_counter))
				end
				loop_counter := loop_counter + 1
			end
			ensure
				feature_lists_not_void: access_features /= Void and
					status_setting_features /= Void and
					query_features /= Void and 
					command_features /= Void and 
					events_features /= Void and 
					hidden_features /= Void
		end
		
	set_constructors (a_consumed: CONSUMED_TYPE) is
			-- Set all constrcutor for the .NET class.
		require
			a_consumed_not_void: a_consumed /= Void
		do
			create constructors.make (5)
			if not a_consumed.constructors.is_empty then
				from
					loop_counter := 1
				until
					loop_counter > a_consumed.constructors.count
				loop
					constructors.extend (a_consumed.constructors.item (loop_counter))
					loop_counter := loop_counter + 1
				end
			end
		ensure
			constructors_set: constructors /= Void
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
					loop_counter > a_consumed.interfaces.count
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

feature {NONE} -- Access

	dotnet_name: STRING
			-- Full .NET name.

	is_expanded: BOOLEAN
			-- Is Current expanded?

	is_deferred: BOOLEAN
			-- Is Current deferred?

	is_frozen: BOOLEAN
			-- Is Current frozen?

	is_short: BOOLEAN
			-- Is Current format type short?

feature -- Status Setting

	set_is_short is
			-- Set format type to short (no inheritance).
		do
			is_short := True
		ensure
			is_short_set: is_short
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
					constructors.start
				until
					constructors.after
				loop
					f_constructor := constructors.item
					a_ctxt.set_separator (ti_comma)
					a_ctxt.indent
					a_ctxt.format_feature (f_constructor)
					a_ctxt.exdent
					a_ctxt.new_line
					constructors.forth
				end
			end
			a_ctxt.put_text_item (Ti_after_creators)
		end

	format_features (a_ctxt: DOTNET_CLASS_CONTEXT) is
			-- Format all features.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			format_feature_category (a_ctxt, constructors, " -- Initialization")
			format_feature_category (a_ctxt, access_features, " -- Access")
			format_feature_category (a_ctxt, status_setting_features, " -- Status Setting")
			format_feature_category (a_ctxt, query_features, " -- Query")
			format_feature_category (a_ctxt, command_features, " -- Commands")
			format_feature_category (a_ctxt, events_features, " -- Events (To do: NC)")
			format_feature_category (a_ctxt, hidden_features, " {NONE} -- Implementation")
		end

	format_feature_header (a_ctxt: DOTNET_CLASS_CONTEXT; a_header: STRING) is
			-- Format feature for category found in 'a_header'
		require
			a_ctxt_not_void: a_ctxt /= Void
			has_a_header: a_header /= Void
		do
			a_ctxt.new_line
			a_ctxt.put_text_item (Ti_feature_keyword)
			a_ctxt.put_comment_text (a_header)
			a_ctxt.new_line
		end

	format_feature_category (a_ctxt: DOTNET_CLASS_CONTEXT; a_category_list: ARRAYED_LIST [CONSUMED_ENTITY]; 
		a_category_name: STRING) is
			-- Format features in 'a_category_list' with heading 'a_category_name'.
		require
			a_ctxt_not_void: a_ctxt /= Void
			a_category_list_not_void: a_category_list /= Void
			a_category_name_not_void: a_category_name /= Void
		do
			if not a_category_list.is_empty then
				format_feature_header (a_ctxt, a_category_name)
				from
					a_category_list.start
				until
					a_category_list.after
				loop
					a_ctxt.format_feature (a_category_list.item)
					a_category_list.forth
				end
			end
		end

feature {NONE} -- Implementation

	entities: ARRAY [CONSUMED_ENTITY]
			-- All field, procedure and function implemented/inherited.

	constructors: ARRAYED_LIST [CONSUMED_CONSTRUCTOR]
			-- Class constructors.

	ancestors: ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]
			-- Class ancestors.

	access_features,
	status_setting_features,
	query_features,
	command_features,
	events_features,
	hidden_features,
	misc_features: ARRAYED_LIST [CONSUMED_ENTITY]
			-- Class features by category.

	loop_counter: INTEGER
			-- Reusable loop counter

	ctxt: DOTNET_CLASS_CONTEXT
			-- Associated class context.

invariant
	dotnet_name_not_void: dotnet_name /= Void
	constructors_not_void: constructors /= Void
	entities_not_void: entities /= Void
	ancestors_not_void: ancestors /= Void

end -- class DOTNET_CLASS_AS
