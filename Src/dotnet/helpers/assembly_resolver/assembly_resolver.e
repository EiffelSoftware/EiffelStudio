indexing
       description: "Objects that ..."
       date: "$Date$"
       revision: "$Revision$"

class
       ASSEMBLY_RESOLVER

create
       make,
       make_with_app_domain

feature {NONE} -- Initialization

       make is
                       -- create new resolver
               do
                       create app_domains.make (1)
               end

       make_with_app_domain (a_domain: APP_DOMAIN) is
                       -- create new resolver then add `a_domain'
               require
                       a_domain_not_void: a_domain /= Void
                       not_a_domain_is_unloading: not a_domain.is_finalizing_for_unload
               do
                       make
                       resolve_for_app_domain (a_domain)
               end

feature -- Basic Operations

       resolve_for_app_domain (a_domain: APP_DOMAIN) is
                       -- start resolving references for app domain `a_domain'
               require
                       a_domain_not_void: a_domain /= Void
                       not_a_domain_is_unloading: not a_domain.is_finalizing_for_unload
                       not_is_resolving_app_domain: not is_resolving_app_domain (a_domain)
               do
                       app_domains.extend (a_domain)
                       app_domains.add_assembly_load ($on_assembly_load)
                       app_domains.add_domain_unload ($on_domain_unload
               ensure
                       is_resolving_app_domain: is_resolving_app_domain (a_domain)
               end

       stop_resolving_for_app_domain (a_domain: APP_DOMAIN) is
                       -- stop resolving references for app domain `a_domain'
               require
                       a_domain_not_void: a_domain /= Void
                       is_resolving_app_domain: is_resolving_app_domain (a_domain)
               do
                       app_domains.remove (a_domain)
               ensure
                       not_is_resolving_app_domain: not is_resolving_app_domain (a_domain)
               end

feature -- Query

       is_resolving_app_domain (a_domain: APP_DOMAIN) is
                       -- is `Current' resolving `a_domain'?
               require
                       a_domain_not_void: a_domain /= Void
               do
                       Result := app_domain.has (a_domain)
               end

feature {NONE} -- Event Handlers

       on_domain_unload (a_sender: SYSTEM_OBJECT; a_args: EVENT_ARGS) is
                       -- handles event when an app domain is about to be unloaded
               require
                       a_sender_not_void: a_sender /= Void
               local
                       l_domain: APP_DOMAIN
               do
                       l_domain ?= a_sender
                       stop_resolving_for_app_domain (l_domain)
               end

       on_assembly_load (sender: SYSTEM_OBJECT; a_args: RESOLVE_EVENT_ARGS) is
                       -- handles event when an app domain failed to load an assembly using
                       -- default loading policy.
               require
                       a_sender_not_void: a_sender /= Void
                       a_args_not_void: a_args /= Void
               do
                       --| TODO: Add implementation
               end

feature {NONE} -- Implementation

       add_self_to_resolver is
                       -- add type hosting assembly to resolver.
                       -- This is primararly for COM interop issues.
               local
                       l_asm: ASSEMBLY
                       l_path: STRING
                       l_full_name: STRING
               do
                       l_asm := to_dotnet.get_type.assembly
                       l_path := l_asm.location
                       l_full_name := l_asm.full_name
               end

       assembly_path_table: HASH_TABLE [ASSEMBLY, STRING]
                       -- path/display name mappings for assemblies

       app_domains: ARRAYED_LIST [APP_DOMAIN]
                       -- app domains reolver is attached to

invariant
       app_domains_not_void: app_domain /= Void

end -- class ASSEMBLY_RESOLVER