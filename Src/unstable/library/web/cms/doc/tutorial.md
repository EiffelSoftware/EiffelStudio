CMS Tutorial
============
[Work in progress]

##### Table of Contents  
[Getting Started](#init)  
[Building your module](#module)  
[Lifecycle](#cycle)  


<a name="init"/>
Getting Started
-------------


<a name="module"/>
Building your own module
------------------------
A [Module](/doc/concepts.md#modules) as we already describe it, enable us to add functionallity based on your needs.

Here we will describe the basics steps to write your own modules.

 * The first thing to do is inherit from the class [CMS_MODULE] () and redefine the register_hooks (2) feature.
 * Implement (via inheritance) the needed [Hooks] (/doc/concepts.md#hooks).
 * Define the module API through route definition. (1)
 * Define the list of block to be handle by the current module (3).
 * Render the block (4) (could be defined in Eiffel itself or using a template file (smarty)). 
 * API implementation (5).
 
```
  class  MY_NEW_MODULE

  inherit

	CMS_MODULE
  		redefine
  			register_hooks
  		end

	CMS_HOOK_BLOCK   

	CMS_HOOK_MENU_SYSTEM_ALTER


 create
  make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			name := "new module"
			version := "1.0"
			description := "Eiffel new module"
			package := "example"
		end

feature -- Access: router

	router (a_api: CMS_API): WSF_ROUTER
			-- (1) Node router.
		do  
			create Result.make (1)
			Result.handle_with_request_methods ("/demo", create {WSF_URI_AGENT_HANDLER}.make (agent handle_demo (a_api, ?, ?)), Result.methods_head_get)
		end

feature -- Hooks

	register_hooks (a_response: CMS_RESPONSE)
		do
		        -- (2)
			a_response.subscribe_to_menu_system_alter_hook (Current)
			a_response.subscribe_to_block_hook (Current)
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
		    --  (3) List of block names, managed by current object.
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
		    --  (4) Get block object identified by `a_block_id' and associate with `a_response'.
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
		do
			create lnk.make ("Demo", "/demo/")
			a_menu_system.primary_menu.extend (lnk)
		end

feature -- Handler

	handle_demo (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE;)
		local
			r: NOT_IMPLEMENTED_ERROR_CMS_RESPONSE
		do
		       -- (5)
			create r.make (req, res, a_api)
			r.set_main_content ("NODE module does not yet implement %"" + req.path_info + "%" ...")
			r.add_error_message ("NODE Module: not yet implemented")
			r.execute
		end

end

```





<a name="cycle"/>
Lifecycle
---------



